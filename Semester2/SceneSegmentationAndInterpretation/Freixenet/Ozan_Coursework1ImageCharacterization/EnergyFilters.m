close all;
clear all;

%image = imread('hand2.tif');
image = imread('fabric.png');

% Extract red, blue and green channels from the image
imageR = image(:,:,1);
imageG = image(:,:,2);
imageB = image(:,:,3);

% Convert the image to HSV color space
hsvImage = rgb2hsv(image);

% Extract the HUE value
imageHue = hsvImage(:,:,1);

% Convert also to grayscale
imageGray = im2double(rgb2gray(image));

% Display the original image
figure; imshow(image); title('Original Image');

% Convert all to double
imageR = im2double(imageR);
imageG = im2double(imageG);
imageB = im2double(imageB);

[ m n ] = size(imageR);

% Define the primitive filters to create Laws' Masks

L3 = [ 1 2 1 ];
E3 = [ -1 0 1 ];
S3 = [ -1 2 -1 ];

L5 = [ 1 4 6 4 1 ];
E5 = [ -1 -2 0 2 1 ];
S5 = [ -1 0 2 0 -1 ];
R5 = [ 1 -4 6 -4 6 1 ];
W5 = [ -1 2 0 -2 -1 ];

% Here, we create our Laws mask
lawsMask = W5'*W5;

% Convolve each RGB channel with this mask
convolvedImgR = applyMask(imageR, lawsMask);
convolvedImgG = applyMask(imageG, lawsMask);
convolvedImgB = applyMask(imageB, lawsMask);

figure; imshow(convolvedImgR); title('hoho');

% Convolve the Hue component
convolvedImgHue = applyMask(imageHue, lawsMask);

% Convolve the grayscale image
convolvedImgGray = applyMask(imageGray, lawsMask);

figure; subplot(231); imshow(convolvedImgR); title('Convolved Image (Red)');
subplot(232); imshow(convolvedImgG); title('Convolved Image (Green)');
subplot(233); imshow(convolvedImgB); title('Convolved Image (Blue)');
subplot(234); imshow(convolvedImgHue); title('Convolved Image (HUE)');
subplot(235); imshow(convolvedImgGray); title('Convolved Image (Grayscale)');

%% Laws Masks

% Mean Statistics

% Apply Mean Statistics to each RGB channel
meanOutputR = getMeanImage(convolvedImgR);
meanOutputG = getMeanImage(convolvedImgG);
meanOutputB = getMeanImage(convolvedImgB);

% Apply Mean Stats to Hue component
meanOutputHue = getMeanImage(convolvedImgHue);

% Apply Mean Stats to grayscale image
meanOutputGray = getMeanImage(convolvedImgGray);

% Combine RGB channels
meanOutput(:,:,1) = meanOutputR;
meanOutput(:,:,2) = meanOutputG;
meanOutput(:,:,3) = meanOutputB;

figure; subplot(231); imshow(meanOutputR); title('Mean Statistics (Red)');
subplot(232); imshow(meanOutputG); title('Mean Statistics (Green)');
subplot(233); imshow(meanOutputB); title('Mean Statistics (Blue)');
subplot(234); imshow(meanOutputHue); title('Mean Statistics (HUE)');
subplot(235); imshow(meanOutputGray); title('Mean Statistics (Grayscale)');
subplot(236); imshow(meanOutput); title('Mean Statistics (Combined RGB)');

% Absolute Mean Statistics

% Apply Absolute Mean Statistics to each RGB channel
absMeanOutputR = getAbsMeanImage(convolvedImgR);
absMeanOutputG = getAbsMeanImage(convolvedImgG);
absMeanOutputB = getAbsMeanImage(convolvedImgB);

% Apply Absolute Mean Stats to Hue component
absMeanOutputHue = getAbsMeanImage(convolvedImgHue);

% Apply Absolute Mean Stats to grayscale image
absMeanOutputGray = getAbsMeanImage(convolvedImgGray);

% Combine RGB channels
absMeanOutput(:,:,1) = absMeanOutputR;
absMeanOutput(:,:,2) = absMeanOutputG;
absMeanOutput(:,:,3) = absMeanOutputB;


figure; subplot(231); imshow(absMeanOutputR); title('Absolute Mean Statistics (Red)');
subplot(232); imshow(absMeanOutputG); title('Absolute Mean Statistics (Green)');
subplot(233); imshow(absMeanOutputB); title('Absolute Mean Statistics (Blue)');
subplot(234); imshow(absMeanOutputHue); title('Absolute Mean Statistics (HUE)');
subplot(235); imshow(absMeanOutputGray); title('Absolute Mean Statistics (Grayscale)');
subplot(236); imshow(absMeanOutput); title('Absolute Mean Statistics (Combined RGB)');


% Std. Dev. Statistics

% Apply Standard Deviation Statistics to each RGB channel
stdDevOutputR = getStdDevImage(convolvedImgR);
stdDevOutputG = getStdDevImage(convolvedImgG);
stdDevOutputB = getStdDevImage(convolvedImgB);

% Apply Std. Dev. Stats to Hue component
stdDevOutputHue = getStdDevImage(convolvedImgHue);

% Apply Std. Dev. Stats to grayscale image
stdDevOutputGray = getStdDevImage(convolvedImgGray);

% Combine RGB channels
stdDevOutput(:,:,1) = stdDevOutputR;
stdDevOutput(:,:,2) = stdDevOutputG;
stdDevOutput(:,:,3) = stdDevOutputB;

figure; subplot(231); imshow(stdDevOutputR); title('Std Deviation Statistics (Red)');
subplot(232); imshow(stdDevOutputG); title('Std Deviation Statistics (Green)');
subplot(233); imshow(stdDevOutputB); title('Std Deviation Statistics (Blue)');
subplot(234); imshow(stdDevOutputHue); title('Std Deviation Statistics (HUE)');
subplot(235); imshow(stdDevOutputHue); title('Std Deviation Statistics (Grayscale)');
subplot(236); imshow(stdDevOutput); title('Std Deviation Statistics (Combined RGB)');         
        