clear all
close all
image=imread('image.jpg');
figure(1);
imshow(image);
title('Input Image');
% Preprocessing
[rows cols dims]=size(image);
if dims>2
grayimg=rgb2gray(image);
end
% Segmentation
thresh=graythresh(grayimg);
bwimg=~im2bw(grayimg,0.5);
% imagen = bwareaopen(bwimg,10);
% se = strel('disk',2);        
% erodedBW = imerode(imagen,se);


