clear all;
close all;
clc;

%% Test 1

pointA = [0,  -10, 0];
pointB = [0,   10, 0];
pointC = [50,  10, 10];
pointD = [50, -10, 10];

points = [pointA' pointB' pointC' pointD'];

fill3(points(1, :), points(2, :), points(3, :), 'r');

