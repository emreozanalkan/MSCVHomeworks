close all
clear all
figure (1);
% subplot(1,2,1);
image=double(imread('academy.jpg'));
% image=imnoise(image,'salt & pepper',0.03);
imshow(uint8(image));
title('Original Image');
% colorTransform = makecform('srgb2lab','AdaptedWhitePoint',whitepoint('d65'));
% image = applycform(image, colorTransform);
image=image/255;
Rchannel=image(:,:,1);
Gchannel=image(:,:,2);
Bchannel=image(:,:,3);
w=9; % window size
sigma_d=10;
sigma_r=30;
[Rout]=bilateral_ec(w,sigma_r,sigma_d,Rchannel);
[Gout]=bilateral_ec(w,sigma_r,sigma_d,Gchannel);
[Bout]=bilateral_ec(w,sigma_r,sigma_d,Bchannel);
image(:,:,1)=(Rout);
image(:,:,2)=(Gout);
image(:,:,3)=(Bout);
% ct=makecform('lab2srgb');
% outputimg=applycform(fout,ct);
% subplot(1,2,2);
% imshow(image);
figure(2);
imshow(image);
title('d=10;r=30');

        
