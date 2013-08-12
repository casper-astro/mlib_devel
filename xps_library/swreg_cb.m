function swreg_cb(~, ~, blk)
%
% Init script for reg2 - software register for which arbitrary fields can be defined.
%
numios = str2double(get_param(blk, 'numios'));

% count the exising variable tabs
done = false;
existing_ios = 0;
while ~done,
    try
        get_param(blk, sprintf('name%i', existing_ios+1));
        existing_ios = existing_ios + 1;
    catch ex
        done = true;
    end
end

function add_param(mask, num, name, bitwidth, arith_type, bin_pt)
    tabname = sprintf('IO%i', num);
    mask.addParameter('Prompt', 'Name', 'Name', sprintf('name%i', n), 'TabName', tabname, 'Value', name, 'Evaluate', 'off');
    mask.addParameter('Prompt', 'Bitwidth', 'Name', sprintf('bitwidth%i', n), 'TabName', tabname, 'Value', bitwidth);
    mask.addParameter('Prompt', 'Type', 'Name', sprintf('arith_type%i', n), 'TabName', tabname, 'Value', arith_type, 'Type', 'popup', 'TypeOptions', {'Unsigned','Signed  (2''s comp)','Boolean'});
    mask.addParameter('Prompt', 'Binary pt', 'Name', sprintf('bin_pt%i', n), 'TabName', tabname, 'Value', bin_pt);
    cb = StringBuffer();
    cb.addcr('a = get_param(gcb, ''MaskEnables'');');
    cb.addcr(sprintf('if strcmp(get_param(gcb, ''arith_type%i''), ''Boolean''),', num));
    cb.addcr(sprintf('set_param(gcb, ''bitwidth%i'', ''1'');', num));
    cb.addcr(sprintf('set_param(gcb, ''bin_pt%i'', ''0'');', num));
    cb.addcr(sprintf('a(%i) = {''off''};', 4+((num-1)*4)+2));
    cb.addcr(sprintf('a(%i) = {''off''};', 4+((num-1)*4)+4));
    cb.addcr(sprintf('else'));
    cb.addcr(sprintf('a(%i) = {''on''};', 4+((num-1)*4)+2));
    cb.addcr(sprintf('a(%i) = {''on''};', 4+((num-1)*4)+4));
    cb.addcr(sprintf('end'));
    cb.addcr(sprintf('set_param(gcb, ''MaskEnables'', a);'));
    mask.getParameter(sprintf('arith_type%i', n)).Callback = cb.string();
end

% if the number of parameters has changed then shenanigans are in order
if existing_ios ~= numios,
    % close the dialog box so we can edit the mask
    close_system(blk);
    mask = get_param(blk, 'MaskObject');
    % back up old values
    old_name = cell(1, min(existing_ios, numios));
    old_width = cell(1, min(existing_ios, numios));
    old_type = cell(1, min(existing_ios, numios));
    old_binpt = cell(1, min(existing_ios, numios));
    for n = 1 : min(existing_ios, numios),
        old_name(n) =   cellstr(mask.getParameter(sprintf('name%i', n)).Value);
        old_width(n) =  cellstr(mask.getParameter(sprintf('bitwidth%i', n)).Value);
        old_type(n) =   cellstr(mask.getParameter(sprintf('arith_type%i', n)).Value);
        old_binpt(n) =  cellstr(mask.getParameter(sprintf('bin_pt%i', n)).Value);
    end
    % clear the mask and rewrite it
    io_dir = get_param(blk, 'io_dir');
    sample_period = get_param(blk, 'sample_period');
    io_delay = get_param(blk, 'io_delay');
    mask.removeAllParameters();
    % base setup parameters
    mask.addParameter('Prompt', 'Num I/Os', 'Name', 'numios', 'Value', num2str(numios), 'TabName', 'Setup', 'Callback', 't = timer(''StartDelay'', 0.1); t.TimerFcn = {@swreg_cb, gcb}; start(t);');
    cb = StringBuffer();
    cb.addcr('a = get_param(gcb, ''MaskEnables'');');
    cb.addcr(sprintf('if strcmp(get_param(gcb, ''io_dir''), ''To Processor''),'));
    cb.addcr(sprintf('a(4) = {''off''};'));
    cb.addcr(sprintf('else'));
    cb.addcr(sprintf('a(4) = {''on''};'));
    cb.addcr(sprintf('end'));
    cb.addcr(sprintf('set_param(gcb, ''MaskEnables'', a);'));
    mask.addParameter('Prompt', 'I/O direction', 'Name', 'io_dir', 'Value', io_dir, 'TabName', 'Setup', 'Type', 'popup', 'TypeOptions', {'To Processor','From Processor'}, 'Callback', cb.string()); clear cb;
    if strcmp(io_dir, 'From Processor'),
        sample_enabled = 'on';
    else
        sample_enabled = 'off';
    end
    mask.addParameter('Prompt', 'I/O delay', 'Name', 'io_delay', 'Value', io_delay, 'TabName', 'Setup');
    mask.addParameter('Prompt', 'Sample period', 'Name', 'sample_period', 'Value', sample_period, 'TabName', 'Setup', 'Enabled', sample_enabled);
    % copy in old values
    for n = 1 : numel(old_name),
        add_param(mask, n, char(old_name(n)), char(old_width(n)), char(old_type(n)), char(old_binpt(n)));
    end
    % and add new as neccessary
    for n = numel(old_name) + 1 : numios,
        add_param(mask, n, sprintf('io%i', n), '2', 'Unsigned', '0');
    end
    % open the block again after it is forced to close by matlab
    t2 = timer('StartDelay', 0.1);
    t2.TimerFcn = @(src,evt)open_system(blk,'mask');
    start(t2)
end

end % function end