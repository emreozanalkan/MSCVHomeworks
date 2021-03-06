%%%%% VP project %%%%%
% to plot a plane in matlab
clear all;
clc;
% % defining the 3 points 
% pointA = [0,0,0];
% pointB = [-10,-20,10];
% pointC = [10,20,10];
% pointD = [-30,-40,-30];
% pointE = [30,40,50];
% 
% plane1 = cross(pointA-pointB, pointA-pointC); % calculating the plane normal
% plane2 = cross(pointA-pointD, pointA-pointE);
% 
% points=[pointA' pointB' pointC']; % using the data given in the question
% points2=[pointA' pointD' pointE'];
% figure,hold on;
% fill3(points(1,:),points(2,:),points(3,:),'b')
% fill3(points2(1,:),points2(2,:),points2(3,:),'r')
% grid on
%  alpha(0.3);

pattern = [-1,14,14,-1,14,-14;
            0,14,14,0,14,-14;
            1,14,14,1,14,-14];
        
        
%%
figure('units', 'normalized', 'outerposition', [0 0 1 1]);
grid on;
colorCount = 0;
color = 'red';

normalsAndDMatrix = [];

for ii = -10 : 10
    
    pointA = [1, 1, 1];
    
    pointB = [ii, 14, 14];
    
    pointC = [ii, 14, -14];
    
    [normal1, d, X, Y, Z] = create_plane(pointA, pointB, pointC);
    
    normalsAndDMatrix = [normalsAndDMatrix; [normal1 d]];
    
    reOrder = [1 2  4 3];
    
    colorCount = colorCount + 1;
    
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

view([0 80]);  

[X, Y, Z] = sphere(20);

radius = 4;

X = radius * X;
Y = radius * Y;
Z = radius * Z;

surf(X, Y + 10, Z, ones(size(Z)));

%%
        
% defining the 3 points 
pointA = [0,0,0]; % sourse
pointB = [-1,14,14];
pointC = [-1,14,-14];
[normal1,d,X,Y,Z ] = create_plane( pointA,pointB,pointC );
reOrder = [1 2  4 3];
figure(1);patch(X(reOrder),Y(reOrder),Z(reOrder),'b'); hold on 
grid on;

% for second plane 
pointA = [0,0,0];
pointB = [1,14,14];
pointC = [1,14,-14];
[normal2,d1,X1,Y1,Z1 ] = create_plane( pointA,pointB,pointC);
reOrder = [1 2  4 3]; 
patch(X1(reOrder),Y1(reOrder),Z1(reOrder),'r');hold on
grid on;

%  calculating the angle between two plane
 A1 = normal1(1); B1 = normal1(2); C1 = normal1(3);
 A2 = normal2(1); B2 = normal2(2);C2 = normal2(3);
 A_nor = (A1*A2)+(B1*B2)+(C1*C2);
 
 n1 = sqrt( A1+B1+C1 );
 n2 = sqrt( A2+B2+C2 );
 cos_theta =  ((A_nor)/(n1*n2));
 cos_degree =  acosd(cos_theta)
 
% for third plane 
pointA = [0,0,0];
pointB = [2,14,14];
pointC = [2,14,-14];
[normal3,d,X2,Y2,Z2 ] = create_plane( pointA,pointB,pointC);
reOrder = [1 2  4 3]; 
patch(X2(reOrder),Y2(reOrder),Z2(reOrder),'g');hold on; 
grid on;

% for Fourth plane 
pointA = [0,0,0];
pointB = [3,14,14];
pointC = [3,14,-14];
[normal4,d,X3,Y3,Z3 ] = create_plane( pointA,pointB,pointC);
reOrder = [1 2  4 3]; 
patch(X3(reOrder),Y3(reOrder),Z3(reOrder),'b'); hold on; 
grid on;

%  calculating the angle between two plane
 A3 = normal3(1); B3 = normal3(2); C3 = normal3(3);
 A4 = normal4(1); B4 = normal4(2); C4 = normal4(3);
 A_nor1 = (A3*A4)+(B3*B4)+(C3*C4);
 
 n3 = sqrt( A1+B1+C1 );
 n4 = sqrt( A2+B2+C2 );
 cos_theta2 =  ((A_nor1)/(n3*n4));
 cos_degree2 =  acosd(cos_theta2)

% for fifth plane 
pointA = [0,0,0];
pointB = [4,14,14];
pointC = [4,14,-14];
[normal5,d,X4,Y4,Z4 ] = create_plane( pointA,pointB,pointC);
reOrder = [1 2  4 3]; 
patch(X4(reOrder),Y4(reOrder),Z4(reOrder),'r');hold on;
grid on;

% for sixth plane 
pointA = [0,0,0];
pointB = [-2,14,14];
pointC = [-2,14,-14];
[normal6,d,X5,Y5,Z5 ] = create_plane( pointA,pointB,pointC);
reOrder = [1 2  4 3]; 
patch(X5(reOrder),Y5(reOrder),Z5(reOrder),'g'); hold on;
grid on;

% for seventh plane 
pointA = [0,0,0];
pointB = [-3,14,14];
pointC = [-3,14,-14];
[normal7,d,X6,Y6,Z6 ] = create_plane( pointA,pointB,pointC);
reOrder = [1 2  4 3]; 
patch(X6(reOrder),Y6(reOrder),Z6(reOrder),'g'); hold on;
grid on;

% for eight plane 
pointA = [0,0,0];
pointB = [-4,14,14];
pointC = [-4,14,-14];
[normal8,d,X7,Y7,Z7 ] = create_plane( pointA,pointB,pointC);
reOrder = [1 2  4 3]; 
patch(X7(reOrder),Y7(reOrder),Z7(reOrder),'b'); hold on;
grid on;

% for nine plane 
pointA = [0,0,0];
pointB = [-5,14,14];
pointC = [-5,14,-14];
[normal9,d,X8,Y8,Z8 ] = create_plane( pointA,pointB,pointC);
reOrder = [1 2  4 3]; 
patch(X8(reOrder),Y8(reOrder),Z8(reOrder),'r'); hold on;
grid on;

% for ten plane 
pointA = [0,0,0];
pointB = [5,14,14];
pointC = [5,14,-14];
[normal10,d,X9,Y9,Z9 ] = create_plane( pointA,pointB,pointC);
reOrder = [1 2  4 3]; 
patch(X9(reOrder),Y9(reOrder),Z9(reOrder),'g'); hold on;
grid on;


% pointA = [0,0,0]; % sourse
% pointB = [-1,14,14];
% pointC = [-1,14,-14];
% defining the 11 points 
pointA = [0, 0, 0];
pointB = [0, 14, -14];
pointC = [0, 14, 14];
[normal1,d,X10,Y10,Z10 ] = create_plane( pointA,pointB,pointC );
reOrder = [1 2  4 3];
figure(1);patch(X10(reOrder),Y10(reOrder),Z10(reOrder),'g'); hold on 
grid on;


% % normal = cross(pointA-pointB, pointA-pointC); %# Calculate plane normal
% % %# Transform points to x,y,z
% % x = [pointA(1) pointB(1) pointC(1)];  
% % y = [pointA(2) pointB(2) pointC(2)];
% % z = [pointA(3) pointB(3) pointC(3)];

% % %Find all coefficients of plane equation    
% % A = normal(1); B = normal(2); C = normal(3);
% % D = -dot(normal,pointA);
% % % Decide on a suitable showing range
% % xLim = [min(x) max(x)];
% % zLim = [min(z) max(z)];
% % [X,Z] = meshgrid(xLim,zLim);
% % Y = (A * X + C * Z + D)/ (-B);
% % reOrder = [1 2  4 3];
% % figure();patch(X(reOrder),Y(reOrder),Z(reOrder),'b');
% % grid on;

% function [normal, d] = plot_line(p1, p2, p3)
% 
% This function plots a line from three points. 
% I/P arguments: 
%   p1, p2, p3 eg, p1 = [x y z]
% 
% 
% O/P is: 
% normal: it contains a,b,c coeff , normal = [a b c]
% d : coeff

% p1 = [0 0 0];
% p2 = [1 2 4];
% p3 = [2 3 -4];
% 
% normal = cross(p1 - p2, p1 - p3);
% d = p1(1)*normal(1) + p1(2)*normal(2) + p1(3)*normal(3);
% d = -d;
% x = -100:100; y = -100:100;
% [X,Y] = meshgrid(x,y);
% Z = (-d - (normal(1)*X) - (normal(2)*Y))/normal(3);
% mesh(X,Y,Z)
% alpha(0.3);
% 
% 
% % [normal, d] = plot_line(P1, P2, P3);
