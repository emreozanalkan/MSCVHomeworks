% Lab Exam - 2h - Thursday 9 January 2014
% Emre Ozan Alkan
% Send to olivier.laligant@u-bourgogne.fr

% close all;
% clear;
% clc;

% Exercise 1 - System y_{k} = x_{k+1} - x_{k-1}, y: output, x: input

%% 1.1 Is the system causal ?
    % System is not causal, because one of the input(x_{k+1}) depeneds on
    % the future value
    
%% 1.2 Is the system stable ?
    % System is stable 
    
%% 1.3 Thans to the signal x_{k} = U(k - 7) - U(k - 15) for k in [1, N = 20],
%  U being the Heaviside/step function, demonstrate the system is linear (or not).
    N = 20;
    
    k = 7;
    Uk7(1:k-1) = zeros(1,k-1);
    Uk7(k:N) = ones(1,N-k+1);
    
    k = 15;
    Uk15(1:k-1) = zeros(1,k-1);
    Uk15(k:N) = ones(1,N-k+1);
    
    x = Uk7 - Uk15;
    
    plot(x, '*');
    
    % System is not linear.
    
%% 1.4 Plot or display the exact definition (including the abcissa coordinates)
%  of the impulse response h of the system.
    N = 20;
    d = zeros(1,N);
    d(2) = 1;
    h = d(2:N) - d(1:N-1);
    plot(h, 'r*');
    
%  1.5 Check you can obtain y from x and h thanks to the matlab conv
%  function
    C = conv(d, h);
    plot(C);
    
%  1.6 Compute the integral filter H thanks to the primitive operator ...

%  1.7 Demonstrate you can obtain y from x, H and another elementary filder
%  D thanks to the matlab conv function. Display D.

%  1.8 Plot the |FFT| of h, H and D. Comment these results (frequency
%  behaviour/property).

%% Create a small image 32px32p, perform 2D edge detection. Disp mod and phase
clear Im;
N = 32;

matlabIm = imread('blobs.png');
%matlabIm = imread('cell.tif');
%matlabIm = imread('board.tif');
%matlabIm = imread('rice.png');
%imshow(matlabIm);

% Ts = 1 / N;
% Fs = N;
% df = Fs / N; % Sampling

% Im(N/8:N/4, N/4+1:N/2) = 1;
% Im(1:N/4, N/2+1:N) = Im;
% Im(N/4+1:N/2, :) = Im;
% Im(N/2+1:3*N/4, :) = Im(1:N/4, :);
% Im(3*N/4+1:N, :) = Im(1:N/4, :);
%imagesc(Im);

Im(1:32, 1:32, :) = matlabIm(1:32, 1:32, :);
subplot(2, 3, 1);
imshow(Im);title('Image 32x32');
% colormap('gray');
s = 0.7 % scaling
[ImGi, ImGj] = CannyDriche(Im, s);
subplot(2, 3, 2);
imshow(ImGi);title('ImGi');
subplot(2, 3, 3);
imshow(ImGj);title('ImGj');

subplot(2, 3, 4);
imagesc(abs(ImGi+j*ImGj));title('Modulus');

subplot(2, 3, 5);
imagesc(angle(ImGi+j*ImGj));title('Phase');



    
    




%% matlab default images
pth = fileparts(which('cameraman.tif'));
    D = dir(pth);
    C = {'.tif';'.jp';'.png';'.bmp'};
    idx = false(size(D));
    for ii = 1:length(C)
        idx = idx | (arrayfun(@(x) any(strfind(x.name,C{ii})),D));
    end
    D = D(idx);
    for ii = 1:numel(D)
        fprintf('%s\n',D(ii).name)
    end
















