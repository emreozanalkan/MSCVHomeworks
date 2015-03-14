% This function applies the given mask on the given image
% and normalizes it.

function [ result ] = applyMask( image, mask )

convImg = imfilter(image, mask, 'replicate', 'conv');

maxVal = max(max(convImg));

convImg = convImg/maxVal;

result = convImg;