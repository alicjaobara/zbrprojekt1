%program wizualizacji ruchu robota
function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 10-Apr-2018 20:32:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @gui_OpeningFcn, ...
    'gui_OutputFcn',  @gui_OutputFcn, ...
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

% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

%dane pocz¹tkowe
d1=-1;d2=-1;d5=-1; %delta=[d1 d2 d5];
l1=600;l2=2000;l3=3200;d=600;e=500;% geoR=[l1 l2 l3 d e];
l4=600;l5=400;l6=300;l=l5+l6;% geoL=[l4 l5 l6];
theta=30;psi=40;% wekpod=[theta ksi];
St=sin(theta*pi/180);Ct=cos(theta*pi/180);Sp=sin(psi*pi/180);Cp=cos(psi*pi/180);
xpocz=0; ypocz=750; zpocz=1000;% wpkt1=[];
xkon=1000; ykon=1750; zkon=2000;% wpkt2=[];
kroki=10;

set(handles.editd1,'string',num2str(d1));
set(handles.editd2,'string',num2str(d2));
set(handles.editd5,'string',num2str(d5));
set(handles.editl1,'string',num2str(l1));
set(handles.editl2,'string',num2str(l2));
set(handles.editl3,'string',num2str(l3));
set(handles.editl4,'string',num2str(l4));
set(handles.editl5,'string',num2str(l5));
set(handles.editl6,'string',num2str(l6));
set(handles.editd,'string',num2str(d));
set(handles.edite,'string',num2str(e));
set(handles.editth,'string',num2str(theta));
set(handles.editpsi,'string',num2str(psi));
set(handles.editxp,'string',num2str(xpocz));
set(handles.edityp,'string',num2str(ypocz));
set(handles.editzp,'string',num2str(zpocz));
set(handles.editxk,'string',num2str(xkon));
set(handles.edityk,'string',num2str(ykon));
set(handles.editzk,'string',num2str(zkon));
set(handles.editkroki,'string',num2str(kroki));
[X,Y,Z,fi,zn] = oblicz(kroki,xpocz,ypocz,zpocz,xkon,ykon,zkon,St,Ct,Sp,Cp,d1,d2,d5,l1,l2,l3,d,e,l4,l);
if zn~=1
    Kroki=[1:1:kroki];
    axes(handles.wykreswm);
    plot(Kroki,fi);
    legend('fi1','fi2','fi3','fi4','fi5','Location','northoutside','Orientation','horizontal');
    for i = 1:kroki
        % wykresy 2d
        % subplot(2,2,3);plot(X,Y);title('XY');
        % subplot(2,2,1);plot(X,Z);title('XZ');
        % subplot(2,2,2);plot(Y,Z);title('YZ');
        
        % wykres3d 3d animacja
        axes(handles.wykres3d);
        plot3(X(i,:),Y(i,:),Z(i,:));
        pause(0.1);
    end
    
else
    run mydialog
end

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in animacjaprzycisk.
function animacjaprzycisk_Callback(hObject, eventdata, handles)
% hObject    handle to animacjaprzycisk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
d1=str2num(get(handles.editd1,'string'));
d2=str2num(get(handles.editd2,'string'));
d5=str2num(get(handles.editd5,'string'));
l1=str2num(get(handles.editl1,'string'));
l2=str2num(get(handles.editl2,'string'));
l3=str2num(get(handles.editl3,'string'));
l4=str2num(get(handles.editl4,'string'));
l5=str2num(get(handles.editl5,'string'));
l6=str2num(get(handles.editl6,'string')); l=l5+l6;
d=str2num(get(handles.editd,'string'));
e=str2num(get(handles.edite,'string'));
theta=str2num(get(handles.editth,'string'));
psi=str2num(get(handles.editpsi,'string'));
St=sin(theta*pi/180);Ct=cos(theta*pi/180);Sp=sin(psi*pi/180);Cp=cos(psi*pi/180);
xpocz=str2num(get(handles.editxp,'string'));
ypocz=str2num(get(handles.edityp,'string'));
zpocz=str2num(get(handles.editzp,'string'));
xkon=str2num(get(handles.editxk,'string'));
ykon=str2num(get(handles.edityk,'string'));
zkon=str2num(get(handles.editzk,'string'));
kroki=str2num(get(handles.editkroki,'string'));

