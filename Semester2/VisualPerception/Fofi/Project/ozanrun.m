close all;
clear all;
clc;

figure('units', 'normalized', 'outerposition', [0 0 1 1]);

grid on;

colorCount = 0;

color = 'red';

normalsAndDMatrix = [];

figure(1);

for ii = -10 : 10
    
    pointA = [0, -20, 0];
    
    pointB = [ii, 20, 20];
    
    pointC = [ii, 20, -20];
    
    [normal1, d, X, Y, Z] = create_plane(pointA, pointB, pointC);
    
    normalsAndDMatrix = [normalsAndDMatrix; [normal1 d]];
    
    reOrder = [1 2 4 3];
    
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

 k = 10;
n = 2^k-1;

[X, Y, Z] = sphere(n);

c = hadamard(2^k);

radius = 4;

X = radius * X;
Y = radius * Y; 
Z = radius * Z;

surf(X, Y, Z, ones(size(Z)));

X = reshape(X, [], 1);
Y = reshape(Y, [], 1);
Z = reshape(Z, [], 1);

totalmat = [X, Y, Z];

totalmat(:, 4) = 1;

for i = 1 : size(normalsAndDMatrix,1) % number of planes             %size(normalsAndDMatrix,1)
    
    for j = 1 : size(totalmat, 1)
        
        %dotperplane(i, j) = dot(totalmat(j, :), normalsAndDMatrix(i,  :));
        dotsperplane(j,i) = normalsAndDMatrix(i, 1) * totalmat(j, 1) + normalsAndDMatrix(i, 2) * totalmat(j, 2) + normalsAndDMatrix(i, 3) * totalmat(j, 3) + normalsAndDMatrix(i, 4) * totalmat(j, 4);
        
    end
    
end

dotsperplane = abs(dotsperplane);

[r, c] = find(dotsperplane < 1);

plotpoints = totalmat(c, :);

plotpoints = plotpoints(:, 1 : 3);

hold off;
figure(2);

plot3(plotpoints(:, 1), plotpoints(:, 2), plotpoints(:, 3), 'r*');
