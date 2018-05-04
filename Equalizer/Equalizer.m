
function varargout = equalizer(varargin)
% equalizer MATLAB code for equalizer.fig
%      equalizer, by itself, creates a new equalizer or raises the existing
%      singleton*.
%
%      H = equalizer returns the handle to a new equalizer or the handle to
%      the existing singleton*.
%
%      equalizer('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in equalizer.M with the given input arguments.
%
%      equalizer('Property','Value',...) creates a new equalizer or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before equalizer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to equalizer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help equalizer

% Last Modified by GUIDE v2.5 24-Apr-2018 02:17:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @equalizer_OpeningFcn, ...
                   'gui_OutputFcn',  @equalizer_OutputFcn, ...
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


% --- Executes just before equalizer is made visible.
function equalizer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to equalizer (see VARARGIN)

%trun off all

set(handles.play,'Enable','off');
set(handles.resume,'Enable','off');
set(handles.Stop,'Enable','off');
set(handles.Pause,'Enable','off');
set(handles.slider1,'Enable','off');
set(handles.slider2,'Enable','off');
set(handles.slider3,'Enable','off');
set(handles.slider4,'Enable','off');
set(handles.slider5,'Enable','off');
set(handles.slider6,'Enable','off');
set(handles.slider7,'Enable','off');
set(handles.slider8,'Enable','off');
% Choose default command line output for equalizer
handles.output = hObject;
% create an axes that spans the whole gui
ah = axes('unit', 'normalized', 'position', [0 0 1 1]); 
% import the background image and show it on the axes
bg = imread('RF_Signals.jpg'); imagesc(bg);
% prevent plotting over the background and turn the axis off
set(ah,'handlevisibility','off','visible','off')
% making sure the background is behind all the other uicontrols
uistack(ah, 'bottom');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes equalizer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = equalizer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Browes.
function Browes_Callback(hObject, eventdata, handles)
% hObject    handle to Browes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mode 
mode =  1      %sound mode

[filename pathname]= uigetfile ({'*.wav;*.mp3' } , 'File Selector' ) ;
handles.fullpathname = strcat ( pathname , filename) ;
set(handles.ShowPath,'String' , handles.fullpathname) ;

%turn on all 

set(handles.play,'Enable','on');
set(handles.resume,'Enable','on');
set(handles.Stop,'Enable','on');
set(handles.Pause,'Enable','on');
set(handles.slider1,'Enable','on');
set(handles.slider2,'Enable','on');
set(handles.slider3,'Enable','on');
set(handles.slider4,'Enable','on');
set(handles.slider5,'Enable','on');
set(handles.slider6,'Enable','on');
set(handles.slider7,'Enable','on');
set(handles.slider8,'Enable','on');
equalizer(hObject, handles) ;
guidata(hObject, handles);



function ShowPath_Callback(hObject, eventdata, handles)
% hObject    handle to ShowPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ShowPath as text
%        str2double(get(hObject,'String')) returns contents of ShowPath as a double


% --- Executes during object creation, after setting all properties.
function ShowPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ShowPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player
equalizer(hObject, handles) ;
%play(player);
guidata(hObject , handles)



function equalizer(hObject, handles)
global player;
global myRecording;
global mode 


if mode ==1        
    [sig,Fs] = audioread(handles.fullpathname);
    
elseif mode==2
    sig = myRecording;
    Fs=44100 ;
    
end
N = length(sig);

%%%gains
handles.gain1=get(handles.slider1,'value');
handles.gain2=get(handles.slider2,'value');
handles.gain3=get(handles.slider3,'value');
handles.gain4=get(handles.slider4,'value');
handles.gain5=get(handles.slider5,'value');
handles.gain6=get(handles.slider6,'value');
handles.gain7=get(handles.slider7,'value');
handles.gain8=get(handles.slider8,'value');

order=64;



% %bandpass1

f1=1;
f2=2500;
b1=fir1(order,[f1/(Fs/2) f2/(Fs/2)]);
y1=handles.gain1*filter(b1,1,sig);

% 
% %bandpass2
f3=2500;
f4=5000;
b2=fir1(order,[f3/(Fs/2) f4/(Fs/2)],'bandpass');
y2=handles.gain2*filter(b2,1,sig);
% 
% %bandpass3
f4=5000;
f5=7500;
b3=fir1(order,[f4/(Fs/2) f5/(Fs/2)],'bandpass');
y3=handles.gain3*filter(b3,1,sig);
% 
% %bandpass4
 f5=7500;
 f6=10000;
b4=fir1(order,[f5/(Fs/2) f6/(Fs/2)],'bandpass');
y4=handles.gain4*filter(b4,1,sig);
% 
% %bandpass5
f7=10000;
f8=12500;
b5=fir1(order,[f7/(Fs/2) f8/(Fs/2)],'bandpass');
y5=handles.gain5*filter(b5,1,sig);
% 
% %bandpass6
f9=12500;
f10=15000;
b6=fir1(order,[f9/(Fs/2) f10/(Fs/2)],'bandpass');
y6=handles.gain6*filter(b6,1,sig);
% 
% %bandpass7
 f11=15000;
 f12=17500;
 b7=fir1(order,[f11/(Fs/2) f12/(Fs/2)],'bandpass');
 y7=handles.gain7*filter(b7,1,sig);
% 
 % %bandpass8
f13=17500;
f14=20000;
b8=fir1(order,[f13/(Fs/2) f14/(Fs/2)],'bandpass');
y8=handles.gain8*filter(b8,1,sig);

new_sig=y1+y2+y3+y4+y5+y6+y7+y8 ;

player = audioplayer(new_sig, Fs);  




axes(handles.axes1) 
plot(sig(:,1)); 
xlim([0 N]);
 
axes(handles.axes2)
plot(new_sig(:,1));
xlim([0 N]);

% axes(handles.axes4)
% sig=2*abs(fft(sig));
% sig=sig(1:(N/2)+1);
% plot(sig);
% xlim([0 N/2]);
% 
% %
% axes(handles.axes5);
% new_sig=2*abs(fft(new_sig));
% new_sig=new_sig(1:(N/2)+1);
% plot(new_sig);
% xlim([0 N/2]);

guidata(hObject,handles)




% --- Executes on button press in Stop.
function Stop_Callback(hObject, eventdata, handles)
% hObject    handle to Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player
equalizer(hObject, handles) ;
%stop(player);
guidata(hObject , handles)

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
equalizer(hObject, handles) ;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
equalizer(hObject, handles) ;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
equalizer(hObject, handles) ;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
equalizer(hObject, handles) ;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
equalizer(hObject, handles) ;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
equalizer(hObject, handles) ;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
equalizer(hObject, handles) ;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
equalizer(hObject, handles) ;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Pause.
function Pause_Callback(hObject, eventdata, handles)
% hObject    handle to Pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player
equalizer(hObject, handles) ;
%pause(player);
guidata(hObject , handles)


% --- Executes on button press in resume.
function resume_Callback(hObject, eventdata, handles)
% hObject    handle to resume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player
equalizer(hObject, handles) ;
%resume(player);
guidata(hObject , handles)


% --- Executes on button press in LiveSound.
function LiveSound_Callback(hObject, eventdata, handles)
% hObject    handle to LiveSound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global myRecording;
global mode
mode =  2         %Recording mode

set(handles.play,'Enable','off');
set(handles.resume,'Enable','off');
set(handles.Stop,'Enable','off');
set(handles.Pause,'Enable','off');
set(handles.slider1,'Enable','on');
set(handles.slider2,'Enable','on');
set(handles.slider3,'Enable','on');
set(handles.slider4,'Enable','on');
set(handles.slider5,'Enable','on');
set(handles.slider6,'Enable','on');
set(handles.slider7,'Enable','on');
set(handles.slider8,'Enable','on');

flag = get(handles.LiveSound,'Value');
 while (flag)
recorderr = audiorecorder(44100,16,1);
set(handles. LiveSound,'string','Stop Recording...');
record(recorderr);
pause(.07);
myRecording = getaudiodata(recorderr);

equalizer(hObject, handles) ;
flag = get(handles. LiveSound,'value');
if flag==0
    set(handles. LiveSound,'string','Start Recording...');
end
end
% Hint: get(hObject,'Value') returns toggle state of LiveSound


% --- Executes on button press in SetZero.
function SetZero_Callback(hObject, eventdata, handles)
% hObject    handle to SetZero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.slider1,'Value',0);
set(handles.slider2,'Value',0);
set(handles.slider3,'Value',0);
set(handles.slider4,'Value',0);
set(handles.slider5,'Value',0);
set(handles.slider6,'Value',0);
set(handles.slider7,'Value',0);
set(handles.slider8,'Value',0);
equalizer(hObject, handles) ;

% --- Executes on button press in SetOne.
function SetOne_Callback(hObject, eventdata, handles)
% hObject    handle to SetOne (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.slider1,'Value',1);
set(handles.slider2,'Value',1);
set(handles.slider3,'Value',1);
set(handles.slider4,'Value',1);
set(handles.slider5,'Value',1);
set(handles.slider6,'Value',1);
set(handles.slider7,'Value',1);
set(handles.slider8,'Value',1);
equalizer(hObject, handles) ;


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
