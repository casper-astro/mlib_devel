function resynth_netlist(dir_name, varargin)
% Resynthesize a System Generator netlist using non-default XST options.
% 
% RESYNTH_NETLIST(NAME) or RESYNTH_NETLIST(DIR, NETLIST) resynthsizes the
% NAME/NAME.ngc or DIR/NETLIST netlist using the original XST options with
% these changes/additions:
%
%   -register_balancing yes
%   -optimize_primitives yes
%   -read_cores yes
%
% RESYNTH_NETLIST(NAME, OPT, VAL, ...) or
% RESYNTH_NETLIST(DIR, NETLIST, OPT, VAL, ...) resynthsizes the NAME/NAME.ngc
% or DIR/NETLIST.ngc netlist using the original XST options with the
% changes/additions given by the OPT,VAL pairs.  Note that each OPT must start
% with a '-'.

    % If second argument does not start with a '-'.
    % treat it as netlist name; otherwise assume
    % netlist name is derived from dir_name.
    if length(varargin) > 0 && varargin{1}(1) ~= '-'
        netlist_name = varargin{1};
        varargin = {varargin{2:end}};
    else
        netlist_name = dir_name;
    end

    if mod(length(varargin), 2) ~= 0
        error('options and values must be given in pairs');
    end

    % If netlist_name does not end with '.ngc', add it
    if isempty(regexp(netlist_name, '\.ngc$'))
        netlist_name = [netlist_name, '.ngc'];
    end

    % If no options given, use default set
    if isempty(varargin)
      opts = { ...
          '-register_balancing', 'yes', ...
          '-optimize_primitives', 'yes', ...
          '-read_cores', 'yes', ...
      };
    else
      opts = varargin;
    end

    workdir = [dir_name, '/synth_model/'];
    old_scr = dir([workdir, 'xst_*.scr']);
    old_scr = [workdir, old_scr.name];
    new_scr = [workdir, 'resynth.scr'];

    % Copy lines from old scr file to new scr file
    fold = fopen(old_scr, 'r');
    fnew = fopen(new_scr, 'w');
    while feof(fold) == 0
        line = fgets(fold);
        % Remove existing xst options that are being overridden
        for k = 1:2:length(opts)
          line = regexprep(line, [' ?', opts{k}, ' [^ ]+'], '');
        end
        fprintf(fnew, '%s', line);
    end
    fclose(fold);

    % Append new options to new scr file
    for k = 1:2:length(opts)
        fprintf(fnew, '%s %s\n', opts{k}, opts{k+1});
    end
    fclose(fnew);

    % Create resynth_commandLines
    old_cl = [workdir, 'commandLines'];
    new_cl = [workdir, 'resynth_commandLines'];
    fold = fopen(old_cl, 'r');
    fnew = fopen(new_cl, 'w');
    while feof(fold) == 0
        line = fgetl(fold);
        line = regexprep(line, '-ifn .*', '-ifn resynth.scr -ofn resynth.results');
        fprintf(fnew, '%s\n', line);
    end
    fclose(fold);
    fclose(fnew);

    % Run commands in resynth_commandLines
    fnew = fopen(new_cl, 'r');
    while feof(fnew) == 0
        line = fgets(fnew);
        system(['cd ', workdir, ' && ', line]);
    end
    fclose(fnew);

    % Copy complete netlist to dir_name/netlist_name
    complete_netlist_name = regexprep(netlist_name, '\.ngc$', '_complete.ngc');
    copyfile([workdir, complete_netlist_name], [dir_name, '/', netlist_name]);

end
