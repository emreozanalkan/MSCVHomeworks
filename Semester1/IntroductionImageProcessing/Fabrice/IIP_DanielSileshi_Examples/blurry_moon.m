%% 
close all;
clear all;
echo off;


%%
% Adding 'Salt&Pepper' noise to images and filtering the noisy image with
% 'Average' and 'Median' Filters


I = imread('moon.jpg');
figure;
subplot(221);
imshow(I);
title('Original Image');

% For scaling purpose
% Applying 'Laplacian' filter to images
h=[0 1 0;1 -4 1;0 1 0];
I1 = filter2(h,I);  %y= filter2(h,X) filters the data in X with the two-dimensional FIR filter in the matrix h
subplot(222);
imshow(I1);
title('Laplacian Filtered Image with out scaling');
I1s=I1 - min(min(I1));
I1s=I1s/max(max(I1s));
I1s=255*I1s;
I1s=uint8(I1s);
subplot(223);
imshow(I1s);
title('Laplacian Filtered Image');


h=[1 1 1;1 -8 1;1 1 1];
I2 = filter2(h,I); % Scale the Laplacian result properly
figure;
subplot(222);
imshow(I2);title('Laplacian Filtered Image with out scaling');
I2s=I2 - min(min(I2));
I2s=I2s/max(max(I2s));
I2s=255*I2s;
I2s=uint8(I2s);
subplot(223);
imshow(I2s);
title('Laplacian Filtered Image');



% Image Enhancement Using Laplacian Filter
I3= I - uint8(I1);
figure;
imshow(I);
title('Original Image');
figure;
imshow(I3);
title('Enhanced Image by Laplacian Filter-a');
% 
% I3=I - uint8(I2);
% figure;imshow(I3);title('Enhanced Image by Laplacian Filter-b');

