%% SPONF Materials from pixel-shaker.net

bigImage = imread('a.png');

smallImage = imread('qbear.png');

[rowBigImage, colBigImage] = size(bigImage);

[rowSmallImage, colSmallImage] = size(smallImage);

bigSmallImage = zeros(size(bigImage));

bigSmallImage(fix(rowBigImage/2-rowSmallImage/2):fix(rowBigImage/2+rowSmallImage/2)-1,fix(colBigImage/2-colSmallImage/2):fix(colBigImage/2+colSmallImage/2)-1) = smallImage;

bigImageFFT = fft2(bigImage); 

smallImageFFT = fft2(bigSmallImage); 

detectionOfSmallImage = conj(bigImageFFT./abs(bigImageFFT)).*(smallImageFFT./abs(smallImageFFT));

imshow(ifft2(detectionOfSmallImage),[]);

title('Black dot shows the loccaiton of bear');
