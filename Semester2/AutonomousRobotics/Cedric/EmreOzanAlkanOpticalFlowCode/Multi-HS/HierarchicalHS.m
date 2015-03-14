function [u, v, cert] = HierarchicalHS(im1, im2, numLevels, alpha, iterations, display)
%HIERARCHICALHS Summary of this function goes here
%   Detailed explanation goes here

cert = 0;

%% default parameters
% we check if im1 variable exists on workspace, otherwise we load our
% default images, and set default parameters
if(~exist('im1', 'var'))
    im1 = double(imread('yos9.tif'));
    im2 = double(imread('yos10.tif'));
    numLevels = 2;
    windowSize = 4;
    iterations = 2;
    display = 0;
end

%% checking

% image size
if (size(im1,1)~=size(im2,1)) | (size(im1,2)~=size(im2,2))
    error('images are not same size');
end;

% graylevel image
if (size(im1,3) ~= 1) | (size(im2, 3) ~= 1)
    error('input should be gray level images');
end;

% check image sizes and crop if not divisible
if (rem(size(im1,1), 2^(numLevels - 1)) ~= 0)
    warning('image will be cropped in height, size of output will be smaller than input!');
    im1 = im1(1:(size(im1,1) - rem(size(im1,1), 2^(numLevels - 1))), :);
    im2 = im2(1:(size(im1,1) - rem(size(im1,1), 2^(numLevels - 1))), :);
end;

if (rem(size(im1,2), 2^(numLevels - 1)) ~= 0)
    warning('image will be cropped in width, size of output will be smaller than input!');
    im1 = im1(:, 1:(size(im1,2) - rem(size(im1,2), 2^(numLevels - 1))));
    im2 = im2(:, 1:(size(im1,2) - rem(size(im1,2), 2^(numLevels - 1))));
end;

%% Build the multiresolution pyramids
% We get reference to im1 and im2 variables, then on attempt to change they will
% become copy of im1 and im2
pyramid1 = im1;
pyramid2 = im2;

% We build the image pyramids like gaussian pyramids
for i=2:numLevels
    im1 = Reduce(im1);
    im2 = Reduce(im2);
    pyramid1(1:size(im1,1), 1:size(im1,2), i) = im1;
    pyramid2(1:size(im2,1), 1:size(im2,2), i) = im2;
end;

%% optical flow computation

% base level computation
% first guess for the optical flow, so we can feed them to the next steps
disp('Computing Level 1');
baseIm1 = pyramid1(1:(size(pyramid1,1)/(2^(numLevels-1))), 1:(size(pyramid1,2)/(2^(numLevels-1))), numLevels);
baseIm2 = pyramid2(1:(size(pyramid2,1)/(2^(numLevels-1))), 1:(size(pyramid2,2)/(2^(numLevels-1))), numLevels);
[u,v] = HS(baseIm1, baseIm2, alpha);

for r = 1:iterations
    [u, v] = HSRefined(baseIm1, baseIm2, alpha, 100, u, v); % same as HS
end

%propagating flow 2 higher levels
for i = 2:numLevels
    disp(['Computing Level ', num2str(i)]);
    uEx = 2 * imresize(u,size(u)*2);   % use appropriate expand function (gaussian, bilinear, cubic, etc).
    vEx = 2 * imresize(v,size(v)*2);
    
    curIm1 = pyramid1(1:(size(pyramid1,1)/(2^(numLevels - i))), 1:(size(pyramid1,2)/(2^(numLevels - i))), (numLevels - i)+1);
    curIm2 = pyramid2(1:(size(pyramid2,1)/(2^(numLevels - i))), 1:(size(pyramid2,2)/(2^(numLevels - i))), (numLevels - i)+1);
    
    [u, v] = HSRefined(curIm1, curIm2, alpha, 100, uEx, vEx); % same as HS
    
    for r = 1:iterations
        [u, v] = HSRefined(curIm1, curIm2, alpha, 100, u, v); % same as HS
    end
end;

if (display==1)
    figure, quiver(Reduce((Reduce(medfilt2(flipud(u),[5 5])))), -Reduce((Reduce(medfilt2(flipud(v),[5 5])))), 0), axis equal
end

end

