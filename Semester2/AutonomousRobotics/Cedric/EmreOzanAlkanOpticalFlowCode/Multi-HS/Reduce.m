function smallIm = Reduce(im)
% REDUCE	Compute smaller layer of Gaussian Pyramid

% Sohaib Khan, Feb 16, 2000

%Algo
%Gaussian mask = [0.05 0.25 0.4 0.25 0.05] 
% Apply 1d mask to alternate pixels along each row of image
% apply 1d mask to each pixel along alternate columns of resulting image

% the mask that we're going to apply to the image
mask = [0.05 0.25 0.4 0.25 0.05];

% apply the mask to the image (horizontally)
% and take crop the two left-most and right-most columns
hResult = conv2(im, mask);
hResult = hResult(:,3:size(hResult,2)-2);
hResult = hResult(:, 1:2:size(hResult,2));

% apply the mask to the horizontal result (vertically) 
% applying transpose of mask
% crop the two top and bottom rows
vResult = conv2(hResult, mask');
vResult = vResult(3:size(vResult,1)-2, :);
vResult = vResult(1:2:size(vResult,1),:);

smallIm = vResult;
