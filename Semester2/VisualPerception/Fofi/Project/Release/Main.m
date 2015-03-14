function varargout = Main(varargin)
% MAIN MATLAB code for Main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main

% Last Modified by GUIDE v2.5 15-Jun-2014 14:52:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_OutputFcn, ...
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


% --- Executes just before Main is made visible.
function Main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main (see VARARGIN)

% Choose default command line output for Main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function txtPatternPlaneCount_Callback(hObject, eventdata, handles)
% hObject    handle to txtPatternPlaneCount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtPatternPlaneCount as text
%        str2double(get(hObject,'String')) returns contents of txtPatternPlaneCount as a double


% --- Executes during object creation, after setting all properties.
function txtPatternPlaneCount_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtPatternPlaneCount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtCameraAzimuth_Callback(hObject, eventdata, handles)
% hObject    handle to txtCameraAzimuth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtCameraAzimuth as text
%        str2double(get(hObject,'String')) returns contents of txtCameraAzimuth as a double


% --- Executes during object creation, after setting all properties.
function txtCameraAzimuth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtCameraAzimuth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtCameraElevation_Callback(hObject, eventdata, handles)
% hObject    handle to txtCameraElevation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtCameraElevation as text
%        str2double(get(hObject,'String')) returns contents of txtCameraElevation as a double


% --- Executes during object creation, after setting all properties.
function txtCameraElevation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtCameraElevation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnSimulate.
function btnSimulate_Callback(hObject, eventdata, handles)
% hObject    handle to btnSimulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.axes1);
cla(handles.axes2);
cla(handles.axes3);
cla(handles.axes4);
cla(handles.axes5);

patternPlaneCountString = get(handles.txtPatternPlaneCount, 'String');
patternPlaneCount = str2double(patternPlaneCountString);
patternPlaneCountHalf = ceil(patternPlaneCount / 2);

cameraAzimuthString  = get(handles.txtCameraAzimuth, 'String');
cameraCameraAzimuth = str2double(cameraAzimuthString);

cameraElevationString  = get(handles.txtCameraElevation, 'String');
cameraElevation = str2double(cameraElevationString);

axes(handles.axes1);

title('Projector projecting on 3D Oject');
grid on;
colorCount = 0;
color = 'red';
normalsMatrix = [];

savePat = [];

for ii = -patternPlaneCountHalf : patternPlaneCountHalf
    pointA = [0,-20,0];                                           % 3 points to create a plane 
    pointB = [ii, 20, 20];
    pointC = [ii, 20, -20];
    
    [normal1, d, X, Y, Z] = create_plane(pointA, pointB, pointC); % function to create plane
    normalsMatrix = [normalsMatrix; [normal1 d]];                 % storing all the normals [a b c d] in matrix
    
    reOrder = [1 2  4 3];
    savePat = [savePat; [ii, 20, -20]];
    
    %%%Aplying different color to the plan
    color = 'red';
    colorCount = colorCount + 1;                                  % applying color to the plane
    if colorCount == 1
        color = 'red';
    elseif colorCount == 2
        color = 'green';
    elseif colorCount == 3
        color = 'blue';
    elseif colorCount == 4
        color = 'cyan';
    elseif colorCount == 5
        color = 'magenta';
    else
        color = 'yellow';
        colorCount = 0;
    end 
    patch(X(reOrder), Y(reOrder), Z(reOrder), color); 
    hold on;
end

rotate3d(gca);

%%% Taking 3D object in the Environment
view([0 80]);
 k = 10;
n = 2^k-1;
[x,y,z] = sphere(n);                    % You can change your  3D object
c = hadamard(2^k);

% Increasing the size of the object
radius = 4;
x = radius * x;
y = radius * y;
z = radius * z;

% Ploting the 3D object 
surf(x ,y ,z ,c );
colormap([1  1  0; 0  1  1]);

%%% Fing the intersection points  
x = reshape(x,[],1);                 % taking all the x coorinates of 3d object in a coloum
y = reshape(y,[],1);
z = reshape(z,[],1);
object_pnts = [x y z];               % making a mitrix of [x y z]
object_pnts(:,4)=1;                  % adding the 4th colom as 1 [x y z 1]

% Taking hte dot product of the normals of plane and 3d points of object
% [a b c d]*[x y z 1]
for i = 1:size(normalsMatrix,1)
    for j = 1:size(object_pnts,1)
         dotsperplane(j,i) = normalsMatrix(i,1)*object_pnts(j,1) + normalsMatrix(i,2)*object_pnts(j,2) + normalsMatrix(i,3)*object_pnts(j,3) + normalsMatrix(i,4)*object_pnts(j,4);       
    end
end

dotsperplane = abs(dotsperplane);      % taking absolute of resulted product
[r c]=find(dotsperplane<1);            % taking points less than 1, dot product should be closer to zero
intersections = object_pnts(r,:);      % Search for the 3D points intersecting with plane
plotpoints = intersections(:,1:3);     % Take X,Y,Z to plot

%%% Ploting the points of intersection on the main image
plot3(plotpoints(:,1),plotpoints(:,2),plotpoints(:,3),'b*');
xlabel('X');
ylabel('Y');
zlabel('Z');
%%%

%%% Ploting the points of intersection
axes(handles.axes2);
plot3(plotpoints(:,1),plotpoints(:,2),plotpoints(:,3),'b*');
title('Intersections(3D Points of the Object)');
xlabel('X');
ylabel('Y');
zlabel('Z');
rotate3d(gca);
%%%


%%% 3D to 2D conversion
image2D = zeros(128,128);               % creating a 2d matrix, image2D is not used
K = [700  0  (size(image2D,2))/2;       % defining the intrensic parameters
    0    750 (size(image2D,1))/2;
    0     0          1         ];

%%% viewmtx(az,el,type) 
%az: rotation around the object
%el: elevate the camera UP or Down
%type: 0= Orthographic, 25= Projective
T = viewmtx(cameraCameraAzimuth, cameraElevation, 25);                   % setting the position on the camera

% T1 is the camera projection matrix 3X4 (extrinsic parameters)
xx = 0; yy = 0; zz = 0;                 % Add translation to the last column of T1, but not necessary
T1 = [T(1:2,:);T(4,:)];
T1(1,end) = T1(1,end)+xx;
T1(2,end) = T1(2,end)+yy;
T1(3,end) = T1(3,end)+zz;

% Getting the 2D point (Creating the 2D image points)
% [u v 1] = [K  * [R|T]]
for i = 1:size(intersections,1)
viewpoints(:,i) = K * (T1 * intersections(i,:)'); 
end

%%% Getiing the patern projected on the 3D object
% A = 3*4 matrix  containing combined intrinsic and extrinsic parameters
% Plotting the Pattern
axes(handles.axes3);
title('Projected Pattern');hold on

for i = 1:size(savePat,1)
plot([savePat(i,1),savePat(i,1)],[savePat(i,2),savePat(i,3)]);
end
hold off
rotate3d(gca);


% Ploting the 2d points
axes(handles.axes4);
plot(viewpoints(1,:),viewpoints(2,:),'r*');
title('2D Image');
rotate3d(gca);
%%%

%%% Reconstruction 
depth = (viewpoints(1,:)' + 5.*intersections(:,1) - intersections(:,3)); % Get the lost depth
%reconstract object with depth and pattern
recon = [depth,intersections(:,1),intersections(:,3)];                   % reconstruct the 3D points

% Plot 3D object
axes(handles.axes5);
plot3(recon(:,1),recon(:,2),recon(:,3),'g.');           
title('3D reconstruction (Rotate to get 360 view)');
rotate3d(gca);
%%%
