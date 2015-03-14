function [normal, d, X, Y, Z] = create_plane(pointA, pointB, pointC)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%  Equation of the plane 
%  AX + BY + CZ = d

%  Normal is defined as
%  [A , B , C]

%calculating the normal
normal = cross(pointA - pointB, pointA - pointC); %# Calculate plane normal

%# Transform points to x,y,z
x = [pointA(1) pointB(1) pointC(1)];
y = [pointA(2) pointB(2) pointC(2)];
z = [pointA(3) pointB(3) pointC(3)];

%Find all coefficients of plane equation    
A = normal(1); 
B = normal(2);
C = normal(3);
D = -dot(normal, pointA);

% Equation of the plane 
xLim = [min(x) max(x)];
zLim = [min(z) max(z)];
% xLim = -100:100;zLim = -100:100;
[X, Z] = meshgrid(xLim, zLim);

% Equation of the plane
Y = (A * X + C * Z + D) / (-B);

d = D;

end
