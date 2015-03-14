clear all
close all
clc

tic

%I = imread('hand2.tif');            %image initialization

I = imread('fabric.png');
% I = rgb2gray(I);                  %conversion to graylevel
I = rgb2hsv(I);
[m n o] = size(I);                  %taking the size of the picture

Entropy_O = entropyfilt(I);         %Output of the entropy
Entropy_O = mat2gray(Entropy_O);    %converting the entropy matrix to grayscale image

for i=5:m-4
    for j = 5:n-4
        SubImage1 = I(i-4:i+4,j-4:j+4,1);      % 9x9 SubImage
        
        % computation of the GLCM
        glcm1 = graycomatrix(SubImage1, 'Offset',[0 1],'NumLevels',8,'Symmetric',false); 
        
        % application of the GLCM
        Contrast1 = graycoprops(glcm1, 'contrast');
        
        Energy1 = graycoprops(glcm1, 'energy');
        
        Homogeneity1 = graycoprops(glcm1, 'homogeneity');
        
        % Updating the outputs results
        Contrast_O (i,j,1) = Contrast1.Contrast;
        
        Energy_O (i,j,1) = Energy1.Energy;
        
        Homogeneity_O (i,j,1) = Homogeneity1.Homogeneity;
        
    end
    i           %just to check the status of the loop
end


% showing and writing resulting images
subplot(221); imshow(Contrast_O); title('Contrast result');
imwrite(Contrast_O,'Contrast result.tif');

subplot(222); imshow(Energy_O); title('Energy result');
imwrite(Energy_O,'Energy result.tif');
 
subplot(223); imshow(Homogeneity_O); title('Homogeneity result');
imwrite(Homogeneity_O,'Homogeneity result.tif');

subplot(224); imshow(Entropy_O); title('Entropy result');
imwrite(Entropy_O,'Entropy result.tif');

toc