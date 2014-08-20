function casper_sl_goto_plusplus(~)
%--------------------------------------------------------------------------
% Description : Create 'From' blocks with same appearance and properties of
%               'Goto' blocks selected in the model
%
% Author:       Giacomo Faggiani
% Rev :         11-03-2009 - First version
%
%-------------------------------------------------------------------------

% Select blocks in the model
%It is better to use handle instead of path, there is a bug in the way
%Simulink use block names
%http://www.mathworks.com/support/solutions/en/data/1-O7JS8/?solution=1-O7JS8
GotoList = find_system(gcs, 'LookUnderMasks', 'all', 'SearchDepth', 1, 'Selected', 'on', 'BlockType', 'Goto');
GotoListHandle = get_param(GotoList, 'Handle');

if isempty(GotoList)
    % no Goto block selected.
    return
end

for i = 1 : length(GotoListHandle)

    % get tag name
    SignalName=get_param(GotoListHandle{i},'GotoTag');
    
    % change name accorging to Goto Tag.
    % if you have created this block by copy&paste.
    % it's probable that block name doesn't correspond to its tag
    set_param(GotoListHandle{i},'Name',['Goto_' SignalName]);   
    
    BlockForegroundColor=get_param(GotoListHandle{i},'ForegroundColor');
    BlockBackgroundColor=get_param(GotoListHandle{i},'BackgroundColor');
    BlockShowName=get_param(GotoListHandle{i},'ShowName');
    BlockFontName=get_param(GotoListHandle{i},'FontName');
    BlockFontSize=get_param(GotoListHandle{i},'FontSize');
    BlockFontWeight=get_param(GotoListHandle{i},'FontWeight');
    BlockFontAngle=get_param(GotoListHandle{i},'FontAngle');
    BlockTagVisibility=get_param(GotoListHandle{i},'TagVisibility');
    BlockDropShadow=get_param(GotoListHandle{i},'DropShadow');
    BlockNamePlacement=get_param(GotoListHandle{i},'NamePlacement');
    BlockOrientation= get_param(GotoListHandle{i},'Orientation');
    
    % Figure out new signal ID
    m   = regexp(SignalName, '(?<rootname>\w+)(?<idx>\d+)$', 'names');
    if isempty(m)
        NewSignalName = strcat(SignalName, '1')
    else
        idx = str2num(m.idx) + 1;
        NewSignalName = strcat(m.rootname, num2str(idx));
    end %if
    
    % check if corresponding block already exists
    NewBlockExist = find_system(gcs,'BlockType','Goto','GotoTag',NewSignalName);
    Path = GotoList{i}(1:max(regexp(gcb, '/'))-1);
    NewGotoId = strcat(Path,'/','Goto_',NewSignalName);
        
    if isempty(NewBlockExist)
        
        CurrBlockPosition=get_param(GotoListHandle{i},'Position');
        BlockLength=CurrBlockPosition(3)-CurrBlockPosition(1);
        NewBlockPosition(1)=CurrBlockPosition(3)+BlockLength/2; %Left
        NewBlockPosition(2)=CurrBlockPosition(2);%Top
        NewBlockPosition(3)=NewBlockPosition(1)+BlockLength;%Right
        NewBlockPosition(4)=CurrBlockPosition(4);%Bottom
        
        add_block('built-in/Goto',NewGotoId,...
            'GotoTag',NewSignalName,...
            'position',NewBlockPosition,...
            'ForegroundColor',BlockForegroundColor,...
            'BackgroundColor',BlockBackgroundColor,...
            'ShowName',BlockShowName,...
            'FontName',BlockFontName,...
            'FontSize',BlockFontSize,...
            'FontWeight',BlockFontWeight,...
            'FontAngle',BlockFontAngle,...
            'TagVisibility',BlockTagVisibility,...
            'DropShadow',BlockDropShadow,...
            'NamePlacement',BlockNamePlacement,...
            'Orientation',BlockOrientation);
    end

end %for


