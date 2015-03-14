clc;

im = imread('fabric.png');
im = im2double(im);

%% Linear regularization

% example of regularization
h = [1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1] / 25;

% 2D convolition
imConv(:, :, 1) = conv2(im(:, :, 1), h, 'same');
imConv(:, :, 2) = conv2(im(:, :, 2), h, 'same');
imConv(:, :, 3) = conv2(im(:, :, 3), h, 'same');

% preparation for display
m1 = max(max(imConv(:, :, 1)));
m2 = max(max(imConv(:, :, 2)));
m3 = max(max(imConv(:, :, 3)));

imConvReg(:, :, 1) = (imConv(:, :, 1)) ./ m1;
imConvReg(:, :, 2) = (imConv(:, :, 2)) ./ m2;
imConvReg(:, :, 3) = (imConv(:, :, 3)) ./ m3;

imshowpair(imConv, imConvReg, 'montage');

%% --- Non-linear regularization ---
imMed(:, :, 1) = medfilt2(im(:, :, 1), [5, 5]);
imMed(:, :, 2) = medfilt2(im(:, :, 2), [5, 5]);
imMed(:, :, 3) = medfilt2(im(:, :, 3), [5, 5]);

% preparation for display
imMedReg(:, :, 1) = (imMed(:, :, 1))/max(max(im2(:, :, 1)));
imMedReg(:, :, 2) = (imMed(:, :, 2))/max(max(im2(:, :, 2)));
imMedReg(:, :, 3) = (imMed(:, :, 3))/max(max(im2(:, :, 3)));

imshowpair(imMed, imMedReg, 'montage');

%% Show difference
%imshowpair(imConvReg, imMedReg);
imshowpair(imConvReg, imMedReg, 'montage');


%% Exercises

h = [1 1 1; 1 1 1; 1 1 1]/9;

im = [0 0 0 0 0; ...
         0 1 1 1 0; ...
         0 1 1 0 0; ...
         0 1 0 0 0; ...
         0 0 0 0 0];
     
imConv = conv2(im, h);
     
     
imMed = medfilt2(im, [3 3]);


%% Fourrier filtering: Butterworth
w0 = 50;
x = 0;

for wx = -128 : 1 : 127
    
    x = x + 1;
    
    y = 0;
    
    for wy = -128 : 1 : 127
        
        y = y + 1;
        
        Tw(x, y) = 1 / (1 + ((wx ^ 2 + wy ^ 2) / w0 ^ 2) ^ 2);
        
    end
    
end

wx = (-128 : 1 : 127);
wy = (-128 : 1 : 127);

figure(15), mesh(wx, wy, abs(Tw));
fr = real(fftshift(ifft2(fftshift(Tw))));
fi = imag(fftshift(ifft2(fftshift(Tw))));
figure(16), mesh(fr);
figure(17), mesh(fi);

Im = imread('tire.tif');
Im = imresize(Im, [256 256]);
Imf = fftshift(fft2(Im));
figure(18), imagesc(Im); colormap('gray');
figure(19), imagesc(abs(log(Imf))); colormap('default');

ImfB = Tw .* Imf;
figure(20), imagesc(abs(log(ImfB))); colormap('default');
ImR = (ifft2(fftshift(ImfB)));
figure(21), imagesc(real(ImR)); colormap('gray');



% %% local regularizatino by local minimisation of ||Ax-b|| ^ 2 with a 2D polynomial model
% Im = im2double(imread('fabric.png'));
% [Ni, Nj] = size(Im);
% 
% M = 3; % mid-size of the local estimation
% Ires = zeros(Ni, Nj);
% 
% for i = 1 + M : Ni - M
%     
%     for j = 1 + M : Nj - M
%         
%         % local sub-image
%         Isub = Im (i - M : i + M, j - M : j + M);
%         % local polynomial approximation(Least Square Minimisation)
%         p = fit
%         
%     end
%     
% end



































