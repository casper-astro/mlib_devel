%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2006 University of California, Berkeley                     %
%                                                                             %
%   This program is free software; you can redistribute it and/or modify      %
%   it under the terms of the GNU General Public License as published by      %
%   the Free Software Foundation; either version 2 of the License, or         %
%   (at your option) any later version.                                       %
%                                                                             %
%   This program is distributed in the hope that it will be useful,           %
%   but WITHOUT ANY WARRANTY; without even the implied warranty of            %
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             %
%   GNU General Public License for more details.                              %
%                                                                             %
%   You should have received a copy of the GNU General Public License along   %
%   with this program; if not, write to the Free Software Foundation, Inc.,   %
%   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.               %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout = casper_xps(varargin)
% CASPER_XPS CASPER Xilinx ISE Batch Tools GUI

% Last Modified by GUIDE v2.5 06-Jun-2016 10:24:57

if nargin == 0  % LAUNCH GUI

    fig = openfig(mfilename,'reuse');

    % Use system color scheme for figure:
    set(fig,'Color',get(0,'defaultUicontrolBackgroundColor'));

    % Generate a structure of handles to pass to callbacks, and store it.
    handles = guihandles(fig);
    guidata(fig, handles);

    if nargout > 0
        varargout{1} = fig;
    end
    if ~isempty(gcs)
        set(handles.design_name,'String',gcs);
    end


    %get the Xilinx Sysgen version
    xsg = xlVersion;

    try
        xsg = strtok(xsg{1},' ');
    catch
        xsg = get_xlVersion('full');
    end

    switch xsg
        case {'11.3.2055'}
            set(handles.xsg_version,'String','11.3');
        case {'11.4.2254'}
            set(handles.xsg_version,'String','11.4');
        case {'11.5.2275'}
            set(handles.xsg_version,'String','11.5');
        case {'13.3'}
            set(handles.xsg_version,'String','13.3');
        case {'14.2'}
            set(handles.xsg_version,'String','14.2');
        case {'14.3'}
            set(handles.xsg_version,'String','14.3');
        case {'14.4'}
            set(handles.xsg_version,'String','14.4');
        case {'14.5'}
            set(handles.xsg_version,'String','14.5');
        case {'14.6'}
            set(handles.xsg_version,'String','14.6');
        case {'14.7'}
            set(handles.xsg_version,'String','14.7');
        otherwise
            errordlg(['Unsupported Xilinx System Generator version: ',xsg]);
            return;
    end

elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK

    try
        if (nargout)
            [varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
        else
            feval(varargin{:}); % FEVAL switchyard
        end
    catch ex
        disp(ex.message);
    end

end


%| ABOUT CALLBACKS:
%| GUIDE automatically appends subfunction prototypes to this file, and
%| sets objects' callback parameters to call them through the FEVAL
%| switchyard above. This comment describes that mechanism.
%|
%| Each callback subfunction declaration has the following form:
%| <SUBFUNCTION_NAME>(H, EVENTDATA, HANDLES, VARARGIN)
%|
%| The subfunction name is composed using the object's Tag and the
%| callback type separated by '_', e.g. 'slider2_Callback',
%| 'figure1_CloseRequestFcn', 'axis1_ButtondownFcn'.
%|
%| H is the callback object's handle (obtained using GCBO).
%|
%| EVENTDATA is empty, but reserved for future use.
%|
%| HANDLES is a structure containing handles of components in GUI using
%| tags as fieldnames, e.g. handles.figure1, handles.slider2. This
%| structure is created at GUI startup using GUIHANDLES and stored in
%| the figure's application data using GUIDATA. A copy of the structure
%| is passed to each callback.  You can store additional information in
%| this structure at GUI startup, and you can change the structure
%| during callbacks.  Call guidata(h, handles) after changing your
%| copy to replace the stored original so that subsequent callbacks see
%| the updates. Type "help guihandles" and "help guidata" for more
%| information.
%|
%| VARARGIN contains any extra arguments you have passed to the
%| callback. Specify the extra arguments by editing the callback
%| property in the inspector. By default, GUIDE sets the property to:
%| <MFILENAME>('<SUBFUNCTION_NAME>', gcbo, [], guidata(gcbo))
%| Add any extra arguments after the last argument, before the final
%| closing parenthesis.



% --------------------------------------------------------------------
function varargout = listbox1_Callback(h, eventdata, handles, varargin)




% --------------------------------------------------------------------
function varargout = run_Callback(h, eventdata, handles, varargin)
design_name = get(handles.design_name,'String');
xsg_version = get(handles.xsg_version,'Value');

flow_vec.update = get(handles.run_update , 'Value');
flow_vec.drc = get(handles.run_drc , 'Value');
flow_vec.xsg = get(handles.run_xsg , 'Value');
flow_vec.copy = get(handles.run_copy , 'Value');
flow_vec.ip = get(handles.run_ip , 'Value');
flow_vec.edkgen = get(handles.run_edkgen , 'Value');
flow_vec.elab = get(handles.run_elab , 'Value');
flow_vec.software = get(handles.run_software , 'Value');
flow_vec.edk = get(handles.run_edk , 'Value');
flow_vec.smartxplorer = get(handles.use_smartxplorer, 'Value');
flow_vec.smartxplorer_num = get(handles.smartxplorer_num, 'Value');

% Clear any previously dumped exceptions
dump_exception('');

try
    [time_total, time_struct] = gen_xps_files(design_name,flow_vec);
    disp('===================================================================');
    disp(['Flow run time summary: (',datestr(time_total,13),' seconds total)']);
    disp(['    System update............',datestr(time_struct.update  ,13)]);
    disp(['    Design Rules Check.......',datestr(time_struct.drc     ,13)]);
    disp(['    Xilinx System Generator..',datestr(time_struct.xsg     ,13)]);
    disp(['    Base system copy.........',datestr(time_struct.copy    ,13)]);
    disp(['    IP creation..............',datestr(time_struct.ip      ,13)]);
    disp(['    EDK files creation.......',datestr(time_struct.edkgen  ,13)]);
    disp(['    IP elaboration...........',datestr(time_struct.elab    ,13)]);
    disp(['    Software creation........',datestr(time_struct.software,13)]);
    disp(['    EDK/ISE backend..........',datestr(time_struct.edk     ,13)]);
    disp('===================================================================');
    msgbox(['CASPER XPS run successfully completed in ',datestr(time_total,13),'!']);
catch ex
    dump_exception(ex);
    errordlg(sprintf('Error detected running CASPER XPS:\n%s', ex.message));
end




% --------------------------------------------------------------------
function varargout = view_log_Callback(h, eventdata, handles, varargin)
sys = get(handles.design_name,'String');
view_choice = get(handles.log_menu,'Value');
view_shortcuts = get(handles.log_menu,'String');


xps_xsg_blks = find_system(sys,'FollowLinks','on','LookUnderMasks','all','Tag','xps:xsg');
if length(xps_xsg_blks) ~= 1
    error('There has to be only 1 XPS_xsg block on each chip level (sub)system');
end
xsg_blk = xps_xsg_blks{1};

sysgen_blk = find_system(sys, 'SearchDepth', 1,'FollowLinks','on','LookUnderMasks','all','Tag','genX');
if length(sysgen_blk) ~= 1
    error('XPS_xsg block must be on the same level as the Xilinx SysGen block');
end


[hw_sys, hw_subsys] = xps_get_hw_plat(get_param(xsg_blk,'hw_sys'));
work_path = [pwd,'\',clear_name(get_param(xsg_blk,'parent'))];
xps_path = [work_path,'\XPS_',hw_sys,'_base'];
xsg_path = [work_path,'\sysgen'];

xsg_core_name = clear_name(get_param(xsg_blk,'parent'));
design_name = [xsg_core_name,'_clk_wrapper'];


switch view_shortcuts{view_choice}
    case 'EDK Log'
        if ~exist([xps_path,'/system.log'])
            errordlg('EDK log file does not exist, please make sure you have run EDK/ISE step first.');
            return;
        end
        edit([xps_path,'/system.log']);
    case 'XFLOW Log'
        if ~exist([xps_path,'/implementation/xflow.log'])
            errordlg('XFLOW log file does not exist, please make sure you have run EDK/ISE step first.');
            return;
        end
        edit([xps_path,'/implementation/xflow.log']);
    case 'MAP Report'
        if ~exist([xps_path,'/implementation/system_map.mrp'])
            errordlg('MAP report file does not exist, please make sure you have run EDK/ISE step first.');
            return;
        end
        edit([xps_path,'/implementation/system_map.mrp']);
    case 'Timing Report'
        if ~exist([xps_path,'/implementation/system.twr'])
            errordlg('Timing report file does not exist, please make sure you have run EDK/ISE step first.');
            return;
        end
        edit([xps_path,'/implementation/system.twr']);
    otherwise
        error(['Unkown log choice: ',view_shortcuts{view_choice}]);
end
return;


% --------------------------------------------------------------------
function varargout = get_gcs_Callback(h, eventdata, handles, varargin)
set(handles.design_name,'String',gcs);
return;


% --------------------------------------------------------------------
function varargout = open_sys_Callback(h, eventdata, handles, varargin)
design_name = get(handles.design_name,'String');
if isempty(gcs) | ~strcmp(gcs,design_name)
    try
        open_system(design_name);
    catch
        errordlg(sprintf('Error cannot open system %c%s%c',39, design_name, 39));
        return;
    end
end
return;



% --- Executes on button press in run_mode.
function run_mode_Callback(hObject, eventdata, handles)
% hObject    handle to run_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of run_mode




% --- Executes on button press in run_elab.
function run_elab_Callback(hObject, eventdata, handles)
% hObject    handle to run_elab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of run_elab


% --- Executes on selection change in design_flow.
function design_flow_Callback(hObject, eventdata, handles)
% hObject    handle to design_flow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns design_flow contents as cell array
%        contents{get(hObject,'Value')} returns selected item from design_flow

flow_shortcuts = get(handles.design_flow,'String');
flow_choice = get(handles.design_flow,'Value');
switch flow_shortcuts{flow_choice}
    case 'Complete Build'
    	set(handles.run_update  ,'Value',1);
    	set(handles.run_drc     ,'Value',1);
    	set(handles.run_xsg     ,'Value',1);
    	set(handles.run_copy    ,'Value',1);
    	set(handles.run_ip      ,'Value',1);
    	set(handles.run_edkgen  ,'Value',1);
    	set(handles.run_elab    ,'Value',1);
    	set(handles.run_software,'Value',1);
    	set(handles.run_edk     ,'Value',1);
    case 'Software Only'
    	set(handles.run_update  ,'Value',0);
    	set(handles.run_drc     ,'Value',0);
    	set(handles.run_xsg     ,'Value',0);
    	set(handles.run_copy    ,'Value',0);
    	set(handles.run_ip      ,'Value',0);
    	set(handles.run_edkgen  ,'Value',0);
    	set(handles.run_elab    ,'Value',0);
    	set(handles.run_software,'Value',1);
    	set(handles.run_edk     ,'Value',1);
    case 'Download'
    	set(handles.run_update  ,'Value',0);
    	set(handles.run_drc     ,'Value',0);
    	set(handles.run_xsg     ,'Value',0);
    	set(handles.run_copy    ,'Value',0);
    	set(handles.run_ip      ,'Value',0);
    	set(handles.run_edkgen  ,'Value',0);
    	set(handles.run_elab    ,'Value',0);
    	set(handles.run_software,'Value',0);
    	set(handles.run_edk     ,'Value',0);
    otherwise
        error(['Unknown design flow shortcut: ',flow_shortcuts{flow_choice}]);
end



% --- Executes on button press in run_ip.
function run_ip_Callback(hObject, eventdata, handles)
% hObject    handle to run_ip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of run_ip




% --- Executes on button press in run_copy.
function run_copy_Callback(hObject, eventdata, handles)
% hObject    handle to run_copy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of run_copy





function design_name_Callback(hObject, eventdata, handles)
% hObject    handle to design_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of design_name as text
%        str2double(get(hObject,'String')) returns contents of design_name as a double




% --- Executes on button press in run_edk.
function run_edk_Callback(hObject, eventdata, handles)
% hObject    handle to run_edk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of run_edk




% --- Executes on button press in run_xsg.
function run_xsg_Callback(hObject, eventdata, handles)
% hObject    handle to run_xsg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of run_xsg




% --- Executes on button press in run_software.
function run_software_Callback(hObject, eventdata, handles)
% hObject    handle to run_software (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of run_software




% --- Executes on button press in run_edkgen.
function run_edkgen_Callback(hObject, eventdata, handles)
% hObject    handle to run_edkgen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of run_edkgen


% --- Executes on button press in run_drc.
function run_drc_Callback(hObject, eventdata, handles)
% hObject    handle to run_drc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of run_drc


% --- Executes on button press in run_update.
function run_update_Callback(hObject, eventdata, handles)
% hObject    handle to run_update (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of run_update


% --- Executes on selection change in smartxplorer_num.
function smartxplorer_num_Callback(hObject, eventdata, handles)
% hObject    handle to smartxplorer_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns smartxplorer_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from smartxplorer_num


% --- Executes during object creation, after setting all properties.
function smartxplorer_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smartxplorer_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in use_smartxplorer.
function use_smartxplorer_Callback(hObject, eventdata, handles)
% hObject    handle to use_smartxplorer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of use_smartxplorer
