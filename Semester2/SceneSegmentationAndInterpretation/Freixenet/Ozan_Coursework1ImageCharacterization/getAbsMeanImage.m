% This function returns the absolute mean filtered and normalized version 
% of the image.

function [ result ] = getAbsMeanImage( img )

meanFilter = ones(7) / 49;

absMeanOutput = conv2(abs(img), meanFilter, 'same');

maxVal = max(max(absMeanOutput));

absMeanOutput = absMeanOutput/maxVal;

result = absMeanOutput;