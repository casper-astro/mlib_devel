function [] = gen_plat_files()

f = load('hw_routes.mat');

plats = fieldnames(f)
n_plats = length(plats)

for i = 1 : n_plats
    fid = fopen([plats{i} '.py.auto'], 'w')
    p = getfield(f, plats{i})
    ports = fieldnames(p)
    n_ports = length(ports)
    for j = 1 : n_ports
        pins = getfield(p, ports{j})
        if isa(pins, 'cell')    
            fprintf(fid, '    %s_pins = [\n', ports{j})
            n_pins = length(pins)
            for k = 1 : n_pins
                fprintf(fid, '        ''%s'',\n', pins{k})
            end
            fprintf(fid, '        ]\n')
            fprintf(fid, '    self.add_pins(''%s'', ''LVDS_25'', %s_pins)\n\n', ports{j}, ports{j})
        end
    end
    fclose(fid)
end