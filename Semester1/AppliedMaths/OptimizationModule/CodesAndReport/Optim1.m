close all;
clear all;
lb=-4;
ub=4;
x=lb:0.1:ub;
fx=-exp(-(x.^2))+exp(-(x+1).^2); % give function
plot(x,fx)
f=@(x) -exp(-(x.^2))+exp(-(x+1).^2); % pointer of function

%%
% brute force approach
[minibru]=bruteforce(fx) % returns minimum value using brute force approach
%%
% golden search
[minig]=golden(f) % returns minimum value using golden search
%%
%brent search
[minibre]=brent(f) % returns minimum value using brent's method
