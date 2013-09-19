function generate_ruby_katcp_class(sys, varargin)
% Generate a Ruby/KATCP class for a CASPER model.
% The simplest use is to just pass the top level system using gcs or bdroot:
%
%   generate_ruby_katcp_class(gcs);
%   generate_ruby_katcp_class(bdroot);
%
% The default behavior is to write a file named "<model_name>.rb" that contains
% a Ruby/KATCP class with a custom typemap derived from the deisng's yellow
% blocks.  The name of the class is the model name converted to CamelCase.  The
% class is defined inside the "Casper" module.
%
% Name/value option pairs may also be passed to customize various aspects of
% the generated Ruby class.  The following options are supported:
%
%   filename - Name of the file to generate.
%   requires - Cell array of names that the class will "require".
%   modulename - Name of the module that will contain the class.
%   classname - Name of the generated class.
%   superclass - Superclass of the generated class.
%
% Using a custom "requires" and/or "superclass" is for experts only.
%
% Example using custom module and class name:
%
% generate_ruby_katcp_class(gcs, 'modulename', 'MyModule', ...
%                                'classname',  'MyClass');
%
% That will generate the class "MyClass" inside the modeul "MyModule".

  % Make sure we've been given a block_diagram
  if ~strcmp(get_param(sys, 'Type'), 'block_diagram')
      error('%s is not a block diagram', sys)
  end

  % Get metadata about system
  model_filename = regexprep(get_param(sys, 'FileName'), '^.*/', '');
  model_lastmod_date = get_param(sys, 'LastModifiedDate');
  model_version = get_param(sys, 'ModelVersion');
  model_dirty = get_param(sys, 'Dirty');
  if isempty(model_filename)
      model_filename = '(untitled)';
  end

  % Setup default options

  % Convert default classname to CamelCase
  default_classname = clear_name(sys);
  uu = [0, strfind(default_classname, '_')];
  default_classname(uu+1) = upper(default_classname(uu+1));
  default_classname = strrep(default_classname, '_', '');

  opts = struct( ...
        'filename', [clear_name(sys), '.rb'], ...
        'requires', {{'rubygems', 'katcp'}}, ...
        'modulename', 'Casper', ...
        'classname', default_classname, ...
        'superclass', 'KATCP::RoachClient' ...
  );

  % Make sure cells in varargin are doubly celled so that the conversion to
  % struct works OK.
  for k=1:length(varargin)
    if iscell(varargin{k}) && ~iscell(varargin{k}{1})
      varargin{k} = {varargin{k}};
    end
  end
  user_opts = struct(varargin{:});

  % User-supplied options override defaults
  fields = fieldnames(user_opts);
  for k=1:length(fields)
      f = fields{k};
      if isfield(opts, f)
          opts = setfield(opts, f, getfield(user_opts, f));
      else
          warning('ignoring unsupported option: %s', f);
      end
  end

  % Make sure module and class names start with uppercase
  opts.modulename(1) = upper(opts.modulename(1));
  opts.classname(1) = upper(opts.classname(1));

  typemap = {};
  
  % Find all "yellow blocks"
  ybs = sort(find_system(sys, ...
      'FollowLinks', 'on', ...
      'LookUnderMasks', 'all', ...
      'RegExp', 'on', ...
      'Tag', 'xps:'));

  % Iterate over list and determine the "type" of each block.  Blocks that are
  % "ignored" do not appear in typemap.  Block's that are "skipped" appear in
  % the typemap with type ":skip" so no methods will be dynamically created for
  % them.
  for k = 1:length(ybs)
      b = ybs{k};
      devname = clear_name(regexprep(b, '^\w*/', ''));
      tag = get_param(b, 'Tag');
      parent = get_param(b, 'Parent');

      % Is this block inside a snapshot block?
      is_snap = 0;
      if strcmp(get_param(parent, 'Type'), 'block')
          is_snap = strcmp(get_param(parent, 'MaskType'), 'snapshot');
      end

      % Tag-specific handling
      switch tag
          % Software register
          case 'xps:sw_reg'
              % If this block is in a snapshot block, skip it
              is_snap = 0;
              try
                  is_snap = strcmp(get_param(parent, 'MaskType'), 'snapshot');
              end
              if is_snap
                  type = ':skip';
              elseif strcmp(get_param(b, 'io_dir'), 'From Processor')
                  type = ':rwreg';
              else
                  type = ':roreg';
              end

          % Shared BRAM and DRAM
          case {'xps:bram', 'xps:dram'}
              % If this block is in a snapshot block, set type to :snap
              is_snap = 0;
              try
                  is_snap = strcmp(get_param(parent, 'MaskType'), 'snapshot');
              end
              if is_snap
                  type = ':snap';
              else
                  type = ':bram';
              end

          % QDR
          case 'xps:qdr'
              % Add qdrN_ctrl device
              chip = get_param(b, 'which_qdr');
              typemap{end+1} = sprintf('%s_ctrl', chip);
              typemap{end+1} = ':qdrctrl';
              %% Treat as BRAM if CPU interface is enabled, otherwise skip
              %if strcmp(get_param(gcb, 'use_sniffer'), 'on')
              %    type = ':bram';
              %else
              %    type = ':skip';
              %end
              % Always treat as BRAM (even if CPU interface is disabled?!)
              devname = sprintf('%s_memory', chip);
              type = ':bram';

          % Ethernet cores (all use :tenge for now)
          case {'xps:onegbe', 'xps:tengbe', 'xps:tengbe_v2'}
              type = ':tenge';

          % adc16
          case 'xps:adc16'
              % Change katcp require to adc16
              opts.requires{strcmp(opts.requires, 'katcp')} = 'adc16';
              opts.superclass = 'ADC16';
              continue

          % Specific block tags to ignore
          case {'xps:xsg', 'xps:pcore', 'xps:gpio', 'xps:block_name'}
              % Ignore
              continue

          otherwise
              % Ignore unknown adc blocks
              if regexp(tag, 'xps:adc')
                  continue;
              end

              % Ignore unknown dac blocks
              if regexp(tag, 'xps:dac')
                  continue;
              end

              fprintf('defaulting %s to rwreg\n', devname);
              type = ':rwreg';
      end

      % Add to typemap
      typemap{end+1} = devname;
      typemap{end+1} = type;
  end

  % Add system infrastructure registers
  typemap{end+1} = 'sys_board_id';
  typemap{end+1} = ':roreg';
  typemap{end+1} = 'sys_clkcounter';
  typemap{end+1} = ':roreg';
  typemap{end+1} = 'sys_rev';
  typemap{end+1} = ':roreg';
  typemap{end+1} = 'sys_rev_rcs';
  typemap{end+1} = ':roreg';
  typemap{end+1} = 'sys_scratchpad';
  typemap{end+1} = ':rwreg';

  % Create output file
  f = fopen(opts.filename, 'w');

  % Output metadata comments
  fprintf(f, '# Generated on %s\n', datestr(now, 'yyyy-mm-dd HH:MM:SS'));
  fprintf(f, '#\n');
  fprintf(f, '#   Model File    : %s\n', model_filename);
  fprintf(f, '#   Model Version : %s', model_version);
  if strcmp(model_dirty, 'on')
      fprintf(f, ' (dirty)');
  end
  if model_lastmod_date
      fprintf(f, '\n#   Last Modified : %s', model_lastmod_date);
  end
  fprintf(f, '\n\n');

  % Requires
  for k=1:length(opts.requires)
      % If katcp, make sure we use version 0.1.10 or newer
      if strcmp(opts.requires{k}, 'katcp')
          fprintf(f, 'gem ''%s'', ''~> 0.1.10''\n', opts.requires{k});
      end
      fprintf(f, 'require ''%s''\n', opts.requires{k});
  end
  fprintf(f, '\n');

  % Open module
  fprintf(f, '# Using a module helps prevent namespace collisions.\n');
  fprintf(f, 'module %s\n\n', opts.modulename);

  % Open class
  fprintf(f, '  # A Ruby/KATCP class for the CASPER-based %s design.\n', sys);
  fprintf(f, '  class %s < %s\n\n', opts.classname, opts.superclass);

  % DEVICE_TYPEMAP
  fprintf(f, '    # The DEVICE_TYPEMAP Hash guides dynamic method creation.\n', sys);
  fprintf(f, '    DEVICE_TYPEMAP = superclass::DEVICE_TYPEMAP.merge({\n');
  width = max(cellfun('length', typemap));
  for k=1:length(typemap)/2
      if k > 1
          fprintf(f, ',\n');
      end
      fprintf(f, '      :%-*s => %s', width, typemap{2*k-1}, typemap{2*k});
  end
  fprintf(f, '\n    }) # :nodoc:\n\n');

  % device_typemap method
  fprintf(f, '    # The superclass calls this to get our device typemap.\n');
  fprintf(f, '    def device_typemap # :nodoc:\n');
  fprintf(f, '      @device_typemap ||= DEVICE_TYPEMAP.dup\n');
  fprintf(f, '    end\n\n');

  % Placeholder for user-defined methods
  fprintf(f, '    # Add custom methods here...\n\n');

  % Close class and module
  fprintf(f, '  end # class %s\n', opts.classname);
  fprintf(f, 'end # module %s\n', opts.modulename);

  % Close file
  fclose(f);
end % function
