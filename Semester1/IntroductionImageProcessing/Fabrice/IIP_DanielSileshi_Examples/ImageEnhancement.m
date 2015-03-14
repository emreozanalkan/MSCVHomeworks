


%% Image Negative
% 
% Image = rgb2gray(imread('t10.tif'));
% ImageNeg = 255-Image; %gray level Image
% figure;subplot(221);imshow(Image);title('Original Image');
% subplot(222);imhist(Image);title('Histogram of Original Image');
% subplot(223);imshow(ImageNeg);title('Negative of the Image');
% subplot(224);imhist(ImageNeg);title('Histogram of Image');
% clear all

% %% Contrast Stretching
% Image = imread('landsat.tif');
% Threshold = 100;
% figure;subplot(211);imshow(Image);title('Original Image');
% for i = 1:size(Image,1)
%     for j = 1:size(Image,2)
%         
%         if(Image(i,j)>Threshold)
%             Image(i,j) = 255;
%         else
%             Image(i,j)= Image(i,j);%for thresholding Image(i,j)=0;
%         end
%     end
% end
% subplot(212);imshow(Image);title('Contrast Image');
% clear all

% %% Histogram Manipulation
% Image = imread('landsat.tif');%landsat,lena,sonar,sar
% figure; subplot(321);imshow(Image);title('Original Image');
% subplot(322);imhist(Image,128);title('Histogram of the Image');
% 
% % Histogram Equalization
% 
% ImageEq=histeq(Image);
% subplot(323);imshow(ImageEq);title('Image after Histogram Equalization');
% subplot(324);imhist(ImageEq);title('Histogram of the Image after Histogram Equalization');
% 
% % Image Adjustment
% ImageAdjust=imadjust(Image);
% subplot(325);imshow(ImageAdjust);title('Image after Adjustment');
% subplot(326);imhist(ImageAdjust);title('Histogram of the Image after Adjustment');
% 
% clear all

%% Different Images with same Histogram 
close all;
clear;
clc;
Image = rgb2gray(imread('LenaRGB.tif'));
Image1 = rgb2gray(imread('PeppersRGB.tif'));

figure; subplot(221);imshow(Image);title('Original Image');
subplot(222);imhist(Image);title('Histogram of the Image');

subplot(223);imshow((Image1));title('Original Image');
subplot(224);imhist(Image1);title('Histogram of the Image');
