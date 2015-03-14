% This function returns the mean filtered and normalized version of 
% the image.

function [ result ] = getMeanImage( img )

meanFilter = ones(7) / 49;

meanOutput = conv2(img, meanFilter, 'same');

maxVal = max(max(meanOutput));

meanOutput = meanOutput/maxVal;

result = meanOutput;