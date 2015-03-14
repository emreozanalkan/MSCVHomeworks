function varargout = testFigure1(varargin)
% TESTFIGURE1 MATLAB code for testFigure1.fig
%      TESTFIGURE1, by itself, creates a new TESTFIGURE1 or raises the existing
%      singleton*.
%
%      H = TESTFIGURE1 returns the handle to a new TESTFIGURE1 or the handle to
%      the existing singleton*.
%
%      TESTFIGURE1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTFIGURE1.M with the given input arguments.
%
%      TESTFIGURE1('Property','Value',...) creates a new TESTFIGURE1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before testFigure1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to testFigure1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help testFigure1

% Last Modified by GUIDE v2.5 01-Dec-2013 11:32:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testFigure1_OpeningFcn, ...
                   'gui_OutputFcn',  @testFigure1_OutputFcn, ...
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


% --- Executes just before testFigure1 is made visible.
function testFigure1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to testFigure1 (see VARARGIN)

% Choose default command line output for testFigure1
handles.output = hObject;

%handles.myImage = imread('cameraman.tif');
handles.answer = 0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes testFigure1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = testFigure1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array - returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on mouse press over axes background.
function axes3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%disp('First figure pressed :)');
set(handles.radiobutton4,'Value', 1);


% --- Executes on mouse press over axes background.
function axes4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%disp('Second figure pressed :)');
set(handles.radiobutton5,'Value', 1);
rbValue = get(handles.radiobutton5, 'Value');


% --- Executes on mouse press over axes background.
function axes5_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%disp('Third figure pressed :)');
set(handles.radiobutton6,'Value', 1);


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(handles.answer == 1)
    if (get(handles.radiobutton4,'Value') == 1)
        msgbox('Correct!!!');
    else
        msgbox(':(!');
    end
elseif(handles.answer == 2)
    if (get(handles.radiobutton5,'Value') == 1)
        msgbox('Correct!!!');
    else
        msgbox(':(!');
    end
elseif(handles.answer == 3)
    if (get(handles.radiobutton6,'Value') == 1)
        msgbox('Correct!!!');
    else
        msgbox(':(!');
    end
else
    msgbox('Error :( !!!');
end
    



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%axes(handles.axes1);
%imshow(imread('cameraman.tif'));
%imshow(handles.myImage);

files = dir(fullfile('*.png'));
fileNames = {files.name};

fileSize = length(fileNames);

selectedImageIndex = randi(fileSize);

fourrierImageName = fileNames(selectedImageIndex);
fourrierImage = imread(fourrierImageName{1});


secondRandomImageIndex = randi(fileSize);
secondImageName = fileNames(secondRandomImageIndex);
secondImage = imread(secondImageName{1});

thirdRandomImageIndex = randi(fileSize);
thirdImageName = fileNames(thirdRandomImageIndex);
thirdImage = imread(thirdImageName{1});


axes(handles.axes1);
imshow(fourrierImage);


fourrierImageGray = rgb2gray(fourrierImage);
fourrierImageGrayFFT2D = fft2(fourrierImageGray);
fourrierImageGrayFFT2DShifted = fftshift(fourrierImageGrayFFT2D);
fourrierImageGrayFFT2DShifted = abs(fourrierImageGrayFFT2DShifted);
fourrierImageGrayFFT2DShifted = log(fourrierImageGrayFFT2DShifted);

secondImageGray = rgb2gray(secondImage);
secondImageGrayFFT2D = fft2(secondImageGray);
secondImageGrayFFT2DShifted = fftshift(secondImageGrayFFT2D);
secondImageGrayFFT2DShifted = abs(secondImageGrayFFT2DShifted);
secondImageGrayFFT2DShifted = log(secondImageGrayFFT2DShifted);

thirdImageGray = rgb2gray(thirdImage);
thirdImageGrayFFT2D = fft2(thirdImageGray);
thirdImageGrayFFT2DShifted = fftshift(thirdImageGrayFFT2D);
thirdImageGrayFFT2DShifted = abs(thirdImageGrayFFT2DShifted);
thirdImageGrayFFT2DShifted = log(thirdImageGrayFFT2DShifted);




answer = randi(3);

if(answer == 1)
    axes(handles.axes3);
    imshow(fourrierImageGrayFFT2DShifted, []);
    axes(handles.axes4);
    imshow(secondImageGrayFFT2DShifted, []);
    axes(handles.axes5);
    imshow(thirdImageGrayFFT2DShifted, []);
elseif(answer == 2)
    axes(handles.axes4);
    imshow(fourrierImageGrayFFT2DShifted, []);
    axes(handles.axes3);
    imshow(secondImageGrayFFT2DShifted, []);
    axes(handles.axes5);
    imshow(thirdImageGrayFFT2DShifted, []);
else
    axes(handles.axes5);
    imshow(fourrierImageGrayFFT2DShifted, []);
    axes(handles.axes3);
    imshow(secondImageGrayFFT2DShifted, []);
    axes(handles.axes4);
    imshow(thirdImageGrayFFT2DShifted, []);
end

handles.answer = answer;
guidata(hObject, handles);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton2.
function pushbutton2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton3.
function pushbutton3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
