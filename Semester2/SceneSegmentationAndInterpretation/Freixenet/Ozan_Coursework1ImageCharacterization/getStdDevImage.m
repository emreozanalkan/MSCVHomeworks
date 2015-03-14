% This function applies standard deviation filter on the image and
% normalizes it.

function [ result ] = getStdDevImage ( img )

stdDevOutput = stdfilt(img);

maxVal = max(max(stdDevOutput));

stdDevOutput = stdDevOutput/maxVal;

result = stdDevOutput;