[X,Y,Z,fi,zn] = oblicz(kroki,xpocz,ypocz,zpocz,xkon,ykon,zkon,St,Ct,Sp,Cp,d1,d2,d5,l1,l2,l3,d,e,l4,l);
if zn~=1
    Kroki=[1:1:kroki];
    for i = 1:kroki
        % wykresy 2d
        % subplot(2,2,3);plot(X,Y);title('XY');
        % subplot(2,2,1);plot(X,Z);title('XZ');
        % subplot(2,2,2);plot(Y,Z);title('YZ');
        
        % wykres3d 3d animacja
        axes(handles.wykres3d);
        plot3(X(i,:),Y(i,:),Z(i,:));
        pause(0.1);
    end
    axes(handles.wykreswm);
    plot(Kroki,fi);
    legend('fi1','fi2','fi3','fi4','fi5','Location','eastoutside');
else
    run mydialog
end



function editd1_Callback(hObject, eventdata, handles)
% hObject    handle to editd1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editd1 as text
%        str2double(get(hObject,'String')) returns contents of editd1 as a double
if handles.editd1 ~="1" && handles.editd1~="-1"
    set(handles.editd1,'string',num2str(1));
end


% --- Executes during object creation, after setting all properties.
function editd1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editd1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editth_Callback(hObject, eventdata, handles)
% hObject    handle to editth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editth as text
%        str2double(get(hObject,'String')) returns contents of editth as a double
if str2double(get(hObject,'String'))<=0 || isempty(get(hObject,'String'))
    set(hObject,'string',num2str(100));
end

% --- Executes during object creation, after setting all properties.
function editth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editpsi_Callback(hObject, eventdata, handles)
% hObject    handle to editpsi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editpsi as text
%        str2double(get(hObject,'String')) returns contents of editpsi as a double
if str2double(get(hObject,'String'))<=0 || isempty(get(hObject,'String'))
    set(hObject,'string',num2str(100));
end

% --- Executes during object creation, after setting all properties.
function editpsi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editpsi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editl1_Callback(hObject, eventdata, handles)
% hObject    handle to editl1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editl1 as text
%        str2double(get(hObject,'String')) returns contents of editl1 as a double
if str2double(get(hObject,'String'))<=0 || isempty(get(hObject,'String'))
    set(hObject,'string',num2str(100));
end

% --- Executes during object creation, after setting all properties.
function editl1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editl1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editl2_Callback(hObject, eventdata, handles)
% hObject    handle to editl2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editl2 as text
%        str2double(get(hObject,'String')) returns contents of editl2 as a double
if str2double(get(hObject,'String'))<=0 || isempty(get(hObject,'String'))
    set(hObject,'string',num2str(100));
end

% --- Executes during object creation, after setting all properties.
function editl2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editl2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editl3_Callback(hObject, eventdata, handles)
% hObject    handle to editl3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editl3 as text
%        str2double(get(hObject,'String')) returns contents of editl3 as a double
if str2double(get(hObject,'String'))<=0 || isempty(get(hObject,'String'))
    set(hObject,'string',num2str(100));
end

% --- Executes during object creation, after setting all properties.
function editl3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editl3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editl4_Callback(hObject, eventdata, handles)
% hObject    handle to editl4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editl4 as text
%        str2double(get(hObject,'String')) returns contents of editl4 as a double
if str2double(get(hObject,'String'))<=0 || isempty(get(hObject,'String'))
    set(hObject,'string',num2str(100));
end

% --- Executes during object creation, after setting all properties.
function editl4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editl4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editl5_Callback(hObject, eventdata, handles)
% hObject    handle to editl5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editl5 as text
%        str2double(get(hObject,'String')) returns contents of editl5 as a double
if str2double(get(hObject,'String'))<=0 || isempty(get(hObject,'String'))
    set(hObject,'string',num2str(100));
end

