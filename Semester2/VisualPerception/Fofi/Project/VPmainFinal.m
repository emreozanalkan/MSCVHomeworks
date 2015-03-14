%%%%% VP project %%%%%
%%% To plot a plane in matlab 
clear all;
clc;


tic;
figure(1);
title('Projector projecting on 3D Oject')
grid on;
colorCount = 0;
color = 'red';
normalsMatrix = [];

savePat = [];
for ii = -5 : 5 
    pointA = [0,-20,0];                                           % 3 points to create a plane 
    pointB = [ii, 20, 20];
    pointC = [ii, 20, -20];
    
    [normal1, d, X, Y, Z] = create_plane(pointA, pointB, pointC); % function to create plane
    normalsMatrix = [normalsMatrix; [normal1 d]];                 % storing all the normals [a b c d] in matrix
    
    reOrder = [1 2  4 3];
    savePat = [savePat; [ii,20,-20]];
    
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
figure(2);
plot3(plotpoints(:,1),plotpoints(:,2),plotpoints(:,3),'b*');
title('Intersections(3D Points of the Object)');
xlabel('X');
ylabel('Y');
zlabel('Z');
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
T = viewmtx(90,0,25);                   % setting the position on the camera

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
figure(6); 
title('Projected Pattern');hold on

for i = 1:size(savePat,1)
plot([savePat(i,1),savePat(i,1)],[savePat(i,2),savePat(i,3)]);
end
hold off

% Ploting the 2d points
figure(3);
plot(viewpoints(1,:),viewpoints(2,:),'r*');
title('2D Image');
%%%



%%% Reconstruction 
depth = (viewpoints(1,:)' + 5.*intersections(:,1) - intersections(:,3)); % Get the lost depth
%reconstract object with depth and pattern
recon = [depth,intersections(:,1),intersections(:,3)];                   % reconstruct the 3D points

% Plot 3D object
figure(7);
plot3(recon(:,1),recon(:,2),recon(:,3),'g.');           
title('3D reconstruction (Rotate to get 360 view)');
%%%
toc;
















