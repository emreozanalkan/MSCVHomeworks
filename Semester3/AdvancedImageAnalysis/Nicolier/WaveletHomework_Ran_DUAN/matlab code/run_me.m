% wavelet homework demo
% Ran DUAN 16-01-2015


%% image wavelet demo

clc;
clear all;
close all;

I = imread('Lena256.bmp');
[m,n] = size(I);

figure;

subplot(2,2,1);
affiche(I);
xlabel('original');

I = double(I);
img = I;

h = [0.48296 0.83652 0.22414 -0.12941];
N = 2;

% each line
for ii = 1:m
    s = I(ii,:);
    img(ii,:) = fwt_1d(s,N,h);
%     img = [img;row];
end
% each column
for ii = 1:n
    s = img(:,ii)';
    img(:,ii) = (fwt_1d(s,N,h))';
end

subplot(2,2,2);
colormap(gray(256));
ptr2d(img,N);
xlabel('wavelet');

% reconstruction

% each column
for ii = 1:n
    s = img(:,ii)';
    c = s(1:(m/2^N));
    dn = s((m/2^N + 1):end);
    img(:,ii) = (ifwt_1d(c,dn,N,h))';
end

% each line
for ii = 1:m
    s = img(ii,:);
    c = s(1:(m/2^N));
    dn = s((m/2^N + 1):end);
    img(ii,:) = ifwt_1d(c,dn,N,h);
end


subplot(2,2,3);
colormap(gray(256));
affiche(img);
xlabel('reconstruction');

subplot(2,2,4);
colormap(gray(256));
affiche(I./norm(I) - img./norm(img));
xlabel('difference');

%% denoise demo

clc;
clear all;

I = imread('Lena256.bmp');
[m,n] = size(I);
I = imnoise(I, 'gaussian', 0, 0.01);
figure;
subplot(2,2,1);
colormap(gray(256));
affiche(I);
xlabel('gaussian noise');

I = double(I);
img = I;

% compute wavelet

h = [0.48296 0.83652 0.22414 -0.12941];
N = 2;

% each line
for ii = 1:m
    s = I(ii,:);
    img(ii,:) = fwt_1d(s,N,h);
%     img = [img;row];
end
% each column
for ii = 1:n
    s = img(:,ii)';
    img(:,ii) = (fwt_1d(s,N,h))';
end

subplot(2,2,2);
colormap(gray(256));
ptr2d(img,N);
xlabel('wavelet');

% denoise
hf_map = img;
hf_map(1:(m/2^N),1:(n/2^N)) = 0;
sigma=median(abs(hf_map(:)))/0.6745;
threshold=3*sigma;
% hard
hard_img = (img).*((abs(img)>threshold));
% soft
soft_img = (sign(img).*(abs(img)-threshold)).*((abs(img)>threshold));

% reconstruction

% each column
for ii = 1:n
    s = hard_img(:,ii)';
    c = s(1:(m/2^N));
    dn = s((m/2^N + 1):end);
    hard_img(:,ii) = (ifwt_1d(c,dn,N,h))';
end

% each line
for ii = 1:m
    s = hard_img(ii,:);
    c = s(1:(m/2^N));
    dn = s((m/2^N + 1):end);
    hard_img(ii,:) = ifwt_1d(c,dn,N,h);
end

subplot(2,2,3);
colormap(gray(256));
affiche(hard_img);
xlabel('hard');

% each column
for ii = 1:n
    s = soft_img(:,ii)';
    c = s(1:(m/2^N));
    dn = s((m/2^N + 1):end);
    soft_img(:,ii) = (ifwt_1d(c,dn,N,h))';
end

% each line
for ii = 1:m
    s = soft_img(ii,:);
    c = s(1:(m/2^N));
    dn = s((m/2^N + 1):end);
    soft_img(ii,:) = ifwt_1d(c,dn,N,h);
end

subplot(2,2,4);
colormap(gray(256));
affiche(soft_img);
xlabel('soft');






