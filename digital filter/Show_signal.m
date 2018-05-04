function varargout = Show_signal(varargin)
% SHOW_SIGNAL MATLAB code for Show_signal.fig
%      SHOW_SIGNAL, by itself, creates a new SHOW_SIGNAL or raises the existing
%      singleton*.
%
%      H = SHOW_SIGNAL returns the handle to a new SHOW_SIGNAL or the handle to
%      the existing singleton*.
%
%      SHOW_SIGNAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHOW_SIGNAL.M with the given input arguments.
%
%      SHOW_SIGNAL('Property','Value',...) creates a new SHOW_SIGNAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Show_signal_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Show_signal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Show_signal

% Last Modified by GUIDE v2.5 15-Mar-2018 19:45:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Show_signal_OpeningFcn, ...
                   'gui_OutputFcn',  @Show_signal_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Show_signal is made visible.
function Show_signal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Show_signal (see VARARGIN)
% Choose default command line output for Show_signal
handles.output = hObject;
set(handles.apply,'Enable','off');
set(handles.Filter,'Enable','off');
set(handles.C1,'Enable','off')
set(handles.C2,'Enable','off')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Show_signal wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Show_signal_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
global sig;
[FileName, PathName] = uigetfile({'*.jpg;*.mat;*.bmp;*.png'},'File Selector');
sig =load( fullfile(PathName,FileName));
axes(handles.axes1)
plot(sig.val(1,:))
% --- Executes during
set(handles.C1,'Enable','on')
set(handles.Filter,'Enable','on');

% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in apply.
function apply_Callback(hObject, eventdata, handles)
% hObject    handle to apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sig;
b = getappdata(0,'num_g')
a = getappdata(0,'den_g')
sig_filtered = filter(b,a,sig.val(1,:));
axes(handles.axes2)
plot(sig_filtered);
set(handles.C2,'Enable','on')

function T1_Callback(hObject, eventdata, handles)
% hObject    handle to T1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of T1 as text
%        str2double(get(hObject,'String')) returns contents of T1 as a double


% --- Executes during object creation, after setting all properties.
function T1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T2_Callback(hObject, eventdata, handles)
% hObject    handle to T2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T2 as text
%        str2double(get(hObject,'String')) returns contents of T2 as a double


% --- Executes during object creation, after setting all properties.
function T2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T3_Callback(hObject, eventdata, handles)
% hObject    handle to T3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T3 as text
%        str2double(get(hObject,'String')) returns contents of T3 as a double


% --- Executes during object creation, after setting all properties.
function T3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton6.


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in C1.
function C1_Callback(hObject, eventdata, handles)
% hObject    handle to C1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structurec with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of C1
check = get (handles.C1,'value');
if check ==1 
    set (handles.axes1,'XGrid','On');
    set (handles.axes1,'YGrid','On');
else 
     set (handles.axes1,'XGrid','Off');
     set (handles.axes1,'YGrid','Off');
end


% --- Executes on button press in C2.
function C2_Callback(hObject, eventdata, handles)
% hObject    handle to C2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of C2
check = get (handles.C2,'value');
if check ==1 
    set (handles.axes2,'XGrid','On');
    set (handles.axes2,'YGrid','On');
else 
     set (handles.axes2,'XGrid','Off');
     set (handles.axes2,'YGrid','Off');
end


% --- Executes on button press in Filter.
function Filter_Callback(hObject, eventdata, handles)
% hObject    handle to Filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 unit_circle
set(handles.apply,'Enable','on');