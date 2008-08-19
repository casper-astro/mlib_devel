function gtk_parse()

%Valid codes to use for VCD file signals
codes = '!"#$&()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~';
fname = 'temp.vcd';
w = evalin('base','who');
gtks = [];
full_path = 0;
for k = 1:length(w),
    v = w{k};
    if strcmp(v,'full_path_gtk'),
        full_path = 1
    elseif strfind(v,'gtk_') == 1,
        g.var = v;
        parts = strsplit('_',v);
        nparts = length(parts);
        g.typestr = parts{end};
        g.width = 1;
        if strcmp(g.typestr,'real')
            g.type = 'real';
            g.tn = 3;
        else
            if strcmp(g.typestr,'bool')
                g.type = 'wire';
                g.tn = 2;
            else
                g.width = eval(g.typestr(4:end));
                g.type = 'integer';
                g.tn = 1;
            end
        end
        
        g.heir = {parts{2:(nparts-3)}};
        g.sig = parts{nparts-1};
        g.raw = evalin('base',v);
        gtks = [gtks, g];
    end
end
ngtks = length(gtks);
if ngtks == 0,
    errordlg('No gtkWave outputs were found. This could mean the simulation has not yet been run');
    return
end
datalen = length(gtks(1).raw.signals.values);
matdata = zeros(datalen,ngtks);
%matdata(:,1) = gtks(1).raw.time;

vcdf = fopen(fname,'w');

fprintf(vcdf,['$date\n', datestr(now), '\n$end\n$version\nSimulink VCD Writer\n$end\n$timescale\n1 s\n$end\n']);

curr_heir = {};
depth = length(curr_heir);
for k = ngtks:-1:1,
    matdata(:,k) = gtks(k).raw.signals.values;
    sdepth = min(depth,length(gtks(k).heir));
    match_depth = celleq({curr_heir{1:sdepth}},{gtks(k).heir{1:sdepth}});
    while depth > match_depth,
        fprintf(vcdf,['$upscope $end\n']);
        depth = depth - 1;
        curr_heir = {curr_heir{1:(depth)}};
    end
    while depth < length(gtks(k).heir),
        fprintf(vcdf,['$scope module ',gtks(k).heir{depth+1},' $end\n']);
        depth = depth + 1;
    end            
    curr_heir = gtks(k).heir;
    if full_path == 1,
        fprintf(vcdf,['$var ',gtks(k).type, ' ', num2str(gtks(k).width), ' *', codes(k), ' ',strjoin('/',curr_heir{2:end}),'/', gtks(k).sig, ' $end\n']);
    else
        fprintf(vcdf,['$var ',gtks(k).type, ' ', num2str(gtks(k).width), ' *', codes(k), ' ', gtks(k).sig, ' $end\n']);
    end
end

for k = 1:depth,
    fprintf(vcdf,['$upscope $end\n']);
end
fprintf(vcdf,['$enddefinitions $end\n']);

for k = 1:datalen,
    if k == 1,
        fprintf(vcdf,['#0\n$dumpvars\n']);
    else
        fprintf(vcdf,'#%d\n',(k-1));
    end
    for m = 1:ngtks,
        if gtks(m).tn == 1,
            fprintf(vcdf,['b',dec2bin(gtks(m).raw.signals.values(k),16), ' *',codes(m),'\n']);
        elseif gtks(m).tn == 2,
            fprintf(vcdf,[num2str(gtks(m).raw.signals.values(k)),'*',codes(m),'\n']);
        else
            fprintf(vcdf,[sprintf('R%.16g',gtks(m).raw.signals.values(k)), ' *',codes(m),'\n']);
        end
    end
    if k == 1,
        fprintf(vcdf,['$end\n']);
    end
end
fclose(vcdf);
dos(['C:\\gtkw\\gtkwave ', fname, ' temp.sav' ' &']);