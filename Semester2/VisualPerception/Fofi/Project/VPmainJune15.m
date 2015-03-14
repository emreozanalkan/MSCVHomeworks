%%%%% VP project %%%%%
% to plot a plane in matlab 
close all;
clear all;
clc;

tic;
figure(1);
grid on;
colorCount = 0;
color = 'red';
normalsMatrix = [];


for ii = -10 : 10
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

% [x, y, z] = ellipsoid(0, 10, 0, 5.9, 3.25, 3.25, 30);
    
c = hadamard(2^k);

% increasing the size of the object
radius = 4;
x = radius * x;
y = radius * y;
z = radius * z;

% figure
surf(x ,y ,z ,c );
%surf(x, y, z);
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

for ii = 1:size(normalsMatrix,1)
    for jj = 1:size(object_pnts,1)
         dotsperplane(jj,ii) = normalsMatrix(ii,1)*object_pnts(jj,1) + normalsMatrix(ii,2)*object_pnts(jj,2) + normalsMatrix(ii,3)*object_pnts(jj,3) + normalsMatrix(ii,4)*object_pnts(jj,4);       
    end
end

dotsperplane = abs(dotsperplane);      % taking absolute of resulted product
[r c]=find(dotsperplane<1);            % taking points less than 1
plotpoints = object_pnts(r,:);
plotpoints = plotpoints(:,1:3);
% hold off;
% figure(2);

% ploting the points of intersection on the main image
plot3(plotpoints(:,1),plotpoints(:,2),plotpoints(:,3),'b*');
xlabel('X');
ylabel('Y');
zlabel('Z');
hold off;

% ploting the points of intersection
figure(2);
plot3(plotpoints(:,1),plotpoints(:,2),plotpoints(:,3),'b*');
title('intersections');
toc;














