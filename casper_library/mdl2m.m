%generate script to draw system specified
% 
%usage: function mld2m(mdl, varargin)
%mdl 		- model to convert
%varargin	- 'name', value pairs
%  script_name	  - name of initialization script ([.../casper_library/<model_name>_init.m])
%  mode		  - mode to open initialization script in ('a'-append, ['w']-overwrite)
%  library	  - when creating the generated system, make it a library ('on', ['off'])
%  file		  - pass file pointer (created with fopen) directly

function mdl2m(mdl, varargin)
    
    base = 'getenv(''MLIB_DEVEL_PATH''), ''/casper_library/''';
    name = get_param(mdl, 'name');
    defaults = { ...
        'script_name', [eval(['[',base,']']), name, '_init'], ...           
	'mode', 'w', ...                                           
        'library', 'off', ...                                       	
    };
    script_name     = get_var('script_name', 'defaults', defaults, varargin{:});
    m               = get_var('mode', 'defaults', defaults, varargin{:});
    fp              = get_var('file', 'defaults', defaults, varargin{:});
    mdl_name        = [base, ', ''', name, ''''];
    library         = get_var('library', 'defaults', defaults, varargin{:});

    %get necessary system parameters
    clog(['getting parameter values for ',mdl],'mdl2m_debug'); 
    mdl_params = get_params(mdl);

    %open file
    clog(['opening ',script_name],'mdl2m_debug');
    fp = fopen([script_name,'.m'],m);
    if fp == -1,
        clog(['error opening ',script_name],'error');
        return
    end
    
    tokens = regexp(script_name, '/', 'split');
    f_name = tokens{length(tokens)};

    %set up top level function 
    fprintf(fp,'function %s(varargin)\n',f_name);     
    fprintf(fp, '\n');    

    %create new system
    clog(['setting up creation of new system ''',mdl,''''],'mdl2m_debug'); 

    if strcmp(library, 'on'), sys_type = 'Library';
    else, sys_type = 'Model';
    end
    fprintf(fp,'\twarning off Simulink:Engine:MdlFileShadowing;\n');        
    fprintf(fp,'\tmdl = new_system(''%s'', ''%s'');\n', name, sys_type);  %create a new system    
    fprintf(fp,'\twarning on Simulink:Engine:MdlFileShadowing;\n');        
    fprintf(fp,'\n');     
    
    %%%%%%%%%%%%%%%%%%%%%%%%
    % logic to draw system %
    %%%%%%%%%%%%%%%%%%%%%%%%

    %find all blocks in top level of system
    blks = find_system(mdl, 'SearchDepth', 1, 'type', 'block');
    clog(['found ',num2str(length(blks)), ' blocks to process'],'mdl2m_debug'); 

    %place in order of processing (will determine order of blocks in text file)
    blks = custom_sort(blks); 

    clog(['adding block generation logic'],'mdl2m_debug'); 
    add_blocks('blks', blks, 'file', fp);

    %TODO set up lines 
    clog(['adding line generation logic'],'mdl2m_debug'); 
    add_lines(blks, fp);
   
    %%%%%%%%%%%%%%%%%%%%%
    % system parameters %
    %%%%%%%%%%%%%%%%%%%%%
    
    clog(['adding system parameters for ',mdl],'mdl2m_debug'); 
    set_params('file', fp, 'params', mdl_params); 

    %if a library, must be saved somewhere before can be used
    if strcmp(library, 'on'),
        fprintf(fp, '\tsave_system(mdl,[%s]);\n', mdl_name);
    end
    
    fprintf(fp,'end %% %s\n\n',f_name);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % functions to generate blocks %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    clog(['appending block generation functions'],'mdl2m_debug'); 
    gen_blocks('blks', blks, 'file', fp);

    result = fclose(fp);
    if result ~= 0, clog(['error closing file ',script_name],'error');
    end 
end %mdl2m

function[blocks] = custom_sort(blocks_in)
    %TODO better sort methods
    blocks = sort(blocks_in);
end 

%logic to add block to system   
function add_blocks(varargin)
    defaults = {};
    blks        = get_var('blks', 'defaults', defaults, varargin{:});
    fp          = get_var('file', 'defaults', defaults, varargin{:});
    
    %go through and process all blocks
    for index = 1:length(blks),
        blk = blks{index};
        name        = get_param(blk, 'Name');
        type        = get_param(blk, 'BlockType');
        position    = get_param(blk, 'Position');
        values      = get_param(blk, 'MaskValueString');

        clog(['adding ',name],'add_blocks_debug'); 

        if strcmp(type, 'SubSystem'),
            fprintf(fp, '\tadd_block(''built-in/Subsystem'', ''%s'');\n', blk);                 %bare Subsystem block
            fprintf(fp, '\t%s_gen(''%s'');\n', name, blk);                                      %call mask generation logic
        else,
            %TODO more types of blocks
            clog(['unknown block type ',type,' for ', name],'add_blocks_debug'); 
        end       
        fprintf(fp, '\tset_param(''%s'', ''Position'', %s);\n\n', blk, mat2str(position));    %set up Position

    end %for index
end %add_blocks

%logic to add lines to system   
function add_lines(blocks, file_p)

end %add_lines

%add block generation logic 
function gen_blocks(varargin)
    defaults = {};
    blks        = get_var('blks', 'defaults', defaults, varargin{:});
    fp          = get_var('file', 'defaults', defaults, varargin{:});

    %generate functions for blocks that require it
    for index = 1:length(blks),
        blk = blks{index};
        name = get_param(blk, 'Name');
        type = get_param(blk, 'BlockType');

        if strcmp(type, 'SubSystem'),
            clog(['appending generation functions for ',blk],'gen_blocks_debug'); 
            blk2m(blk, 'file', fp); %append generation functions to same file
        else,
            %TODO
        end
    end %for
end %gen_blocks

function[params] = get_params(mdl, varargin)
    %TODO parameters required depend on type of system, for now hard-code
    required_params = ...
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
    params = {};

    for param_index = 1:length(required_params),
        param = required_params{param_index};
        clog(['getting ',param],'get_params_debug'); 

        value = get_param(mdl, param);

        %TODO conversion of value to string 
        params = {params{:}, param, value};
    end %for
end %mdl_get_params

%add logic to set up model parameters
function set_params(varargin)
    defaults = {};
    fp = get_var('file', 'defaults', defaults, varargin{:});
    params = get_var('params', 'defaults', defaults, varargin{:});

    if mod(length(params),2) ~= 0, 
        clog(['parameters must be ''name'', value pairs'],'error');
        return;
    end

    fprintf(fp, '\tset_param(mdl');
    for index = 1:2:length(params),
        clog(['processing ',params{index}],'set_params_debug'); 
        value = params{index+1};
        name = params{index};
        if ~isempty(value),        
            [value_s, result] = to_string(value);

            if (result ~= 0),
                clog(['error while converting ',name,' to string'],'error');
                return;
            end
            fprintf(fp, ', ...\n\t\t''%s'', sprintf(''%s'')', name, value_s);
        else,
            clog(['skipping ',name],'set_params_debug');
        end
    end
    fprintf(fp, ');\n\n');
end

%generates functions that will set up the mask etc of the block 
function blk2m(blk, varargin)
    defaults = { ...
        'filename', [get_param(blk,'Name'),'_gen'], ...   %filename for generator script
        'mode', 'a', ...                                   %mode to open file ('a'-append, 'w'-overwrite)
    };
    fn     = get_var('filename', 'defaults', defaults, varargin{:});
    m      = get_var('mode', 'defaults', defaults, varargin{:});
    fp     = get_var('file', 'defaults', defaults, varargin{:});
    
    %get necessary parameters
    clog(['getting parameter values for ',blk],'blk2m_debug'); 
    mask_params = get_mask_params(blk);
   
    %%%%%%%%%%%%%
    % open file %
    %%%%%%%%%%%%%

    %open file if no file pointer
    if fp == NaN,
        ntc = 1; %remember that we need to close
        clog(['opening ',fn],'blk2m_debug');
        fp_init = fopen([fn,'.m'],m);
        if fp == -1,
            clog(['error opening ',fn, ' in mode ''',m,''''],'error');
            return
        end %if
    else,
        ntc = 0;
    end %if

    name = get_param(blk, 'Name');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % block generation function %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    clog(['block generation function for ',name],'blk2m_debug'); 
    blk_gen(blk, fp);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % mask generation function %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%

    clog(['mask generation function for ',name],'blk2m_debug'); 
    mask_gen(blk, fp);

    %%%%%%%%%%%%%%%%%
    % init function %
    %%%%%%%%%%%%%%%%%
    
    clog(['init function for ',name],'blk2m_debug'); 
    init_gen(blk, fp);
    
    %%%%%%%%%%%%%%
    % close file %
    %%%%%%%%%%%%%%

    if ntc == 1,
        result = fclose(fp);
        if result ~= 0, clog(['error closing file ',fn],'error');
        end 
    end %if

end

function blk_gen(blk, file)

    name = get_param(blk, 'Name');

    %initialise block generator function 
    clog(['adding block generation function for ',name],'blk_gen_debug'); 
    %setup function 
    fprintf(file,'function %s_gen(blk, varargin)\n',name);     
    fprintf(file, '\n');    

    fprintf(file, '\t%s_mask(blk, varargin);\n',name);      %logic to generate the mask    
    fprintf(file, '\t%s_init(blk, varargin);\n',name);      %logic to generate the internal logic

    %finalising
    clog(['finalising block generator function'],'blk_gen_debug'); 
    fprintf(file, 'end %% %s_gen\n\n',name);

end %init_gen

function init_gen(blk, file)

    name = get_param(blk, 'Name');

    %initialise init function 
    clog(['adding init function for ',name],'init_gen_debug'); 
    %setup function 
    fprintf(file,'function %s_init(blk, varargin)\n',name);     
    fprintf(file, '\n');    
    %TODO 
    %finalising
    clog(['finalising init function'],'init_gen_debug'); 
    fprintf(file, 'end %% %s_init\n\n',name);

end %init_gen

%add logic to set up block mask
function mask_gen(blk, file)

    params = get_mask_params(blk);

    if mod(length(params),2) ~= 0, 
        clog(['parameters must be ''name'', value pairs'],'error');
        return;
    end

    blk_name = get_param(blk, 'Name');

    %initialise mask generator function 
    clog(['adding mask function for ',blk_name],'mask_gen_debug'); 
    %setup function 
    fprintf(file,'function %s_mask(blk, varargin)\n',blk_name);     
    fprintf(file, '\n');    

    fprintf(file, '\tset_param(blk');
    for index = 1:2:length(params),
        clog(['processing ',params{index}],'mask_gen_debug'); 
        value = params{index+1};
        name = params{index};
        if ~isempty(value),        
            [value_s, result] = to_string(value);

            if (result ~= 0),
                clog(['error while converting ',name,' to string'],'error');
                return;
            end
            fprintf(file, ', ...\n\t\t''%s'', sprintf(''%s'')', name, value_s);
        else,
            clog(['skipping ',name],'mask_gen_debug');
        end
    end
    fprintf(file, ');\n\n');

    %finalising
    clog(['finalising mask generation function'],'mask_gen_debug'); 
    fprintf(file, 'end %% %s_mask\n\n',blk_name);
end

%determine values of all parameters we care about
function[params] = get_mask_params(blk)

    %TODO parameters required depend on type of block, for now hard-code
    required_params = ...
        { ...
        'Mask', ...
        'MaskSelfModifiable', ...
	'MaskInitialization', ...
        'MaskType', ...
        'MaskDescription', ...
        'MaskHelp', ...
        'MaskPromptString', ...
        'MaskStyleString', ...
        'MaskTabNameString', ...
        'MaskCallbackString', ...
        'MaskEnableString', ...
        'MaskVisibilityString', ...
        'MaskToolTipString', ...
        'MaskVariables', ...
        'MaskValueString', ...
        };
    params = {};

    for param_index = 1:length(required_params),
        param = required_params{param_index};
        clog(['getting ',param],'get_mask_params_debug'); 

        value = get_param(blk, param);

        %TODO conversion of value to string 
        params = {params{:}, param, value};
    end %for
end %blk_get_params

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
          [sub, result] = blk_to_string(var{row_index,col_index});
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
