lena = imread('Lena256.bmp');

lena = double(lena);

figure(1);
imshow(lena, []);
title('Lena');

J = 2;

h = [0.48296, 0.83652, 0.22414, -0.12941];

% Wavelet transform
% function [ waveletCoefficients ] = jLevelWaveletTransform( image, J, lowPassFilter )
waveletCoefficients = jLevelWaveletTransform(lena, J, h);
figure(2);
imshow(waveletCoefficients, []);
title('Wavelet Coefficients');

% Inverse wavelet transform
% function [ reconstructedImage ] = inverseJLevelWaveletTransform( waveletCoefficients, J, lowPassFilter )
reconstructedImage = inverseJLevelWaveletTransform(waveletCoefficients, J, h);
figure(3);
imshow(reconstructedImage, []);
title('Reconstructed Image');

% Adding Noise
lenaNoisy = lena + randn(256,256) * 10;
figure(4);
imshow(lenaNoisy, []);
title('Lena Noisy');

% Wavelet transform on noisy Lena
noisyLenaWC = jLevelWaveletTransform(lenaNoisy, J, h);
figure(5);
imshow(noisyLenaWC, []);
title('Noisy Lena Wavelet Coefficients');

% Estimation of the noise level
hf = [noisyLenaWC(129:256,1:128), noisyLenaWC(129:256,129:256), noisyLenaWC(1:128,129:256)];
sigma = median(abs(hf(:))) / 0.6745;
threshold = 3 * sigma;

% Soft thresholding
wcSoft = (sign(noisyLenaWC) .* (abs(noisyLenaWC) - threshold)) .* ((abs(noisyLenaWC) > threshold));
% Hard thresholding
wcHard = (noisyLenaWC) .* ((abs(noisyLenaWC) > threshold));

% Inverse wavelet transform with Soft Threshold
reconstructedNoisyLenaSoft = inverseJLevelWaveletTransform(wcSoft, J, h);
figure(6);
imshow(reconstructedNoisyLenaSoft, []);
title('Reconstructed Noisy Lena w/ Soft Threshold');

% Inverse wavelet transform with Hard Threshold
reconstructedNoisyLenaHard = inverseJLevelWaveletTransform(wcHard, J, h);
figure(7);
imshow(reconstructedNoisyLenaHard, []);
title('Reconstructed Noisy Lena w/ Hard Threshold');