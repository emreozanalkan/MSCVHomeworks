function varargout = GUI_2(varargin)
% GUI_2 M-file for GUI_2.fig
%      GUI_2, by itself, creates a new GUI_2 or raises the existing
%      singleton*.
%
%      H = GUI_2 returns the handle to a new GUI_2 or the handle to
%      the existing singleton*.
%
%      GUI_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_2.M with the given input arguments.
%
%      GUI_2('Property','Value',...) creates a new GUI_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_2

% Last Modified by GUIDE v2.5 08-Jul-2012 12:13:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_2_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_2_OutputFcn, ...
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


% --- Executes just before GUI_2 is made visible.
function GUI_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_2 (see VARARGIN)

% Choose default command line output for GUI_2
handles.output = hObject;

handles.GUI_3_handle = [];
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function txt_input1_Callback(hObject, eventdata, handles)
% hObject    handle to txt_input1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_input1 as text
%        str2double(get(hObject,'String')) returns contents of txt_input1 as a double
% obtain data stored in GUI_3 
GUI_3_data = guidata(handles.GUI_3_handle); 
% compute result based on input 1 on GUI_2 and update result 1 on GUI_3
input1 = str2double( get(handles.txt_input1, 'string'));
set(GUI_3_data.lbl_res1, 'string', num2str( input1 * rand)); 

% --- Executes during object creation, after setting all properties.
function txt_input1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_input1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txt_input2_Callback(hObject, eventdata, handles)
% hObject    handle to txt_input2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_input2 as text
%        str2double(get(hObject,'String')) returns contents of txt_input2 as a double
% obtain data stored in GUI_3 
GUI_3_data = guidata(handles.GUI_3_handle); 
% compute result based on input 2 on GUI_2 and update result 2 on GUI_3
input2 = str2double( get(handles.txt_input2, 'string'));
set(GUI_3_data.lbl_res2, 'string', num2str( input2 * rand));

% --- Executes during object creation, after setting all properties.
function txt_input2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_input2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty(handles.GUI_3_handle)
   % create GUI-3 
   handles.GUI_3_handle = GUI_3; 
   % obtain data in GUI-3
   GUI_3_data = guidata(handles.GUI_3_handle); 
   % store handle to GUI-2 as data in GUI-3
   GUI_3_data.GUI_2_handle = get(hObject,'parent');
   % save the GUI-3 data 
   guidata(handles.GUI_3_handle, GUI_3_data);
   % save the handles structure as data of GUI-2
   guidata(get(hObject,'parent'), handles);
end


% GUI-3 must exist at this point. 

% obtain data stored in GUI_3 
GUI_3_data = guidata(handles.GUI_3_handle); 
% compute result based on input 1 on GUI_2 and update result 1 on GUI_3
input1 = str2double( get(handles.txt_input1, 'string'));
set(GUI_3_data.lbl_res1, 'string', num2str( input1 * rand));

% compute result based on input 2 on GUI_2 and update result 2 on GUI_3
input2 = str2double( get(handles.txt_input2, 'string'));
set(GUI_3_data.lbl_res2, 'string', num2str( input2 * rand));



% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
warndlg('Please click Close Application button on GUI-3','!! Warning !!')
% delete(hObject);
