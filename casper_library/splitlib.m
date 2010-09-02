function splitlib()

% Make sure casper_library is not already split apart
if ~strcmp(get_param('casper_library/Accumulators','OpenFcn'), '')
    error('casper_library has already been split');
end

% Make sure casper_library is unlocked
if ~strcmp(get_param('casper_library','Lock'), 'off')
    error('caser_library is locked');
end

% Find all non-masked subsystems
ss=find_system('casper_library', 'FollowLinks','off','LookUnderMasks','none','Mask','off');
% Omit casper_library/sources
ss=ss(1:end-1);
newlibnames=lower(strrep(ss, '/', '_'));

% Get casper_library block forwarding table
clft=get_param('casper_library', 'ForwardingTable');

% For all non-masked subsystems
for k=1:length(ss)
    s=ss{k};
    newlibname=newlibnames{k};
    
    % Create new library
    newlib = new_system(newlibname, 'Library');
    set_param(newlib, 'LibraryLinkDisplay', 'all');
    
    % Get list of masked subsystems in this subsystem (non-recursive)
    mss=find_system(s, 'SearchDepth',1, 'FollowLinks','off', 'LookUnderMasks','none', 'Mask','on');
    
    % For each masked block
    for l=1:length(mss)
        msold=mss{l};
        msnew=[newlibname, '/', get_param(msold,'Name')];
        
        % Copy block to new block diagram
        add_block(msold, msnew, 'LinkStatus', 'none');
    
        % Add entry to block forwarding table and update
        clft{end+1} = {msold; msnew};
    
    end

    % Get list of UNmasked subsystems in this subsystem (non-recursive)
    uss=find_system(s, 'SearchDepth',1, 'FollowLinks','off', 'LookUnderMasks','none', 'Mask','off');
    
    % For each UNmasked block
    for l=1:length(uss)
        usold=uss{l};
        % Skip self
        if strcmp(usold,s)
            continue;
        end
        usnew=[newlibname, '/', get_param(usold,'Name')];
        usnewopenfcn=lower(strrep(usnew, '/', '_'));
        p=get_param(usold,'Position');
    
        % Create new subsystem for sub-library
        add_block('built-in/Subsystem', usnew, 'Position', p, 'OpenFcn', usnewopenfcn);
    end

    
    % Close and save new library
    close_system(newlib,1);
end

% Update clft
set_param('casper_library', 'ForwardingTable', clft);
    
% For all non-masked subsystems
for k=1:length(ss)
    s=ss{k};
    newlibname=newlibnames{k};
    
    % Skip non-top-level blocks
    if regexp(s, '/.*/')
        continue;
    end

    % Remove old subsystem
    p=get_param(s,'Position');
    delete_block(s);
    
    % Create new subsystem
    add_block('built-in/Subsystem', s, 'Position', p, 'OpenFcn', newlibname);
end

% Display clft
for k=1:length(clft)
    ent=clft{k};
    fprintf(1, '{''%s'',''%s''}, ...\n', ent{1}, ent{2});
end

end