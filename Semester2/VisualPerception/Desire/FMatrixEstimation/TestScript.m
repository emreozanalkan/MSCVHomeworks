close all;
clear all;
clc;
return;

%% References
% [1] http://www.csse.uwa.edu.au/~pk/research/matlabfns/Projective/fundmatrix.m
% [2] http://www.csse.uwa.edu.au/~pk/research/matlabfns/Projective/normalise2dpts.m
% [3] Abinash
% [4] Devesh
% [5] Usman


%% Question 1

close all;
clear all;
clc;

chapel01 = imread('chapel01.png');
chapel02 = imread('chapel02.png');

keble01 = imread('keble01.png');
keble02 = imread('keble02.png');

labo_left = imread('labo_left.tif');
labo_right = imread('labo_right.tif');

Fc = zeros(3, 3);

Fk = zeros(3, 3);

Fl = zeros(3, 3);

selected_point_count = 12;

% PC1 = select_points(chapel01, selected_point_count);
% PC2 = select_points(chapel02, selected_point_count);

PC1 = [172    20     1
   344    65     1
   365   208     1
   289   178     1
   309   176     1
   316   242     1
   277   236     1
   215   141     1
   175    73     1
   173    57     1
    46   254     1
    99   156     1];

PC2 =[144    14     1
   339    55     1
   336   197     1
   249   166     1
   272   166     1
   277   232     1
   232   225     1
   179   131     1
   146    65     1
   145    48     1
    24   240     1
    82   145     1];


pointCount = size(PC1, 1);

A = zeros(pointCount, 8);

% [x*x', x*y', x, y*x', y*y', y, x', y, 1];

for ii = 1 : pointCount
    
    A(ii, :) = [PC1(ii, 1) * PC2(ii, 1), ... % x * x'
                PC1(ii, 1) * PC2(ii, 2), ... % x * y'
                PC1(ii, 1), ...              % x
                PC1(ii, 2) * PC2(ii, 1), ... % y * x'
                PC1(ii, 2) * PC2(ii, 2), ... % y * y'
                PC1(ii, 2), ...              % y
                PC2(ii, 1), ...              % x'
                PC1(ii, 2)%, ...             % y
                ]; %1];                      % 1
end

% Question 1 - 3.1
B = -1 * ones(selected_point_count, 1);
f_hat = pinv(A' * A, 1.0e-100) * A' * B;
f_hat = [f_hat; 1];
f_hat = reshape(f_hat, 3, 3);

% Question 1 - 3.2
[U, S, V] = svd(A);
f_bar = reshape([V(:, 8); 1], 3, 3);

% Question 1 - 3.3
[U2, S2, V2] = svd(f_bar);
S2(3, 3) = 0;
f_barHat = U2 * S2 * V2';

% Question 1 - 3.4
% Devesh says:
% he transformation matrix H is
% H = [s 0 -s*Cx;
%      0 s -s*Cy;
%      0 0 1];
% where Cx Cy is the mean of the points in x and y
% s=sqrt(2)/mean distance of points to centroid

C1x = mean(PC1(:, 1));
C1y = mean(PC1(:, 2));

PC1_bar(:, 1) =  PC1(:, 1) - C1x;
PC1_bar(:, 2) =  PC1(:, 2) - C1y;
PC1_bar(:, 3) =  1;

dist = sqrt(PC1(:, 1) .^ 2 + PC1(:, 2) .^ 2);
meandist = mean(dist(:));
s = sqrt(2) / meandist;

H = [s, 0, -s * C1x;
     0, s, -s * C1y;
     0, 0,  1];
 
 
 for ii = 1 : pointCount
     
     PC1_bar(ii, :) = PC1(ii, :) * H;
     PC2_bar(ii, :) = PC2(ii, :) * H';
     
 end
 
 for ii = 1 : pointCount
     
     A_bar(ii, :) = [PC1_bar(ii, 1) * PC2_bar(ii, 1), ... % x * x'
         PC1(ii, 1) * PC2(ii, 2), ... % x * y'
         PC1(ii, 1), ...              % x
         PC1(ii, 2) * PC2(ii, 1), ... % y * x'
         PC1(ii, 2) * PC2(ii, 2), ... % y * y'
         PC1(ii, 2), ...              % y
         PC2(ii, 1), ...              % x'
         PC1(ii, 2)%, ...             % y
         ]; %1];                      % 1
 end
 
 
 

 
 
 
 









% % Question 1 - 3.2
% [U, S, V] = svd(A);
% f_bar = reshape(V(:, 9), 3, 3);
% 
% % Question 1 - 3.3 - Enforcing the rank 2 constraint
% [U2, S2, V2] = svd(f_bar);
% S2(3, 3) = 0;
% f_barHat = U2 * S2 * V2';
% 
% epiLines = epipolarLine(f_barHat', PC1(:, 1:2));
% points = lineToBorderPoints(epiLines, size(chapel01));
% 
% imshow(chapel01);
% hold on;
% line(points(:, [1,3])', points(:, [2,4])');


% 
% % Abinash's method
% %f_hat(end + 1) = 1;
% f_bar = reshape(f_hat, 3, 3);
% [U, S, V] = svd(f_bar);
% S(3, 3) = 0;
% f = U * S * V;
% 
% 
% % From web
% [U, D, V] = svd(A,0);
% 
% F = reshape(V(:, 9), 3, 3)';
% 
% [U, D, V] = svd(F, 0);
% 
% F = U * diag([D(1, 1) D(2, 2) 0]) * V';
% 
% 
% %shouldBeZero = PC1(1, :) * F * PC2(1, :)'

%% Question 2
