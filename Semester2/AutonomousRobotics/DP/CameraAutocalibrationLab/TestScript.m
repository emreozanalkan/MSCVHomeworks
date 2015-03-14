%% The mendonca-Cipolla autocalibration method described in Lecure 05
% Use A as initial estimate and assume all pairs of images weigt the same
% on the process
% https://sites.google.com/site/vibot3d
% 
% close all;
% clear all;
% clc;

load('data.mat');


X = zeros(5, 1);

X(1) = A(1, 1);
X(2) = A(2, 2);
X(3) = A(1, 2);
X(4) = A(1, 3);
X(5) = A(2, 3);


%C = mendoncaCipollaCost(X, Fs);


costFunc =  @(X) mendoncaCipollaCost(X, Fs);


[xHat, resnorm] = lsqnonlin(costFunc, X);


% xHat(1) = alfa_u
% xHat(2) = alfa_v
% xHat(3) = gamma
% xHat(4) = u_0
% xHat(5) = v_0
A2 = [xHat(1)   xHat(3)   xHat(4);
     0         xHat(2)   xHat(5);
     0         0         1];
 
 
%% The classical and simplified Kruppa's equaitons Lecture 03
%% Use A as initial estimate


% close all;
% clear all;
% clc;

load('data.mat');


X = zeros(5, 1);


X(1) = A(1, 1);
X(2) = A(2, 2);
X(3) = A(1, 2);
X(4) = A(1, 3);
X(5) = A(2, 3);


costFunc =  @(Y) kruppaCost(Y, Fs);

%options = optimset('TolX',10^-40);
options = optimset('Algorithm','levenberg-marquardt','MaxFunEvals',10^50,'TolFun',10^-100,'TolX',10^-100);
%options = optimset('Algorithm','levenberg-marquardt','MaxFunEvals',10^50,'TolFun',10^-100,'TolX',10^-100, 'MaxIter', 10^5);
[xHat, resnorm] = lsqnonlin(costFunc, X, [], [], options);
%[xHat, resnorm] = lsqnonlin(costFunc, X);


A3 = [xHat(1)   xHat(3)   xHat(4);
     0         xHat(2)   xHat(5);
     0         0         1];


%% 3
close all;
clear all;
clc;

load('data.mat');

% A = [800 0 256; 0 800 256; 0 0 1]; % Correct one

w = A * A';
nx = sym('nx', 'real');
ny = sym('ny', 'real');
nz = sym('nz', 'real');
l2 = sym('l2', 'real');

n = [nx; ny; nz]; % Normal of pi inf

Q = [w, (w * n); (n' * w), (n' * w * n)]; % Dual Absolute Quadric

M2 = PPM(:, :, 2);

m2 = M2 * Q * M2';

sol = solve(m2(1, 1) == (l2 * w(1, 1)), ...
            m2(2, 2) == (l2 * w(2, 2)), ...
            m2(3, 3) == (l2 * w(3, 3)), ...
            m2(1, 3) == (l2 * w(1, 3)));

display('sol.nx:');
display(double(sol.nx));
display('sol.ny:');
display(double(sol.ny));
display('sol.nz:');
display(double(sol.nz));
display('sol.l2:');
display(double(sol.l2));






















