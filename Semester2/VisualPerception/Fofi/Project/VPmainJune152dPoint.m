%%%%% VP project %%%%%
% to plot a plane in matlab 
clear all;
clc;

tic;
figure(1);
grid on;
colorCount = 0;
color = 'red';
normalsMatrix = [];


for ii = 1 : 2 
    pointA = [0,-20,0];                                           % 3 points to create a plane 
    pointB = [ii, 20, 20];
    pointC = [ii, 20, -20];
    [normal1, d, X, Y, Z] = create_plane(pointA, pointB, pointC); % function to create plane
    normalsMatrix = [normalsMatrix; [normal1 d]];                 % storing all the normals [a b c d] in matrix
    reOrder = [1 2  4 3];
    
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

% taking 3D object in the environment
view([0 80]);
 k = 10;
n = 2^k-1;
%  n = 1000;
[x,y,z] = sphere(n);
c = hadamard(2^k);

% increasing the size of the object
radius = 4;
x = radius * x;
y = radius * y;
z = radius * z;

% figure
surf(x ,y ,z ,c );
% surf(x ,y ,z );
colormap([1  1  0; 0  1  1]);
% axis equal

% fing the intreat points
x = reshape(x,[],1);        % taking all the x coorinates of 3d object in a coloum
y = reshape(y,[],1);
z = reshape(z,[],1);
object_pnts = [x y z];      % making a mitrix of [x y z]
object_pnts(:,4)=1;         % adding the 4th colom as 1 [x y z 1]


% taking hte dot product of the normals of plane and 3d points of object
% [a b c d]*[x y z 1]

for i = 1:size(normalsMatrix,1)
    for j = 1:size(object_pnts,1)
         dotsperplane(j,i) = normalsMatrix(i,1)*object_pnts(j,1) + normalsMatrix(i,2)*object_pnts(j,2) + normalsMatrix(i,3)*object_pnts(j,3) + normalsMatrix(i,4)*object_pnts(j,4);       
    end
end

dotsperplane = abs(dotsperplane);      % taking absolute of resulted product
[r c]=find(dotsperplane<1);            % taking points less than 1
intersections = object_pnts(r,:);
plotpoints = intersections(:,1:3);
% hold off;
% figure(2);

% ploting the points of intersection on the main image
plot3(plotpoints(:,1),plotpoints(:,2),plotpoints(:,3),'b*');
xlabel('X');
ylabel('Y');
zlabel('Z');

% ploting the points of intersection
figure(2); hold on;
plot3(plotpoints(:,1),plotpoints(:,2),plotpoints(:,3),'b*');
title('intersections');
xlabel('X');
ylabel('Y');
zlabel('Z');

%%% 3D to 2D conversion

image2D = zeros(128,128);               % creating a 2d matrix
K = [700  0  (size(image2D,2))/2;       % defining the intrensic parameters
    0    750 (size(image2D,1))/2;
    0     0          1         ];

 xx = 0; yy = 0; zz = 0;
% t = [eye(3),[ xx; yy; zz]];
T = viewmtx(0, -20, 25);                  % setting the position on the camera
T1 = [T(1:2,:);T(4,:)];
T1(1,end) = T1(1,end)+xx;
T1(2,end) = T1(2,end)+yy;
T1(3,end) = T1(3,end)+zz;
% M = makehgtform('translate',[xx yy zz]);
% M1 = M(1:3,:);

% getting the 2D point 
% [u v 1] = [K  * [R|T]]
for i = 1:size(intersections,1)
viewpoints(:,i) = K * (T1 * intersections(i,:)');
end

% ploting the 2d points
figure(3);
plot(viewpoints(1,:),viewpoints(2,:),'r*');
title('2D Image');

% ploting the position of the camera on the image 
figure(2);
plot3(xx,yy,zz,'r*');
hold off;

% figure(1);
% plot3(xx, yy, zz, 'r*');
% hold off;


% px = axes2pix(128,viewpoints(1,:),130);
% py = axes2pix(128,viewpoints(2,:),130);

toc;
