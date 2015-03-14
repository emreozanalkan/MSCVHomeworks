% Adam Kukucka
% Zach Clay
% Marcelo Molina    
% CSE 486 Project 3

function [ cmin, cmax, rmin, rmax ] = select( I )
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here


% for array... x is cols, y is rows
imshow(uint8(I));
k = waitforbuttonpress;
point1 = get(gca,'CurrentPoint');  %mouse pressed
rectregion = rbbox;  
point2 = get(gca,'CurrentPoint');
point1 = point1(1,1:2);              % extract col/row min and maxs
point2 = point2(1,1:2);
lowerleft = min(point1, point2);
upperright = max(point1, point2);
cmin = round(lowerleft(1));
cmax = round(upperright(1));
rmin = round(lowerleft(2));
rmax = round(upperright(2));