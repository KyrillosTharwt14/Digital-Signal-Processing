function varargout = unit_circle(varargin)
% UNIT_CIRCLE MATLAB code for unit_circle.fig
%      UNIT_CIRCLE, by itself, creates a new UNIT_CIRCLE or raises the existing
%      singleton*.
%
%      H = UNIT_CIRCLE returns the handle to a new UNIT_CIRCLE or the handle to
%      the existing singleton*.
%
%      UNIT_CIRCLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNIT_CIRCLE.M with the given input arguments.
%
%      UNIT_CIRCLE('Property','Value',...) creates a new UNIT_CIRCLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before unit_circle_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to unit_circle_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help unit_circle

% Last Modified by GUIDE v2.5 15-Mar-2018 17:29:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @unit_circle_OpeningFcn, ...
                   'gui_OutputFcn',  @unit_circle_OutputFcn, ...
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


% --- Executes just before unit_circle is made visible.
function unit_circle_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to unit_circle (see VARARGIN)

%draw unit circle
DrawUnitCircle(hObject, eventdata, handles)

t=[0:0.1:20];
A=0.5;
f=1;
y=A*cos(f*t);
%calculate signal fft
handles.y_fft=fft(y);

handles.p=[];   % Array holds poles in complex formula
handles.z=[];   % Array holds zeros in complex formula

handles.P=[];   % Array holds poles points in the listBox in string formula
handles.Z=[];   % Array holds zeros points in the listBox in string formula

% Choose default command line output for unit_circle
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes unit_circle wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = unit_circle_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in AddZero.
function AddZero_Callback(hObject, eventdata, handles)
% hObject    handle to AddZero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%click to add a zero point in the unit circle
[x,y]=myginput(1,'hand');
%push a point and its conjugate to the zeros array 
handles.z(length(handles.z)+1)=x+1j*y;
% Update handles structure
guidata(hObject, handles);
%plot the freq response and its effect in the original signal
freq_plot(hObject, eventdata, handles);
%push a point and its conjugate to the zeros listbox array 
handles.Z{length(handles.Z)+1}=['(',num2str(x),' , ',num2str(y),')'];
%show the listbox with all added points
set(handles.listbox1,'String',(handles.Z));
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in DeleteZero.
function DeleteZero_Callback(hObject, eventdata, handles)
% hObject    handle to DeleteZero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
%click to remove a zero point in the unit circle
[x,y]=myginput(1,'hand');
%search for the selected zero from the zero array and remove it
temp=find((real(handles.z <(x+0.1)) & real(handles.z>(x-0.1))));
handles.z(find((real(handles.z <(x+0.1)) & real(handles.z>(x-0.1)))))=[];
%remove the selected zero from  the listBox
handles.Z(temp)=[];
% Update handles structure
guidata(hObject, handles);
%plot the freq response and its effect in the original signal
freq_plot(hObject, eventdata, handles);
%show the listbox after removing points
set(handles.listbox1,'String',handles.Z);
% Update handles structure
guidata(hObject, handles);


function DrawUnitCircle(hObject, eventdata, handles)
circle_1 = exp(1i*(0:63)*2*pi/64); 
 axes(handles.axes1)
plot(real(circle_1),imag(circle_1),'.');
axis([-2 2 -2 2]); 
axis('equal'); 
hold on
plot( [0 0], [1.5 -1.5], '-')
plot( [1.5 -1.5], [0 0], '-')
xlim([-1.5 1.5])
ylim([-1.5 1.5])
hold off;
% Update handles structure
guidata(hObject, handles);

function freq_plot(hObject, eventdata, handles)
%clear the unit circuit axes
cla(handles.axes1,'reset');
axes(handles.axes1)
DrawUnitCircle(hObject, eventdata, handles);
hold on
%plot poles and zeros markers
plot_p=plot(real(handles.p),imag(handles.p),'X');
plot_z=plot(real(handles.z),imag(handles.z),'O');
set(plot_p,'markersize',8,'linewidth',1.5,'Color', [255 100 100]/255);
set(plot_z,'markersize',8,'linewidth',1.5,'Color', [105 100 200]/255);
hold off;
%Get the transfer function coeffecients
[num,den]=zp2tf(handles.z',handles.p,1);
setappdata(0,'num_g',num)
setappdata(0,'den_g',den)

%Get the frequency response 
[h,w] = freqz(num,den,length(handles.y_fft));
%plot the frequency response mag 

if (isempty(handles.p) && isempty(handles.z))
    cla(handles.axes2,'reset')
else
    axes(handles.axes2)
    plot(w/pi,20*log10(abs(h)))
    xlabel('Normalized Frequency (\times\pi rad/sample)')
    ylabel('Magnitude (dB)')
    grid on;
end
% Update handles structure
guidata(hObject, handles);

  
     


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in AddPole.
function AddPole_Callback(hObject, eventdata, handles)
% hObject    handle to AddPole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[x,y]=myginput(1,'hand');
%push a point and its conjugate to the poles array 
handles.p(length(handles.p)+1)=x+1j*y;
% Update handles structure
guidata(hObject, handles);
%plot the freq response and its effect in the original signal
freq_plot(hObject, eventdata, handles);
%push a point and its conjugate to the poles listbox array 
handles.P{length(handles.P)+1}=['(',num2str(x),' , ',num2str(y),')'];
%show the listbox with all added points
set(handles.listbox2,'String',(handles.P));
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in DeletePole.
function DeletePole_Callback(hObject, eventdata, handles)
% hObject    handle to DeletePole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[x,y]=myginput(1,'hand');
%search for the selected pole from the poles array and remove it
temp=find(real(handles.p <(x+0.1)) & real(handles.p>(x-0.1)) );
handles.p(find(real(handles.p <(x+0.1)) & real(handles.p>(x-0.1)) ))=[];
%remove the selected pole from  the listBox
handles.P(temp)=[];
% Update handles structure
guidata(hObject, handles);
%plot the freq response and its effect in the original signal
freq_plot(hObject, eventdata, handles);
%show the listbox after removing  points
set(handles.listbox2,'String',handles.P);
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in ClearAllData.
function ClearAllData_Callback(hObject, eventdata, handles)
% hObject    handle to ClearAllData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%clear all arrays
handles.p=[];
handles.z=[];
handles.Z=[];
handles.P=[];
%clear all plots
cla(handles.axes1,'reset')
cla(handles.axes2,'reset')
DrawUnitCircle(hObject, eventdata, handles)
%update the listBoxes after clearing all
set(handles.listbox1,'String',handles.p);
set(handles.listbox2,'String',handles.z);
% Update handles structure
guidata(hObject, handles);
