% function test_library(varargin)
%
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% tests_file - The file containing the module components to test
% test_type = Type of test to run ('all', library 'section', individual 'unit')
% subsection = Name of section when testing library subsection or section containing unit
% block = Name of individual block to run unit tests for

function test_library(varargin)

defaults = {'tests_file', 'tester_input.txt', 'test_type', 'unit', ...
 'subsection', 'Misc', 'block', 'adder_tree', 'stop_first_fail', 'on' };

tests_file = get_var('tests_file', 'defaults', defaults, varargin{:});
test_type = get_var('test_type', 'defaults', defaults, varargin{:});
subsection = get_var('subsection', 'defaults', defaults, varargin{:});
block = get_var('block', 'defaults', defaults, varargin{:});
stop_first_fail = get_var('stop_first_fail', 'defaults', defaults, varargin{:});

%variables used to track number of failures and lines ignored
passed = 0;
failed = 0;
ignore = 0;

fid = fopen(tests_file);
if (fid == -1),
    fprintf(['File "', tests_file, '" not found in local directory.\n']);
    return
end

%libraries needing to be loaded expected on first line of tests_file
libs_raw = fgetl(fid);
linenum = 1;
if ~ischar(libs_raw),
    disp(['Libraries to load expected on first line of ',tests_file]);
    return;
end

%go through string getting libraries
idx = 1;
libs = {};
[lib, remainder] = strtok(libs_raw);
while length(lib) ~= 0,
  libs{idx} = lib;
  idx = idx+1;
  [lib, remainder] = strtok(remainder);
end;

%load the appropriate libraries
for lib_idx = 1:length(libs),
  lib_name = libs{lib_idx};
  if (exist(lib_name, 'file') ~= 4),
      disp(['Library ', lib_name, ' not accessible. Aborting...\n']);
      return
  else
      warning('off', 'Simulink:SL_LoadMdlParameterizedLink')
      load_system(lib_name);
      fprintf([lib_name, ' loaded\n']);
  end
end

%search for subsection to test
if ~strcmp(test_type, 'all'),
    comment = ' ';
    token = ' ';
    sec = ' ';

    %start of subsection demarcated with % # <subsection name>, keep searching till found
    while (~strcmp(comment, '%') || ~strcmp(token, '#') || ~strcmp(sec, subsection)),
        line = fgetl(fid);
        linenum = linenum + 1;
        if ~ischar(line),
            fprintf(['Error reading from file ',tests_file ,', or end of file before subsection ',subsection,' found.\n']);
            fclose(fid);
            for lib_idx = 1:length(libs),
              close_system(libs{lib_idx})
            end
            return
        end
        [comment, remainder] = strtok(line);
        [token, remainder] = strtok(remainder);
        [sec, remainder] = strtok(remainder);
    end
    fprintf(['Begining of test subsection ', subsection, ' found at line ', num2str(linenum),'\n']);

    blk = ' ';
    section = ' ';
    if strcmp(test_type, 'unit') || strcmp(test_type, 'section from block'),
      %search for tests for block specified until end of section or block found
      while ~((strcmp(blk, '%') && strcmp(section, '#')) || strcmp(blk, block)),
          line = fgetl(fid);
          linenum = linenum + 1;
          if ~ischar(line),
              fprintf(['Error reading from file ',tests_file ,', or end of file before block ',block,' or end of section ',subsection,' found.\n']);
              fclose(fid);
              for lib_idx = 1:length(libs),
                close_system(libs{lib_idx})
              end
              return
          end
          [blk, remainder] = strtok(line);
          [section, remainder] = strtok(remainder);
      end

      %if found end of section without finding block
      if(~strcmp(blk, block)),
        fprintf(['End of subsection ',subsection,' found on line ',num2str(linenum), ' without test for block ',block,'\n']);
        fclose(fid);
        for lib_idx = 1:length(libs),
          close_system(libs{lib_idx})
        end
        return;
      else
        fprintf(['Unit test(s) for block ', block,' found on line ', num2str(linenum),'\n']);
      end
    end
end

%read one extra line if testing subsections
if strcmp(test_type, 'section'),
  line = fgetl(fid);
  linenum = linenum+1;
end

