%% Fourier Transform and Inverse Fourier Transform
% Read the image
I1 = imread('lena.tif');

subplot(221);
imshow(I1);
title('Original Image');

% Computer its DFT using FFT commands
F1 = fft2(I1); % DFT
F = fftshift(fft2(I1));  % Shifted DFT 

% Magnitude Image Plot
% subplot(222);
% Mag=abs(F);% This result is greater than zero and might also be >255
% Mag=255 * Mag/max(max(Mag)); % Scaled magnitude output
% imshow(Mag); colormap(jet); colorbar; title('Magnitude Image'); 

Mag=log(abs(F)); 
subplot(222);
imshow(Mag,[]);
colormap(jet);
colorbar;
title ('Mag response');


% Phase Image Plot
subplot(223);
imshow(angle(F));
title('Phase Image');

% Inverse Fourier Transform
%subplot(224); I2=abs(ifft2(ifftshift(abs(F).*exp(j*angle(F)))));
  %optional ifft
%subplot(224); I2=abs(ifft2(ifftshift(abs(F).*(cos(angle(F))+j*sin(angle(F))))));
%this also works
subplot(224);

I2 = abs(ifft2(abs(F1) .* (cos(angle(F1)) + j * sin(angle(F1)))));

imshow(I2,[]);
title('Inverse Fourier Image');


%% Changing the phase and Magnitude of the image
RdMag=rand(size(I1)) .* abs(F);
RdAng=rand(size(I1)) .* angle(F);

figure;
subplot(121);
I3=abs(ifft2(ifftshift(RdMag .* exp(j*angle(F)))));
imshow(uint8(I3)); title('Magnitude Modified Fourier Image');


subplot(122);
I4=abs(ifft2(ifftshift(abs(F).*exp(j*RdAng))));
imshow(uint8(I4)); title('Phase Modified Fourier Image');

%% For General Knowledge
% figure;
% surf(Mag);colormap(jet); colorbar

figure;
subplot(121);
imshow(log(abs(F)),[-1 10]); colormap(jet); colorbar; title('Logarithm Magnitude Image');

subplot(122);
imshow(Mag, [-1 10]); colormap(jet); colorbar; colorbar; title('Sclaed Magnitude Image');
