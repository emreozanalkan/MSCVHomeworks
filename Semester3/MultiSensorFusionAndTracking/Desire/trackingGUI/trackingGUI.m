


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab GUI for two tracking algorithms: Meanshift and feature-based
% tracking.
% Author: Taoran Lu (lvtaoran@ufl.edu)
% Department of Electrical and Computer Engineering
% University of Florida
% last modified Nov.2007
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function varargout = trackingGUI(varargin)
% TRACKINGGUI M-file for trackingGUI.fig
%      TRACKINGGUI, by itself, creates a new TRACKINGGUI or raises the existing
%      singleton*.
%
%      H = TRACKINGGUI returns the handle to a new TRACKINGGUI or the handle to
%      the existing singleton*.
%
%      TRACKINGGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRACKINGGUI.M with the given input_fig arguments.
%
%      TRACKINGGUI('Property','Value',...) creates a new TRACKINGGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mshiftGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to trackingGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help trackingGUI

% Last Modified by GUIDE v2.5 19-Nov-2007 20:26:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @trackingGUI_OpeningFcn, ...
    'gui_OutputFcn',  @trackingGUI_OutputFcn, ...
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


% --- Executes just before trackingGUI is made visible.
function trackingGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output_fig args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to trackingGUI (see VARARGIN)

% Choose default command line output_fig for trackingGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes trackingGUI wait for user response (see UIRESUME)
% uiwait(handles.feat);


% --- Outputs from this function are returned to the command line.
function varargout = trackingGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output_fig args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output_fig from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loadbutton.
function loadbutton_Callback(hObject, eventdata, handles)
% hObject    handle to loadbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Mv=aviread(handles.filename);
axes(handles.input_fig);
cla;
fid=fopen(handles.filename,'r');
qcif=fread(fid);
numofframes=(length(qcif)/25344)/1.5;
handles.nof=numofframes;
handles.StartFrame=1;
handles.EndFrame=numofframes;
guidata(hObject,handles);

qcif=reshape(qcif,176,216,numofframes);
for i=1:numofframes
    frame=uint8(qcif(:,1:144,i)');
    Mv(i).cdata(:,:,1)=frame;
    Mv(i).cdata(:,:,2)=frame;
    Mv(i).cdata(:,:,3)=frame;
    Mv(i).colormap=[];
end

%movie(Mv,1,60);

handles.Mv=Mv;
set(handles.slider1,'Min',1);
set(handles.slider1,'Max',handles.nof);
set(handles.slider1,'Value',1);
set(handles.slider1,'SliderStep',[1/(handles.nof-1) 1/(handles.nof-1)]);
set(handles.frameNum,'String',1);
guidata(hObject,handles)
set(handles.note,'String','Loading Done!');

% --- Executes on selection change in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns load contents as cell array
%        contents{get(hObject,'Value')} returns selected item from load
val = get(hObject,'Value');
string_list = get(hObject,'String');
selected_string = string_list{val};
handles.filename=selected_string;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function load_CreateFcn(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over load.
function load_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in track.
function track_Callback(hObject, eventdata, handles)
% hObject    handle to track (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Mv=handles.Mv(handles.StartFrame:handles.EndFrame);
%guidata(hObject,handles)
if get(handles.mshift,'value')==1
    outMv=camshift4gui(Mv,handles);
else if get(handles.feat,'value')==1
        outMv=feature4gui(Mv,handles);
    else set(handles.note,'String','Please select algorithm!');
        return;
    end
end
axes(handles.output_fig);
cla;
movie(outMv,1,60);
handles.outMv=outMv;
guidata(hObject,handles)

%%%%% If we want to cut the video during each tracking, excute the following
% handles.nof=handles.EndFrame+1-handles.StartFrame;
% handles.StartFrame=1;
% handles.EndFrame=handles.nof;
% guidata(hObject,handles)
% set(handles.slider1,'Min',1);
% set(handles.slider1,'Max',handles.nof);
% set(handles.slider1,'Value',1);
% set(handles.slider1,'SliderStep',[1/(handles.nof-1) 1/(handles.nof-1)]);


%%%%%%

% --- Executes on button press in avi.
function avi_Callback(hObject, eventdata, handles)
% hObject    handle to avi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name, path]=uiputfile('*.avi','Save movie as avi');
movie2avi(handles.outMv,[path name])



% --- Executes on button press in play1.
function play1_Callback(hObject, eventdata, handles)
% hObject    handle to play1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.input_fig);
cla;
movie(handles.Mv,1,60);


% --- Executes on button press in play2.
function play2_Callback(hObject, eventdata, handles)
% hObject    handle to play2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.output_fig);
cla;
movie(handles.outMv,1,60);



function note_Callback(hObject, eventdata, handles)
% hObject    handle to note (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of note as text
%        str2double(get(hObject,'String')) returns contents of note as a double




% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close;



% --- Executes on button press in gif.
function gif_Callback(hObject, eventdata, handles)
% hObject    handle to gif (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name, path]=uiputfile('*.gif','Save movie as gif');
oMv=handles.outMv;
N=size(oMv,2);
for i=1:N
    P(:,:,1,i)=oMv(i).cdata(:,:,1);
end
imwrite(P,[path name],'gif','DelayTime',1/60);


% --- Executes on slider1 movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.preview=ceil(get(hObject,'Value'));
guidata(hObject, handles);
% Hints: get(hObject,'Value') returns position of slider1
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider1
set(handles.frameNum,'String',handles.preview);
axes(handles.input_fig);
imshow(handles.Mv(handles.preview).cdata);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider1 controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on button press in loadother.
function loadother_Callback(hObject, eventdata, handles)
% hObject    handle to loadother (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name, path]=uigetfile('*.qcif','Open video sequence');

axes(handles.input_fig);
cla;
fid=fopen([path name],'r');
qcif=fread(fid);
numofframes=(length(qcif)/25344)/1.5;
handles.nof=numofframes;
handles.StartFrame=1;
handles.EndFrame=numofframes;
qcif=reshape(qcif,176,216,numofframes);
for i=1:numofframes
    frame=uint8(qcif(:,1:144,i)');
    Mv(i).cdata(:,:,1)=frame;
    Mv(i).cdata(:,:,2)=frame;
    Mv(i).cdata(:,:,3)=frame;
    Mv(i).colormap=[];
end

movie(Mv,1,60);
handles.Mv=Mv;

set(handles.slider1,'Min',1);
set(handles.slider1,'Max',handles.nof);
set(handles.slider1,'Value',1);
set(handles.slider1,'SliderStep',[1/(handles.nof-1) 1/(handles.nof-1)]);
set(handles.frameNum,'String',1);

guidata(hObject,handles)



% --- Executes on button press in Startbutton.
function Startbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Startbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.StartFrame=handles.preview;
guidata(hObject,handles)


% --- Executes on button press in Endbutton.
function Endbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Endbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.EndFrame=handles.preview;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function loadbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loadbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function loadother_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loadother (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function Startbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Startbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function Endbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Endbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function track_CreateFcn(hObject, eventdata, handles)
% hObject    handle to track (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function mshift_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mshift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function feat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to feat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function avi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to avi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function gif_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gif (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function back_CreateFcn(hObject, eventdata, handles)
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function close_CreateFcn(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function play2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to play2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function play1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to play1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object deletion, before destroying properties.
function Startbutton_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to Startbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


