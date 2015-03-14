clear all;
close all;
clc;

%%
% Class1
class1Mu = 0;
class1Sigma = 5;
class1X = -10:0.00001:10;
class1 = Class1(class1X, class1Mu, sqrt(class1Sigma));

% Class2
class2Mu = 2;
class2Sigma = 1;
class2X = -10:0.00001:10;
class2 = Class2(class2X, class2Mu, sqrt(class2Sigma));

% (b) Sketch the two density function of the two conditional densities.
figure;
plot(class1X, class1, 'g');
hold on;
plot(class2X, class2, 'b');

legend('Class 1','Class 2');

[row,column,v] = find(diff(sign(class1 - class2)));

xx = class1X(column);
yy = class1(column);
plot(xx, yy, 'o', 'MarkerSize', 10, 'Color', 'black');

stem(xx(1), max(class2), 'Color', 'red', 'Marker', 'x');
stem(xx(2), max(class2), 'Color', 'red', 'Marker', '^');
legend('Class 1','Class 2', 'Intersections', 'Boundray Min', 'Boundary Max');

% (c) Give the equation for the likelihood ratio.
figure;
plot(class1 ./ class2);

% (d) Assume that P(w1) = P(w2) = 0.5.
%       i. Using MAP approach, which class should we choose if x = 3.
        Pw1 = 0.5;
        Pw2 = 0.5;
        x = 3;
        class1MAP = class1(x) * Pw1;
        class2MAP = class2(x) * Pw2;
        
        if class1MAP > class2MAP
            display('class1 choosen with MAP approach at x = 3');
        else
            display('class2 choosen with MAP approach at x = 3');
        end

%       ii. Using ML approach, which class should we choose if x = 3.
        x = 3;
        class1ML = class1(x);
        class2ML = class2(x);
        
        if class1ML > class2ML
            display('class1 choosen with ML approach at x = 3');
        else
            display('class2 choosen with ML approach at x = 3');
        end
        
%       iii. How many decision regions do you see ? Describe those regions
%       based on your sketch.
% Described in line 25 through 33

% (e) Now assume that P(w_1) = 0.8 and P(w_2) = 0.2
Pw1 = 0.8;
Pw2 = 0.2;
x = 3;


%% DHS - Ch. 2, Eercise 2. Suppose two equally probably one-dimensional densities are of the form
%%
a1 = 0;  a2 = 1;
b1 = 1;  b2 = 2;

norm1 = @(x) exp(-abs(x-a1)/b1);
norm2 = @(x) exp(-abs(x-a2)/b2);

figure;
range = [-10:0.01:10];
Pw1 = norm1(range);
Pw2 = norm2(range);
plot(range, Pw1 ./ Pw2, 'r-');
hold off;

%% Euclidean distance vs Mahalanobis distance
% HW 2





        