fprintf('\n');
%run tests
while ischar(line),

    %read in the block to be tested and the model file
    [blk, remainder] = strtok(line);
    [libloc, remainder] = strtok(remainder);
    [model, remainder] = strtok(remainder);

    %found end of section to be tested and not testing everything
    if (~strcmp(test_type, 'all') && strcmp(blk, '%') && strcmp('#', libloc)),
        fprintf(['End of test subsection ', subsection, ' found at line ', num2str(linenum), '.']);
        break;
    end

    %stop if unit testing and (encountered new library subsection or end of unit tests) 
    if (strcmp(test_type, 'unit') && (... 
      (~strcmp(blk, block) && ~strcmp(blk, '%')) || ...
      (strcmp(blk, '%') && strcmp(libloc, '#')))),
        fprintf(['End of tests for ', block, ' found at line ', num2str(linenum), '.']);
        break;
    end

    %if commment just continue
    if strcmp('%', blk) || blk(1) == '%',
        line = fgetl(fid);
        linenum = linenum + 1;
        continue;
    end

    err = 1;
    % if there is no block, library location or model file, ignore this line
    if isempty(blk) || isempty(libloc) || isempty(model),

      if isempty(blk), 
        fprintf(['Library block not specified on line ',linenum, '.\n']);
      end
      
      if isempty(libloc), 
        fprintf(['Location of block in library not specified on line ',linenum, '.\n']);
      end
    
      if isempty(model), 
        fprintf(['Unit test model file not specified on line ',linenum, '.\n']);
      end

      fprintf(['Line read: ',line, '\n']);

    % if the model file does not exist, ignore this line
    elseif (exist(model, 'file') ~= 4),
        fprintf(['Model file ''', model, '.mdl'' does not exist.\n']);
    % load model and try to find block specified
    else

        % try to find library block specified
        lib = [];
        fprintf(['Trying to find library block ', libloc, '...']);
        try
            lib = find_system(libloc);
        catch
            fprintf(' failure\n');
            err = 1;
        end
        if isempty(lib),
            err = 1;
        else
            fprintf(' success\n');
        end

        % try to find block in model
        fprintf(['Trying to find ', blk, ' in model file ', model, ' ...']);
        
        warning('off', 'Simulink:SL_LoadMdlParameterizedLink')
        load_system(model);
        % finds block with name followed by zero or more digits [0-9]
        thisblk = find_system(model, 'Regexp', 'on', 'name', ['\<',blk,'[\d]*\>']);
        if isempty(thisblk),
            fprintf(' failure\n');
        else
            fprintf(' success\n');
            pos = get_param(thisblk, 'Position');

            err = 0;
        end

    end

    %error in unit test setup, ignore line
    if err,
        fprintf('\n************************************\n');
        fprintf(['* Ignoring line ', num2str(linenum), '.\n']);
        fprintf('************************************\n\n');
        ignore = ignore + 1;
    
        %if we need to stop on first failure, exit here
        if strcmp(stop_first_fail, 'on'),
          close_system(model, 0);
          break;
        else
          close_system(model, 0);
        end

    else
        %add the latest library block to the model
        try
            add_block(libloc, [model, '/', blk, '1']);
        catch
            fprintf(['Error creating ',model,'/',blk,'1',' from ', libloc,'.\n']);
            err = 1;
            close_system(model, 0);
        end

        %set up parameters if no error in creating block
        if ~err,
          %read in block parameters
          vars = {};
          i = 0;
          [name, remainder] = get_token(remainder);
          [value, remainder] = get_token(remainder);
          while (~isempty(name) && ~isempty(value)),
              fprintf(['setting ', name, ' to ', value, '\n']);
              vars{(i*2)+1} = ['', name, ''];
              vars{(i*2)+2} = value;

              %if are dealing with Configurable Subsystem
              if strcmp('BlockChoice', name),
                fprintf('Reconfigurable subsystem detected. Unable to do those.\n');
                err = 1;  
              end

              [name, remainder] = get_token(remainder);
              [value, remainder] = get_token(remainder);
              i = i + 1;
          end

          set_mask([model, '/', blk, '1'], vars{:});
        end       
 
        %set position to the same so lines join ports
        %NOTE must be *after* setting mask params as determine port locations, wont
        %lock on to old inputs
        if ~err,
          delete_block(thisblk{:});

          set_param([model, '/', blk, '1'], 'Position', pos{:});

          %if no error so far simulate
          fprintf(['simulating ', model, ' ...\n']);
          sim(model);
                
          if exist([model, '_reference.mat']) ~= 2,
            fprintf([model, '_reference.mat containing reference output not found in path\n']);
            err = 1; 
          end

          if exist([model, '_output.mat']) ~= 2,
            fprintf([model, '_output.mat containing simulation output not found\n']);
            err = 1; 
          end
        end

        %load reference and output data from file
        if ~err,        
          load([model, '_reference'],'reference');
          if exist('reference') ~= 1,
            fprintf(['Variable ''reference'' not found in Workspace\n']);
            err = 1;  
          end
          
          load([model, '_output'],'output');
          if exist('output') ~= 1,
            fprintf(['Variable ''output'' not found in Workspace\n']);
            err = 1;  
          end
        end

        %compare reference data to output
        if ~err,      
          %check for NaNs and replace with zeros before making comparison
          reference(isnan(reference)) = 0;
          output(isnan(output)) = 0;

          if isequal(reference, output),
              fprintf([model, ' passed\n']);
              passed = passed + 1;
          else
              fprintf('\n*******************************************************************\n');
              fprintf([model, ' failed, line ', num2str(linenum), '. Output and reference files differ.\n']);
              fprintf('*******************************************************************\n\n');
              failed = failed + 1;

              %if we need to stop on first failure, exit here, leaving model open
              if strcmp(stop_first_fail, 'on'),
                fprintf(['Exiting on first failure as specified\n\n']);
                break;
              end
          end
        else
          fprintf('\n************************************\n');
          fprintf(['Ignoring line ', num2str(linenum), '.\n']);
          fprintf('************************************\n\n');
          ignore = ignore + 1;
          
          %if we need to stop on first failure, exit here
          if strcmp(stop_first_fail, 'on'),
            fprintf(['Exiting on first failure as specified\n\n']);
            break; 
          end
        end

        close_system(model, 0);
        fprintf('\n');
    end

    line = fgetl(fid);
    linenum = linenum + 1;
end
%close unit test file
fclose(fid);

%close libraries
for lib_idx = 1:length(libs),
  close_system(libs{lib_idx})
end

fprintf('\n\n');
fprintf(['lines ignored: ', num2str(ignore), '\n']);
fprintf(['tests passed: ', num2str(passed), '\n']);
fprintf(['tests failed: ', num2str(failed), '\n']);
if (failed || ignore),
    fprintf('Please see output for more details.\n');
end
