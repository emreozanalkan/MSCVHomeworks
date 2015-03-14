% function for the lab session 1 of the SSI Lab01
% Date: 19:3:2014 Time 09:47 am
format long
mypdf1 = pdf('normal', -10:0.00001:10,0,sqrt(5));
n = length(mypdf1);
plot(1:1:n,mypdf1)
hold on
mypdf2 = pdf('normal', -10:0.00001:10,2,1);
n = length(mypdf2);
plot(1:1:n,mypdf2,'g')
hold off

% now i am going to plot for other to plot for part e
figure(100),
plot(1:1:n,0.8*mypdf1)
hold on
plot(1:1:n,0.2*mypdf2,'g')
hold off
%%
% now fo answering question 3

gh = find(mypdf1 == mypdf2);
myindexes = -10:0.00001:10;
% value of decison boundry will be
difference = abs(mypdf1) - abs(mypdf2);
min(difference)
indx = find(abs(difference) == abs(min(abs(difference))));
disp('index')
myindexes(indx)
% now second Intersection point of 2 pdf's
idx = find(mypdf1 - mypdf2 < eps, 1);
disp('second Crossing Point')
myindexes(idx)
% now we will calculate error
% in notes
%%
%Question 2 DHS:
% ploting the liklishood funciton
x = -10:0.00001:10;
lilkli = 2 * exp(abs(x-1) - (2*abs(x)));
figure(101),
plot(x,lilkli)
title('Liklihood Ration Plot Question 2 homework 1')
%%
% manhalobis distance to class 1
sigma1 = [0.475 -0.425;-0.425 0.475];
sigma2 = [1 0;0 1];
u1 = [1 1]';
u2 = [4 4]';
x = [2 2]';
dist1 = sqrt((x-u1)'*inv(sigma1)*(x-u1))
dist2 = sqrt((x-u2)'*inv(sigma2)*(x-u2))