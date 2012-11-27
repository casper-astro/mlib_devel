function extract_entity(name)
% Extract the VHDL entity for a generated NGC netlist.
% 
% EXTRACT_ENTITY(NAME) extracts the VHDL entity for a SystemGenerator
% created NGC netlist and saves it in a standalone VHDL file for use with
% the Xilinx Black Box block's wizard.
%
% NAME can be the name of the NGC netlist file (e.g.
% 'fft_core/fft_core.ngc') or the name of the directory containing the NGC
% netlist file (e.g. 'fft_core').  The latter case can be used only if the
% NGC netlist is named NAME/NAME.ngc.
%
% The VHDL entity will be saved in the current directory in a file named
% after the basename of the NGC netlist, but with a 'vhd' extension rather
% than 'ngc'.

% Find generated VHDL (input) file treating given name as netlist
vin = regexprep(name,'ngc$','vhd');
fin = fopen(vin, 'r');
if fin == -1
    % Try treating given name as directory and stem
    vin = [name, '/', name, '.vhd'];
    fin = fopen(vin, 'r');
    if fin == -1
        disp(['Error: could not find VHDL file for "', name, '"']);
        return;
    end
end
%disp(['found "', vin, '"']);

% Read through file and save text of most recent entity
in_entity = 0;
entity = {};
while feof(fin) == 0
    line = fgets(fin);
    if regexp(line, '^entity ')
        toks = regexp(line, '^entity (\w*) is', 'tokens');
	entity_name = toks{1}{1};
        in_entity = 1;
        entity = {line};
    elseif in_entity
        if regexp(line, '^end ')
            in_entity = 0;
        end
        entity{end+1} = line;
    end
end
fclose(fin);

% Open output file
[pathpart, stem, ext] = fileparts(vin);
vout = ['./', stem, '.vhd'];
fout = fopen(vout, 'w');
if fout == -1
    disp(['Error: could open output VHDL file "', vout, '" for writing']);
    return;
end
fprintf(fout,'library IEEE;\n');
fprintf(fout,'use IEEE.std_logic_1164.all;\n\n');
for k = 1:length(entity)
    fprintf(fout,'%s', entity{k});
end
fprintf(fout, ['\narchitecture structural of ', entity_name, ' is\n']);
fprintf(fout, 'begin\nend structural;\n\n');
fclose(fout);

