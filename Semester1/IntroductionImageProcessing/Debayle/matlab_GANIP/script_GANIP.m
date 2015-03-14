%% PW GANIP / Solution

%% 0 - Cleaning
clc; clear all; close all;

%% 1 - GAN
A=imread('lena256.bmp');
A=double(A);

p=[200,100];
mtol=30;
GANp=GAN(A,p,mtol);

figure
subplot(131);imshow(A,[]);title('original image')
subplot(132);imshow(A,[]);hold on;plot(p(1),p(2),'*r');title('seed point')
subplot(133);imshow(GANp,[]);hold on;plot(p(1),p(2),'*r');title('GAN')

%% 2 - GAN Choquet filtering
h=ones(5,5)/9;
B=imfilter(A,h,'symmetric');
mtol=30;
tic
C=GANmean(A,mtol);
toc

figure
subplot(131);imshow(A,[]);title('original image')
subplot(132);imshow(B,[]);title('classical mean filtering')
subplot(133);imshow(C,[]);title('GAN mean filtering')

%% 3 - GAN morphological filtering
se=strel('disk',2);
Bdil=imdilate(A,se);
Bero=imerode(A,se);
tic
mtol=30;
Cdil=GANdilation(A,mtol);
Cero=GANerosion(A,mtol);
toc

figure
subplot(231);imshow(A,[]);title('original image')
subplot(232);imshow(Bdil,[]);title('classical dilation')
subplot(233);imshow(Bero,[]);title('classical erosion')
subplot(235);imshow(Cdil,[]);title('GAN dilation')
subplot(236);imshow(Cero,[]);title('GAN erosion')

%% 4 - Useful functions
type GAN
type GANmean
type GANdilation
type GANerosion