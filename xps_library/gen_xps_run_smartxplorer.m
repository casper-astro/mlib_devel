function [status, message] = gen_xps_run_smartxplorer(num_xplorer, xps_path, slash)

% make the hostlist
fid = fopen([xps_path, slash, 'implementation', slash, 'smartxplorer_hosts.txt'], 'w');
for ctr = 0 : num_xplorer - 1,
    fprintf(fid, 'localhost\n');
end
fclose(fid);

% run the tool
[~, ~] = unix('chmod +x run_smartxplorer.sh');
[status, message] = unix('./run_smartxplorer.sh');

end
