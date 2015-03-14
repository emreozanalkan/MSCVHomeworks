% Practical works - No 5
% Discrete Fourrier Transform

% Exercise 1 - 2D frequency plan
% 1.1 Define an image as follows (or similar):
clc;
clear all;
close all;

Im = 0;
hsf = 0;
vsf = 0;
dsf = 0;

N = 64;
Ts = 1 / N;
Fs = N;
df = Fs / N; % Sampling

Im(N/8:N/4, N/4+1:N/2) = 1;
Im(1:N/4, N/2+1:N) = Im;
Im(N/4+1:N/2, :) = Im;
Im(N/2+1:3*N/4, :) = Im(1:N/4, :);
Im(3*N/4+1:N, :) = Im(1:N/4, :);

subplot(2, 3, 1), imagesc(Im);
colormap('gray');


tf = fft2(Im) / N / N; % normalisation
tfs = fftshift(tf);
moyenne = mean2(Im);
central0Frequency = tfs(N/2+1, N/2+1);
display(central0Frequency);
display(moyenne);
subplot(2, 3, 2), imagesc(abs(tfs));
%colormap('gray');
subplot(2, 3, 3), imagesc(angle(tfs) / pi * 180);
colormap('gray');

% horizontal freqency axis
hsf = tfs(N/2+1, :);
%subplot(2, 3, 4), plot(-Fs/2:df:Fs/2-df, abs(hsf));
subplot(2, 3, 4), plot(-N/2:N/2-1, abs(hsf));
title('freq horizontales');
% vertical freqency axis
vfs = tfs(:, N/2+1);
%subplot(2, 3, 5), plot(-Fs/2:df:Fs/2-df, abs(vfs));
subplot(2, 3, 5), plot(-N/2:1:N/2-1, abs(vfs));
title('freq verticales');

return


% Exercise 2 - Reconstruction from modulus and/or phase
%% 2.1
Im = imread('cameraman.tif');
figure(13), imagesc(Im); title('Image 1'); colormap('gray');
%Im = imread('bureau.gif');
NM = size(Im, 1) * size(Im, 2);
tf = fft2(Im) / NM; % normalization
tfs = fftshift(tf);
moyenne = mean2(Im)
figure(14), imagesc(log(abs(tfs)+1)); title('Modulus');
colormap('gray');
figure(15), imagesc(angle(tfs)/pi*180); title('Phase'); colormap('gray');

% reconstruction image with module
tfs = NM * tfs;
% reconstruction aves le module et la phase
% tfs = abs(tfs).*cos(angle(tfs))+i.*abs(tfs).*sin(angle(tfs))
tfsMod = abs(tfs) .* cos(0) + i .* abs(tfs) .* sin(0);
tfsPh = 1 .* cos(angle(tfs)) + i .* 1 .* sin(angle(tfs));
%reconstruction with modulus only
ImrMod = ifft2(fftshift(tfsMod));
figure(16), imagesc(log(abs(real(ImrMod) + 1)));
%figure(16), imagesc(((read(ImrMod)+))); % log ..
title('Reconstruction with modulus');
colormap('gray');
% reconstruction with phase only
ImrPh = ifft2(fftshift(tfsPh));
figure(17), imagesc(real(ImrPh));
title('Reconstruction with phase');
colormap('gray');

% 2.4
Im2 = imread('trees.tif');
Im2 = imresize(Im2, [size(Im, 1) size(Im, 2)]);
figure(21), imagesc(Im2); title('Image 2'); colormap('gray');
%Im = imread('bureau.gif');
NM2 = size(Im2, 1) * size(Im2, 2);
tf2 = fft2(Im2) / NM2; % normalization
tfs2 = fftshift(tf2);
%moyenne = mean2(Im)

tfsMod1Ph2 = abs(tfs) .* cos(angle(tfs2)) + i .* abs(tfs) .* sin(angle(tfs2));
tfsMod2Ph1 = abs(tfs2) .* cos(angle(tfs)) + i .* abs(tfs2) .* sin(angle(tfs));
ImrMod1Ph2 = ifft2(fftshift(NM2 * tfsMod1Ph2));
figure(18), imagesc(real(ImrMod1Ph2)); title('Modlus 1 et Phase');
colormap('gray');
ImrMod2Ph1 = ifft2(fftshift(NM2 * tfsMod2Ph1));
figure(19), imagesc(real(ImrMod2Ph1)); title('Modulus 2 et Phase');
colormap('gray');


return;






















