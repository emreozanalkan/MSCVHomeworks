% Color and multispectral Imaging
% Lab 3

% Part 1: demosaicing
%% Question 1
% CFA = Color Filter Array
demosaic1 = imread('Demosaic5.tif');

subplot(1, 2, 1);
imshow(demosaic1);

Image_CFA = bayer(demosaic1);
subplot(1, 2, 2);
imshow(Image_CFA);

%% Question 2
demosaic = imread('Demosaic5.tif');

subplot(1, 3, 1);
imshow(demosaic);

Image_CFA = bayer(demosaic);
subplot(1, 3, 2);
imshow(Image_CFA);

Output_RGB = BilinearInterpolationLoop(Image_CFA);
subplot(1, 3, 3);
imshow(Output_RGB);


