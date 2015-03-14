clc
clear all
[x, y] = meshgrid(-2:0.01:2, -2:0.01:2);
myfunction = @(x,y)(-exp(-x.^2-y.^2) + exp(-(x+1).^2-(y+1).^2));
z = -exp(-x.^2-y.^2) + exp(-(x+1).^2-(y+1).^2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%powell's method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
subplot(1,2,1);
mesh(x,y,z);
% [px,py] = gradient(z,0.01,0.01);
subplot(1,2,2);
hold on;
contour(x, y, z);

x0 = [0,-1];
error = 0.0001;
e1 = [1,0];
e2 = [0,1];
N = 20;     %iteration times
counter = 1;
while((e1 ~= e2) & (counter < 20))
    [x0,e1,e2] = PowellSingleStep(myfunction,error,x0,e1,e2);
    counter = counter + 1;
end


