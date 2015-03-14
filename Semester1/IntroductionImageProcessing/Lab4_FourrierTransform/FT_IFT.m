% 1.1 Fourrier Transform and Inverse Fourrier Transform

clc;

% FIRST IMAGE
lena = imread('lena.jpg');
lenaGray = rgb2gray(lena);
subplot(2, 2, 1);
imshow(lenaGray);
title('Original Lena Image');

% SECOND IMAGE
lenaFFT2 = fft2(lenaGray);
subplot(2, 2, 2);
imshow(lenaFFT2);
title('FFT 2D Gray Lena Image');

% THIRD IMAGE
lenaFFT2Shift = fftshift(lenaFFT2);
lenaFFT2Shift = abs(lenaFFT2Shift);
lenaFFT2Shift = log(lenaFFT2Shift);
subplot(2, 2, 3);
imshow(lenaFFT2Shift, []);
title('FFT 2D Shifted Gray Lena Image');
%imagesc(lenaFFT2Shift);

% FOURTH IMAGE
lenaIFFT = ifft(lenaFFT2Shift);
subplot(2, 2, 4);
imshow(lenaIFFT);
title('IFFT of FFT 2D Shifted Gray Lena Image');


%    FFT                 ===> Magnitude
%IMG ===> FFT IMAGE ===>                 ====> FFT Image ===> IMG
%    Shift               ===> Phase                      Shift
%                         -Pi < phi < Pi