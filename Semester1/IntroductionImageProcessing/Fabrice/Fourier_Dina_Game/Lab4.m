
function Lab4()
clear 
close all
img = rgb2gray(imread ('X.png'));
fourrier (img);
% figure;
% phaseChange(img);
% figure;
% magChange(img);
% figure;
% addNoise(img);
% figure;
% addBlur(img);

end

function fourrier(img)
subplot(2,3,1); imagesc(img);colormap(gray);
title('Original image');
imgFourrier = fft2(img);
shiftedImgFourrier = fftshift(imgFourrier);

subplot(2,3,2); imagesc(abs(shiftedImgFourrier));colormap(gray);
title('Fourrier Magnitude shifted');
subplot(2,3,3); imagesc(log(abs(shiftedImgFourrier)));colormap(gray);
title('Shifted Fourrier Magnitude log scale');
restoring = abs(ifft2(ifftshift(shiftedImgFourrier)));
subplot(2,3,4); imagesc(restoring);colormap(gray);
title('Restoring the image after phase change');

% img = rgb2gray(imread ('bar5.jpg'));
% subplot(2,5,6); imagesc(img);colormap(gray);
% imgFourrier = fft2(img);
% subplot(2,5,7); imagesc(abs(imgFourrier)); colormap(gray);
% 
% imgFourrierModified =  (abs(fftshift (imgFourrier)));
% subplot(2,5,8); imagesc(imgFourrierModified);colormap(gray);
% subplot(2,5,9); imagesc(log(imgFourrierModified));colormap(gray);
% 
% restoring = abs(ifft2(imgFourrier));
% subplot(2,5,10); imagesc(restoring);colormap(gray);


end

function  phaseChange(img)

subplot(2,3,1); imagesc(img);colormap(gray);
title('Original image');
imgFourrier = fft2(img);
shiftedImgFourrier = fftshift(imgFourrier);

subplot(2,3,2); imagesc(abs(shiftedImgFourrier));colormap(gray);
title('Fourrier Magnitude shifted');
subplot(2,3,3); imagesc(log(abs(shiftedImgFourrier)));colormap(gray);
title('Shifted Fourrier Magnitude log scale');

dim = size(angle(shiftedImgFourrier));
%S = randi(dim(1), dim(2));

mag =  abs(shiftedImgFourrier);
phase = angle(shiftedImgFourrier);

imgFourrier = mag .* exp(1i*phase);

subplot(2,3,4); imagesc(abs(imgFourrier)); colormap(gray);
title('Mag after phase change');
subplot(2,3,5); imshow(angle(imgFourrier)); %colormap(gray);
title('Phase after phase change');

 
restoring = real(ifft2(ifftshift(imgFourrier)));
t = angle(ifft2(ifftshift(imgFourrier)))
subplot(2,3,6); imagesc(restoring);colormap(gray);
title('Restoring the image after phase change');
end

function  magChange(img)

subplot(2,3,1); imagesc(img);colormap(gray);
title('Original image');
imgFourrier = fft2(img);
shiftedImgFourrier = fftshift(imgFourrier);

subplot(2,3,2); imagesc(abs(shiftedImgFourrier));colormap(gray);
title('Fourrier Magnitude shifted');
subplot(2,3,3); imagesc(log(abs(shiftedImgFourrier)));colormap(gray);
title('Shifted Fourrier Magnitude log scale');

dim = size(abs(shiftedImgFourrier));
S = randi(dim(1), dim(2));

mag =  S;%abs(shiftedImgFourrier);
phase = angle(shiftedImgFourrier);

imgFourrier = mag .* exp(1i*phase);

subplot(2,3,4); imagesc(abs(imgFourrier)); colormap(gray);
title('Mag after mag change');
subplot(2,3,5); imshow(angle(imgFourrier)); %colormap(gray);
title('Phase after mag change');

 
restoring = real(ifft2(ifftshift(imgFourrier)));
subplot(2,3,6); imagesc(restoring);colormap(gray);
title('Restoring the image after mag change');

end

function addNoise(img)
subplot(2,4,1); imagesc(img);colormap(gray);
title('Original image');

imgNoise = imnoise(img,'gaussian');
subplot(2,4,2); imagesc(imgNoise);colormap(gray);
title('Image with noise');

imgFourrier = fft2(imgNoise);
subplot(2,4,3); imagesc(abs(imgFourrier)); colormap(gray);
title('Abs of Fourrier Magnitude');


imgFourrierModified =  (abs(fftshift (imgFourrier)));
subplot(2,4,4); imagesc(imgFourrierModified);colormap(gray);
title('Fourrier Magnitude shifted');
subplot(2,4,5); imagesc(log(imgFourrierModified));colormap(gray);
title('Shifted Fourrier Magnitude log scale');
restoring = abs(ifft2(imgFourrier));
subplot(2,4,6); imagesc(restoring);colormap(gray);
title('Restoring the image after phase change');

end

function addBlur(img)
subplot(2,4,1); imagesc(img);colormap(gray);
title('Original image');


H = fspecial('average',[3 3]);
imgBlur = imfilter(img,H,'replicate');
subplot(2,4,2); imagesc(imgBlur);colormap(gray);
title('Image with blur');

imgFourrier = fft2(imgBlur);
subplot(2,4,3); imagesc(abs(imgFourrier)); colormap(gray);
title('Abs of Fourrier Magnitude');


imgFourrierModified =  (abs(fftshift (imgFourrier)));
subplot(2,4,4); imagesc(imgFourrierModified);colormap(gray);
title('Fourrier Magnitude shifted');
subplot(2,4,5); imagesc(log(imgFourrierModified));colormap(gray);
title('Shifted Fourrier Magnitude log scale');
restoring = abs(ifft2(imgFourrier));
subplot(2,4,6); imagesc(restoring);colormap(gray);
title('Restoring the image after phase change');

end


