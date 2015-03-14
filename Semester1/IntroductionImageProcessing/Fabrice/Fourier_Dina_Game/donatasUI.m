function varargout = donatasUI(varargin)
% DONATASUI MATLAB code for donatasUI.fig
%      DONATASUI, by itself, creates a new DONATASUI or raises the existing
%      singleton*.
%
%      H = DONATASUI returns the handle to a new DONATASUI or the handle to
%      the existing singleton*.
%
%      DONATASUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DONATASUI.M with the given input arguments.
%
%      DONATASUI('Property','Value',...) creates a new DONATASUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before donatasUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to donatasUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help donatasUI

% Last Modified by GUIDE v2.5 21-Nov-2013 20:55:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @donatasUI_OpeningFcn, ...
                   'gui_OutputFcn',  @donatasUI_OutputFcn, ...
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


% --- Executes just before donatasUI is made visible.
function donatasUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to donatasUI (see VARARGIN)

% Choose default command line output for donatasUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);






% UIWAIT makes donatasUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = donatasUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnAnswer.
function btnAnswer_Callback(hObject, eventdata, handles)
% hObject    handle to btnAnswer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = (1:1:100);
y = 2*x;
z = sin(x);
plot(handles.axeGuess1, x, y);

plot(handles.axeGuess2, x, z);







% --- Executes on button press in btnNewGame.
function btnNewGame_Callback(hObject, eventdata, handles)
% hObject    handle to btnNewGame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axeGuess1);
