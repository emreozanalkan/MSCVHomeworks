close all;
clear all;
clc;

source = [1 1 1];

pattern = generatePattern(100, 1, 60);

[normal_mat,d_mat] = projector(source,pattern);

drawProjection(source, pattern);