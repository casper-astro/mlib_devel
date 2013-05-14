%generate script to draw system specified
% 
%usage: function mld2m(mdl, varargin)
%mdl 		- model to convert
%varargin	- 'name', value pairs where name can be;
%  script_name	  - name of initialization script ([.../casper_library/<model_name>_init.m])
%  mode		  - mode to open initialization script in ('a'-append, ['w']-overwrite)
%  file		  - pass file pointer (created with fopen) directly
%  subsystem      - the system is a subsystem (so don't generate system parameters etc) ('on', ['off'])
%  reuse          - generated script uses reuse_block instead of add_block for more efficient drawing 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   MeerKAT Radio Telescope Project                                           %
%   www.kat.ac.za                                                             %
%   Copyright (C) 2013 Andrew Martens (meerKAT)                               %
%                                                                             %
%   This program is free software; you can redistribute it and/or modify      %
%   it under the terms of the GNU General Public License as published by      %
%   the Free Software Foundation; either version 2 of the License, or         %
%   (at your option) any later version.                                       %
%                                                                             %
%   This program is distributed in the hope that it will be useful,           %
%   but WITHOUT ANY WARRANTY; without even the implied warranty of            %
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             %
%   GNU General Public License for more details.                              %
%                                                                             %
%   You should have received a copy of the GNU General Public License along   %
%   with this program; if not, write to the Free Software Foundation, Inc.,   %
%   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.               %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function mdl2m(mdl, varargin)
    
  base = 'getenv(''MLIB_DEVEL_PATH''), ''/casper_library/''';
  name = get_param(mdl, 'name');
  defaults = { ...
    'script_name', [eval(['[',base,']']), name, '_init'], ...           
    'mode', 'w', ...                                           
    'subsystem', 'off', ...
    'file', -1, ...
  };
  script_name     = get_var('script_name', 'defaults', defaults, varargin{:});
  m               = get_var('mode', 'defaults', defaults, varargin{:});
  fp              = get_var('file', 'defaults', defaults, varargin{:});
  mdl_name        = [base, ', ''', name, ''''];
  library         = get_var('library', 'defaults', defaults, varargin{:});
  subsystem       = get_var('subsystem', 'defaults', defaults, varargin{:});
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % get necessary system parameters %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  if strcmp(subsystem, 'off'),
    lt = get_param(mdl, 'LibraryType');
    if strcmp(lt, 'BlockLibrary'),
      library = 'on';
    else
      library = 'off';
    end

    clog(['getting system parameter values for ''',mdl,''''],'mdl2m_debug'); 
    required_sys_params = ...
        { ...
        'Name', ...
        'LibraryType', ...  %is this a library?
        'Lock', ...         %locked library
	'PreSaveFcn', ...   %things to do before saving
        'SolverName', ...   %simulation type
        'SolverMode', ...   %
        'StartTime', ...    %simulation start time
        'StopTime', ...     %simulation stop time
        };
    sys_params = get_params(mdl, required_sys_params);
  else,
    library = 'off';
    clog(['skipping getting parameter values for ''',mdl,''''],'mdl2m_debug'); 
  end

  %%%%%%%%%%%%%
  % open file %
  %%%%%%%%%%%%%
  
  if fp == -1,
    ntc = 1;                                       %need to close file after
    clog(['opening ''',script_name,''''],'mdl2m_debug');
    fp = fopen([script_name,'.m'],m);
    if fp == -1,
      clog(['error opening ''',script_name,''''],{'error', 'mdl2m_debug'});
      error(['error opening ''',script_name,'''']);
      return;
    end
  else
    ntc = 0;
  end   

  tokens = regexp(script_name, '/', 'split');
  f_name = tokens{length(tokens)};

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % set up top level function %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  if strcmp(subsystem, 'off'),
    fprintf(fp,'function %s()\n',f_name);     
  else,
    fprintf(fp,'function %s(blk)\n',f_name);     
  end
    fprintf(fp, '\n');    

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % generate creation of new system %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  if strcmp(subsystem, 'off'),
    clog(['setting up creation of new system ''',mdl,''''],'mdl2m_debug'); 

    if strcmp(library, 'on'), sys_type = 'Library'; else, sys_type = 'Model'; end
    fprintf(fp,'\twarning off Simulink:Engine:MdlFileShadowing;\n');        
    fprintf(fp,'\tmdl = new_system(''%s'', ''%s'');\n', name, sys_type);  %create a new system    
    fprintf(fp,'\tblk = get(mdl,''Name'');\n');                           %get the name for future use
    fprintf(fp,'\twarning on Simulink:Engine:MdlFileShadowing;\n');        
    fprintf(fp,'\n');     
  else, 
    clog(['configuring ''',mdl,'''...'],'mdl2m_debug'); 
  end
 
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % generate logic to draw blocks in system %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  %find all blocks in top level of system
  blks = find_system(mdl, 'SearchDepth', 1, 'LookUnderMasks', 'on', 'FollowLinks', 'on', 'type', 'block');

  %if a subsystem have to exclude first entry
  if strcmp(subsystem,'on'),
    if length(blks) > 1,
      clog(['excluding top block as subsystem'],'mdl2m_debug'); 
      blks = blks(2:length(blks));
    else,
      %empty blocks
      blks = {};
    end
  end

  %place in order of processing (will determine order of blocks in text file)
  [blks, indices] = sort_blocks(blks, 'default'); 

  clog(['adding block generation logic for ',num2str(length(blks)),' blocks'],'mdl2m_debug'); 
  if strcmp(library,'on'), reuse = 'off';
  else reuse = 'on';
  end
  add_blocks(blks, fp, reuse);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % generate logic to draw lines in system %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  sys_lines = get_param(mdl, 'Lines');
  [sys_lines, indices] = sort_lines(sys_lines, 'default');

  clog(['adding line generation logic for ',num2str(length(sys_lines)),' lines'],'mdl2m_debug'); 
  for line_index = 1:length(sys_lines),
    line = sys_lines(line_index);
    add_line(line, fp);
  end
 
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % generate logic to set up system parameters %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  if strcmp(subsystem, 'off'),
    clog(['adding system parameters for ',mdl],'mdl2m_debug'); 
    set_params(fp, 'blk', sys_params, 'no_empty'); 
  else,
    clog(['skipping addition of system parameters for ',mdl,' as a subsystem'],'mdl2m_debug'); 
  end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % finalise generation logic %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  %if a library, must be saved somewhere before can be used
  if strcmp(library, 'on'),
      fprintf(fp, '\tsave_system(mdl,[%s]);\n', mdl_name);
  end
  
  fprintf(fp,'end %% %s\n\n',f_name);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % generate functions to generate blocks %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  clog(['appending block generation functions'],'mdl2m_debug'); 
  gen_blocks('blks', blks, 'file', fp);

  if ntc == 1, 
    result = fclose(fp); 
    if result ~= 0, clog(['error closing file ',script_name],{'mdl2m_debug', 'error'}); end
  end 
end %mdl2m

%function to sort blocks into order they will appear in system generation script
%strategy can be 'name', 'default'
function[blocks, indices] = sort_blocks(blocks_in, strategy)
  %default is input ports first, then position from top left corner, then output ports
  if strcmp(strategy,'default'),
    %go through finding inports, outports, and position info
    inports = {}; outports = {}; remainder = {};
    inport_indices = []; outport_indices = []; remainder_indices = []; 
    remainder_distances = [];
    for index = 1:length(blocks_in),
      blk = blocks_in{index};
      type = get_param(blk, 'BlockType');

      if strcmp(type, 'Inport'),
        inport_indices = [inport_indices, index];
      elseif strcmp(type, 'Outport'),
        outport_indices = [outport_indices, index];
      else,
        remainder_indices = [remainder_indices, index];
        position = get_param(blk, 'Position');
        %distance from top left to centre of block
        remainder_distances = [remainder_distances, sqrt(((position(3) + position(1))/2)^2+((position(4) + position(2))/2)^2)]; 
      end %if
    end %for

    %now sort remainder_distances, finding indices
    [temp, sorted_indices] = sort(remainder_distances);

    %construct final vector of blocks and indices
    indices = [inport_indices, remainder_indices(sorted_indices), outport_indices];
    blocks = {blocks_in{indices}};

  %alphabetically by name
  elseif strcmp(strategy, 'name'),
    blocks = sort(blocks_in);
  else,
    clog(['unknown sort strategy ''',strategy,''''],{'mdl2m_debug','sort_blocks_debug', 'error'}); 
    error(['unknown sort strategy ''',strategy,'''']); 
  end
end %sort_blocks

%function to sort lines into order they will appear in system generation script
%strategy can be 'default', 'name' and is based on line source
function[lines_out, indices] = sort_lines(lines_in, strategy)

  %go through all lines finding blocks associated with source of lines
  blocks_in = {};
  for index = 1:length(lines_in),
    line = lines_in(index);
    srcblk = line.SrcBlock;
    %sanity check
    if isempty(srcblk),
      clog(['sanity check error: no SrcBlk for start of line!'],{'mdl2m_debug','sort_lines_debug', 'error'}); 
      error(['sanity check error: no SrcBlk for start of line!']); 
    end %if

    blocks_in = {blocks_in{:}, srcblk};
  end %for

  %sort source blocks with specified strategy
  [blocks, indices] = sort_blocks(blocks_in, strategy);

  %rearrange lines according to sort results
  lines_out = lines_in(indices);

end %sort_lines

%logic to add block to system
%blks = blocks to be added, fp = file pointer, reuse = use reuse_block instead of add_block
function add_blocks(blks, fp, reuse)
  
  %go through and process all blocks
  for index = 1:length(blks),
    blk = blks{index};
    name        = get_param(blk, 'Name');
    sls         = get_param(blk, 'StaticLinkStatus'); %library block or not (and does not update out-of-date linked blocks)
    block_type  = get_param(blk, 'BlockType');        %for built-in blocks
    anc_block   = get_param(blk, 'AncestorBlock');    %AncestorBlock (for disabled library links)

    position    = get_param(blk, 'Position');         %once added, we put the block in the correct place
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % block not from any library (i.e built-in), %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if strcmp(sls, 'none'), 
      src = ['built-in/',block_type];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % contained in a library block %     
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    elseif strcmp(sls, 'implicit'),
      %if we are generating a library block, then the link to itself is not useful so ignore ReferenceBlock

      %asssume use of original library block (AncestorBlock) if implicit library block with AncestorBlock
      if ~isempty(anc_block)
        src = anc_block;
        clog(['assuming ok to use ', src,' for ',name,' with disabled link'],{'add_lib_blocks_debug', 'mdl2m_debug'}); 
      else,         
        src = ['built-in/',block_type];
      end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % library block, link resolved %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    elseif strcmp(sls, 'resolved'), 
      src = get_param(blk, 'ReferenceBlock');   %for library blocks without disabled links
      
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % library block, link disabled %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    elseif strcmp(sls, 'inactive'), 
        src = anc_block; %for library blocks with disabled (but not broken) links
        clog(['assuming ok to use ', src,' for ',name,' with disabled link'],{'add_lib_blocks_debug', 'mdl2m_debug'}); 
      % link to library block that we can't figure out
    elseif strcmp(sls, 'unresolved'),
      clog(['can''t find library source for ',name,' with ''unresolved'' StaticLinkStatus'],{'error', 'add_blocks_debug', 'mdl2m_debug'}); 
      error(['can''t find library source for ',name,' with ''unresolved'' StaticLinkStatus']); 
      return; 
    else,
      clog(['don''t know what to do with a ',sls,' StaticLinkStatus for ',name],{'error', 'add_blocks_debug', 'mdl2m_debug'}); 
      error(['don''t know what to do with a ',sls,' StaticLinkStatus for ',name]);
      return; 
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % make block of required type %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
    clog(['instantiating ',name,' of type ''',src,''''], {'add_blocks_debug', 'mdl2m_debug'});
    if strcmp(reuse, 'on'), 
      func = sprintf('reuse_block(blk, ''%s'', ''%s'');',name, src);
    else 
      func = sprintf('add_block(''%s'', [blk,''/%s'']);', src, name);
    end
  
    fprintf(fp, '\t%s\n', func);                 

    dialog_param_strategy = 'default';      %by default look at differences and include/exclude certain parameters
    %built-in or (implicit library block but not from original library block)
    if strcmp(sls, 'none') || (strcmp(sls, 'implicit') && isempty(anc_block)), 
      %block is of type SubSystem so needs to be generated
      if strcmp(block_type,'SubSystem'),
        if strcmp(get_param(blk, 'Mask'), 'on'),
          dialog_param_strategy = 'all';      %take all dialog parameters if subsystem to be generated has a mask
        else,
          dialog_param_strategy = 'none';
        end
        clog(['generating logic to generate ''',name,''' block from SubSystem base'], {'add_blocks_debug', 'mdl2m_debug'}); 
      
        fprintf(fp, '\t%s_gen([blk,''/%s'']);\n', name, name);                          %call block generation logic
      end
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % set up mask parameter values %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    required_params = determine_dialog_params(blk, src, dialog_param_strategy);
    clog(['setting up required dialog parameters for ',name], {'add_blocks_debug', 'mdl2m_debug'});
    params = get_params(blk, required_params); 
    set_params(fp, ['[blk,''/',name,''']'], {params{:}, 'Position', position}, 'all'); %appending Position guarantees at least one param
    fprintf(fp,'\n');

  end %for index
end %add_blocks

%determine which dialog parameters need to be set up for the specified block
%strategy can be 'default', 'all', 'delta', 'none'
function[params] = determine_dialog_params(blk, src, strategy)

  dp = get_param(blk, 'DialogParameters');

  if ~isempty(dp),
    all_params = fieldnames(dp);
  else
    all_params = {};
  end
  
  %set parameter values for all parameters
  if strcmp(strategy,'none'),
    params = {};
  elseif strcmp(strategy,'all'),
    params = all_params;
  
  %get default mask parameter values, block mask parameter values and look for differences
  else,
    %look up parameters we need and ones that are unnecessary based on block type
    [required_params, unnecessary_params] = filter_dialog_parameters(src);

    params = {};
    blk_params = get_params(blk, all_params);
    src_params = get_params(src, all_params);
    
    %sanity check
    if(length(blk_params) ~= length(src_params)),
      clog(['block parameter length does not match source for ',blk],{'error', 'determine_dialog_params_debug', 'mdl2m_debug'}); 
      error(['block parameter length does not match source for ',blk]);
      return; 
    end

    %go through comparing names and values
    for index = 1:2:length(blk_params),
      blk_name = blk_params{index}; blk_value = blk_params{index+1};
      src_name = src_params{index}; src_value = src_params{index+1};
      
      %sanity check
      if ~strcmp(blk_name, src_name),
        clog(['block param name (''',blk_name,'''),does not match source param name (''',src_name,''') for ',blk],{'error', 'determine_dialog_params_debug', 'mdl2m_debug'}); 
        error(['block param name (''',blk_name,'''),does not match source param name (''',src_name,''') for ',blk]); 
        return; 
      end

      unnecessary = (sum(strcmp(blk_name, unnecessary_params)) > 0);
      required = (sum(strcmp(blk_name, required_params)) > 0);
      diff = (~strcmp(to_string(blk_value), to_string(src_value)));
      clog(['block param (''',blk_name,''') for ',blk,' unnecessary: ',num2str(unnecessary),' required: ',num2str(required),' diff: ',num2str(diff)],{'determine_dialog_params_debug', 'mdl2m_debug'}); 
      %include if (default strategy and not unnecessary and (required or if different from default) or (delta strategy and difference from default)
      if ((strcmp(strategy, 'default') && ~unnecessary) && (required || diff)) || (strcmp(strategy, 'delta') && diff),                         
        clog(['block param (''',blk_name,'''), included for ',blk],{'determine_dialog_params_debug', 'mdl2m_debug'}); 
        params = {params{:}, blk_name};
      else,
        clog(['block param (''',blk_name,'''), not included'],{'determine_dialog_params_debug', 'mdl2m_debug'}); 
      end
    end %for
  end %if

end %determine_dialog_params

%forces addition and removal of certain parameters based on block source
function[force_include, force_exclude] = filter_dialog_parameters(src)
  tokens = regexp(src, '/', 'split');
  blk = tokens{length(tokens)};
  base_lib = tokens{1};

  force_include = {}; force_exclude = {};
  %Xilinx System Generator blockset
  if length(base_lib > 8) && strcmp(base_lib(1:8), 'xbsIndex'),

    clog(['including/excluding parameters for System Generator block ''',blk,''''], {'mdl2m_debug', 'filter_dialog_parameters_debug'});
    %exclude parameter values that are generated by other scripts
    force_exclude = {force_exclude{:}, ...
      'infoedit', ...
      'block_version', ...
      'sg_icon_stat', ...
      'sg_mask_display', ...
      'sg_list_contents', ...
      'sggui_pos', ...
      'xl_area', ...
    };  

  %casper block
  elseif length(base_lib >= 6) && strcmp(base_lib(1:6), 'casper'),
    
    clog(['including/excluding parameters for casper block ''',blk,''''], {'mdl2m_debug', 'filter_dialog_parameters_debug'});

    force_include = {force_include{:}, ...
    %TODO 
%      'UserData', ... %UserData contains state and mask struct values
%      'UserDataPersistent', ...
    };
    
  elseif length(base_lib >=  8) && strcmp(base_lib(1:8), 'built-in'),
    clog(['including/excluding parameters for built-in block ''',blk,''''], {'mdl2m_debug', 'filter_dialog_parameters_debug'});

    if strcmp(blk, 'Outport') || strcmp(blk, 'Inport'),
      force_include = {force_include{:}, 'Port'};
    end %if

  else,
    clog(['including/excluding parameters for unknown block ''',blk,''''], {'mdl2m_debug', 'filter_dialog_parameters_debug'});
    %don't know so include everything
    force_exclude = {}; force_include = {};
  end %if

  include_str = [''];
  for index = 1:length(force_include),
    if index ~= 1, include_str = [include_str, ', ']; end
    include_str = [include_str, '''', force_include{index}, ''''];
  end
  clog(['required parameters for block ''',blk,''': {',include_str,'}'], {'mdl2m_debug', 'filter_dialog_parameters_debug'});
  
  exclude_str = [''];
  for index = 1:length(force_exclude),
    if index ~= 1, exclude_str = [exclude_str, ', ']; end
    exclude_str = [exclude_str, '''', force_exclude{index}, ''''];
  end
  clog(['unnecessary parameters for block ''',blk,''': {',exclude_str,'}'], {'mdl2m_debug', 'filter_dialog_parameters_debug'});

end %filter_dialog_parameters

%add block generation logic 
function gen_blocks(varargin)
  defaults = {};
  blks        = get_var('blks', 'defaults', defaults, varargin{:});
  fp          = get_var('file', 'defaults', defaults, varargin{:});

  %generate functions for blocks that require it
  for index = 1:length(blks),
    blk = blks{index};
    name  = get_param(blk, 'Name');
    bt    = get_param(blk, 'BlockType');        %block type
    sls   = get_param(blk, 'StaticLinkStatus'); %library block or not (and does not update out-of-date linked blocks)

    % need to generate logic for non-library blocks that are subsystems
    if (strcmp(sls, 'none') || strcmp(sls, 'implicit')) && strcmp(bt, 'SubSystem'),
      clog(['appending generation functions for ',blk],{'gen_blocks_debug','mdl2m_debug'}); 
      blk2m(blk, 'file', fp); %append generation functions to same file
    else,
      %do nothing as don't need to generate this block
    end
  end %for
end %gen_blocks

%logic to generate lines for system   
function add_line(line, fp)
  
  %determine line parameters
  branches = get_line_parameters([], line);

  %sanity check
  if isempty(branches), 
    srcport = line.SrcPort; srcblk = line.SrcBlock;
    
    clog(['Error determining parameters for line starting at ',get(srcblk,'Name'),'/',num2str(srcport)], {'error', 'mdl2m_debug', 'add_line_debug'});
    error(['Error determining parameters for line starting at ',get(srcblk,'Name'),'/',num2str(srcport)]);
  else,
    for branch_index = 1:length(branches),
  
      branch = branches(branch_index);

      srcblk = branch.SrcBlock; srcport = branch.SrcPort;
      destblk = branch.DstBlock; destport = branch.DstPort;
      points = branch.Points;

%      fprintf(fp, '\t%% %s/%s -> %s/%s\n', srcblk, srcport, destblk, destport);
%      fprintf(fp, '\tadd_line(blk,%s);\n',mat2str(points));
      fprintf(fp, '\tadd_line(blk,''%s/%s'',''%s/%s'', ''autorouting'', ''on'');\n', srcblk, srcport, destblk, destport);
    end %for
  end %if
end %add_line

function[params] = get_line_parameters(src, line)
  
  params = [];
  srcport = line.SrcPort; srcblk = get(line.SrcBlock,'Name');
  
  dstport = line.DstPort; dstblk = get(line.DstBlock,'Name'); 
  points = line.Points;
  
  %if we have a source block then a line starts here
  if ~isempty(srcblk),
    clog(['line commencement at ',srcblk,'/',srcport,' found'], {'mdl2m_debug', 'get_line_parameters_debug'});
  %otherwise use passed in parameters
  else,
    if ~isempty(src),
      srcport = src.SrcPort; srcblk = src.SrcBlock;
    else,
      clog(['sanity error: empty source block and no src info passed in'], {'error', 'mdl2m_debug', 'get_line_parameters_debug'});
      error(['sanity error: empty source block and no src info passed in']);
    end
  end %if

  dst.SrcPort = srcport; dst.SrcBlock = srcblk;
  dst.DstPort = dstport; dst.DstBlock = dstblk; 
  if ~isempty(src),
    dst.Points = [src.Points; points]; 
  else
    dst.Points = points;
  end

  %if we have a destination then this line terminates
  if ~isempty(dstblk),
    params = [dst]; 
    clog(['line termination at ',dstblk,'/',dstport,' found'], {'mdl2m_debug', 'get_line_parameters_debug'});
    return;
  %otherwise this line has one or more branches
  else,
    branches = line.Branch;
    clog([num2str(length(branches)), ' branches found'], {'mdl2m_debug', 'get_line_parameters_debug'});
    for branch_index = 1:length(branches),
      branch = branches(branch_index);
      branch_params = get_line_parameters(dst, branch);
      params = [params; branch_params];
    end %for
  end %if
end %get_line_parameters

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% block generation functions %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%generates functions that will set up the mask etc of the block 
function blk2m(blk, varargin)
    defaults = { ...
        'filename', [get_param(blk,'Name'),'_gen'], ...   %filename for generator script
        'mode', 'a', ...                                  %mode to open file ('a'-append, 'w'-overwrite)
    };
    fn     = get_var('filename', 'defaults', defaults, varargin{:});
    m      = get_var('mode', 'defaults', defaults, varargin{:});
    fp     = get_var('file', 'defaults', defaults, varargin{:});
    
    %%%%%%%%%%%%%
    % open file %
    %%%%%%%%%%%%%

    %open file if no file pointer
    if fp == NaN,
        ntc = 1; %remember that we need to close
        clog(['opening ',fn],'blk2m_debug');
        fp_init = fopen([fn,'.m'],m);
        if fp == -1,
            clog(['error opening ',fn, ' in mode ''',m,''''],{'mdl2m_debug', 'blk2m_debug', 'error'});
            return
        end %if
    else,
        ntc = 0;
    end %if

    name = get_param(blk, 'Name');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % block generation function %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    clog(['block generation function for ',name],{'mdl2m_debug', 'blk2m_debug'}); 
    blk_gen(blk, fp);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % mask generation function %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%

    clog(['mask generation function for ',name],{'mdl2m_debug', 'blk2m_debug'}); 
    mask_gen(blk, fp);

    %%%%%%%%%%%%%%%%%
    % init function %
    %%%%%%%%%%%%%%%%%
    
    clog(['init function for ',name],{'mdl2m_debug', 'blk2m_debug', 'error'}); 
    mdl2m(blk, 'file', fp, 'subsystem', 'on'); %call generation logic to generate init   

    %%%%%%%%%%%%%%
    % close file %
    %%%%%%%%%%%%%%

    if ntc == 1,
        result = fclose(fp);
        if result ~= 0, clog(['error closing file ',fn],{'blk2m_debug', 'mdl2m_debug', 'error'}); end 
    end %if
end %blk2m

%generate function that calls other functions to generate block
function blk_gen(blk, file)

    name = get_param(blk, 'Name');

    %initialise block generator function 
    clog(['adding block generation function for ',name],{'mdl2m_debug', 'blk_gen_debug'}); 
    %setup function 
    fprintf(file,'function %s_gen(blk)\n',name);     
    fprintf(file, '\n');    

    fprintf(file, '\t%s_mask(blk);\n',name);      %logic to generate the mask    
    fprintf(file, '\t%s_init(blk);\n',name);      %logic to generate the internal logic

    params = get_params(blk, {'MaskInitialization'});
    set_params(file, 'blk', params, 'no_empty');
    fprintf(file, '\n');    

    %finalising
    clog(['finalising block generator function'],{'mdl2m_debug','blk_gen_debug'}); 
    fprintf(file, 'end %% %s_gen\n\n',name);

end %blk_gen

%generate logic to generate block mask
function mask_gen(blk, file)

    mask_params = ...
        { ...
        'Mask', ...                 %is the block masked
        'MaskSelfModifiable', ...   %whether library blocks can modify themselves
...%	'MaskInitialization', ...   %initialization commands
        'MaskType', ...             %library block or not
        'MaskDescription', ...      %description of block
        'MaskHelp', ...             %help for block
        'MaskPromptString', ...     %prompts for parameters
        'MaskStyleString', ...      %type of parameters
        'MaskTabNameString', ...    %tab names for parameters
        'MaskCallbackString', ...   %callback commands for parameters
        'MaskEnableString', ...     %whether parameters are enabled
        'MaskVisibilityString', ... %whether parameters are visible
        'MaskToolTipString', ...    %tips for parameters
        'MaskVariables', ...        %variable names attached to parameters
        'MaskValueString', ...      %values attached to parameters
	'BackgroundColor', ...      %background colour of block
        'MaskDisplay', ...          %appearance of block
        };

    params = get_params(blk, mask_params);

    if mod(length(params),2) ~= 0, 
        clog(['parameters must be ''name'', value pairs'],{'mdl2m_debug','mask_gen_debug','error'});
        return;
    end

    blk_name = get_param(blk, 'Name');

    %initialise mask generator function 
    clog(['adding mask function for ',blk_name],{'mask_gen_debug','mdl2m_debug'}); 
    %setup function 
    fprintf(file,'function %s_mask(blk)\n',blk_name);     
    fprintf(file, '\n');    

    %set up mask parameters
    set_params(file, 'blk', params, 'no_empty');
    fprintf(file, '\n');    

    %finalising
    clog(['finalising mask generation function'],{'mask_gen_debug', 'mdl2m_debug'}); 
    fprintf(file, 'end %% %s_mask\n\n',blk_name);
end %mask_gen

%%%%%%%%%%%%%%%%%%%%
% helper functions %
%%%%%%%%%%%%%%%%%%%%

%add logic to set up parameters
%strategy can be 'all' or 'no_empty'
function set_params(fp, target, params, strategy)

    if mod(length(params),2) ~= 0, 
        clog(['parameters must be ''name'', value pairs'],{'error', 'set_params_debug', 'mdl2m_debug'});
        return;
    end

    init = 0;
    for index = 1:2:length(params),
        clog(['processing ',params{index}],{'set_params_debug', 'mdl2m_debug'}); 
        value = params{index+1};
        name = params{index};
        if strcmp(strategy, 'all') || (~isempty(value) && strcmp(strategy, 'no_empty')),        
            [value_s, result] = to_string(value);

            if (result ~= 0),
                clog(['error while converting ',name,' to string'],{'set_params_debug', 'mdl2m_debug', 'error'});
                return;
            end

            %start the function call if we have something
            if (init == 0), 
              fprintf(fp, '\tset_param(%s',target);
              init = 1;
            end
            
            fprintf(fp, ', ...\n\t\t''%s'', sprintf(''%s'')', name, value_s);
        else,
            clog(['skipping ',name],{'set_params_debug', 'mdl2m_debug'});
        end
    end

    %close the function call if we started
    if (init == 1), fprintf(fp, ');\n'); end

end %set_params

%determine values of all mask parameters we care about when generating a block
function[params] = get_params(target, required_params)

    params = {};

    for param_index = 1:length(required_params),
        param = required_params{param_index};
        clog(['getting ',param],{'get_params_debug', 'mdl2m_debug'}); 

        value = get_param(target, param);

        params = {params{:}, param, value};
    end %for
end %get_params

% converts items into strings that can be used to generate other strings
function[output, result] = to_string(var)

    result = -1;
    output = '';
    if isempty(var),
      result = 0;
      return;
    end
    % if a cell array then iteratively convert 
    if isa(var, 'cell'),
      [r,c] = size(var);
      output = '{';
      for row_index = 1:r,
        for col_index = 1:c,
          [sub, result] = to_string(var{row_index,col_index});
          if result == -1,
            return;
          end
          if c > 1, output = [output, ','];
          end
        end %col
        if r > 1, output = [output, ';'];
        end
      end %row
      output = [output,'}'];
    elseif isa(var, 'numeric'),
      output = ['',mat2str(var),''];
      result = 0;
    elseif isa(var, 'char'),
      var = regexprep(var, '''', '''''');           %make quotes double
      var = regexprep(var, '\n', '\\n');            %escape new lines
      var = regexprep(var, '%', '%%');              %escape percentage symbols
      output = ['',var,''];
      result = 0;
    else
      clog(['don''t know how to convert variable of class ',class(var),' to string'], 'error');
    end
end %to_string
