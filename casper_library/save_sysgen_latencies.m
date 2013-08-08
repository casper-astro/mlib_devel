function save_sysgen_latencies(filename)

% Make sure xbsIndex_r4 is loaded
if ~bdIsLoaded('xbsIndex_r4')
    load_system('xbsIndex_r4');
end

% Find and sort all blocks that have a latency parameter
blks=sort(find_system('xbsIndex_r4','RegExp','on','latency','.?'));

% Write block names and default latencies to file
f = fopen(filename, 'w');
for k = 1:length(blks)
    fprintf(f, '%-40s %3s\n', blks{k}, get_param(blks{k}, 'latency'));
end
fclose(f);
end