% --- Executes during object creation, after setting all properties.
function editl5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editl5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editl6_Callback(hObject, eventdata, handles)
% hObject    handle to editl6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editl6 as text
%        str2double(get(hObject,'String')) returns contents of editl6 as a double
if str2double(get(hObject,'String'))<=0 || isempty(get(hObject,'String'))
    set(hObject,'string',num2str(100));
end

% --- Executes during object creation, after setting all properties.
function editl6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editl6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editd_Callback(hObject, eventdata, handles)
% hObject    handle to editd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editd as text
%        str2double(get(hObject,'String')) returns contents of editd as a double
if str2double(get(hObject,'String'))<=0 || isempty(get(hObject,'String'))
    set(hObject,'string',num2str(100));
end

% --- Executes during object creation, after setting all properties.
function editd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edite_Callback(hObject, eventdata, handles)
% hObject    handle to edite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edite as text
%        str2double(get(hObject,'String')) returns contents of edite as a double
if str2double(get(hObject,'String'))<=0 || isempty(get(hObject,'String'))
    set(hObject,'string',num2str(100));
end

% --- Executes during object creation, after setting all properties.
function edite_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editkroki_Callback(hObject, eventdata, handles)
% hObject    handle to editkroki (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editkroki as text
%        str2double(get(hObject,'String')) returns contents of editkroki as a double
if str2double(get(hObject,'String'))<=0 || isempty(get(hObject,'String'))
    set(hObject,'string',num2str(100));
end

% --- Executes during object creation, after setting all properties.
function editkroki_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editkroki (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editxk_Callback(hObject, eventdata, handles)
% hObject    handle to editxk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editxk as text
%        str2double(get(hObject,'String')) returns contents of editxk as a double
if isempty(get(hObject,'String'))
    set(hObject,'string',num2str(100));
end
% --- Executes during object creation, after setting all properties.
function editxk_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editxk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editd2_Callback(hObject, eventdata, handles)
% hObject    handle to editd2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editd2 as text
%        str2double(get(hObject,'String')) returns contents of editd2 as a double
if handles.editd2 ~="1" && handles.editd2~="-1"
    set(handles.editd2,'string',num2str(1));
end

% --- Executes during object creation, after setting all properties.
function editd2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editd2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editzk_Callback(hObject, eventdata, handles)
% hObject    handle to editzk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editzk as text
%        str2double(get(hObject,'String')) returns contents of editzk as a double
if isempty(get(hObject,'String'))
    set(hObject,'string',num2str(100));
end

% --- Executes during object creation, after setting all properties.
function editzk_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editzk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editxp_Callback(hObject, eventdata, handles)
% hObject    handle to editxp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editxp as text
%        str2double(get(hObject,'String')) returns contents of editxp as a double
if isempty(get(hObject,'String'))
    set(hObject,'string',num2str(100));
end

% --- Executes during object creation, after setting all properties.
function editxp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editxp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edityp_Callback(hObject, eventdata, handles)
% hObject    handle to edityp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edityp as text
%        str2double(get(hObject,'String')) returns contents of edityp as a double
if isempty(get(hObject,'String'))
    set(hObject,'string',num2str(100));
end

% --- Executes during object creation, after setting all properties.
function edityp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edityp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editzp_Callback(hObject, eventdata, handles)
% hObject    handle to editzp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editzp as text
%        str2double(get(hObject,'String')) returns contents of editzp as a double
if isempty(get(hObject,'String'))
    set(hObject,'string',num2str(100));
end

% --- Executes during object creation, after setting all properties.
function editzp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editzp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edityk_Callback(hObject, eventdata, handles)
% hObject    handle to edityk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edityk as text
%        str2double(get(hObject,'String')) returns contents of edityk as a double
if isempty(get(hObject,'String'))
    set(hObject,'string',num2str(100));
end

% --- Executes during object creation, after setting all properties.
function edityk_CreateFcn(hObject, ~, handles)
% hObject    handle to edityk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editd5_Callback(hObject, eventdata, handles)
% hObject    handle to editd5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editd5 as text
%        str2double(get(hObject,'String')) returns contents of editd5 as a double
if handles.editd5 ~="1" && handles.editd5 ~="-1"
    set(handles.editd5,'string',num2str(1));
end

% --- Executes during object creation, after setting all properties.
function editd5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editd5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
