%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJECT:
%     Mean Shift in Gray Scale
%
% BY:
%     Parthipan Siva
%     Assignment for SD 770-7: Topics in Particle Filtering
%     Systems Design Engineering
%     University of Waterloo
%
% DATE/Version:
%     Jan. 2007 - V 1.0
%
% Description:  probProfile.m
%               Given an ellipse centered at y with scale h and the 
%               coordinates of all pixels in ellipse (locXi), with its 
%               corresponding pixel intensity X and the number of bins in 
%               the histogram, this function will find the normalized 
%               histogram pdf.
%
% References:
%     D. Comaniciu, V. Ramesh, P. Meer: Real-Time Tracking of Non-Rigid 
%     Objects using Mean Shift, IEEE Conf. Computer Vision and Pattern 
%     Recognition (CVPR'00), Hilton Head Island, South  Carolina, Vol. 2, 
%     142-149, 2000 
%
% Project file list: 
%     getModel.m
%     getPointsInEllipse.m
%     probProfile.m
%     kernalProfile.m
%     getPointsInEllipseBorder.m
%     binNum.m
%     meanShift.m
%     getWeights.m
%     meerTrack.m
%     walk1.m
%     getScaleChange.m
%     Example1.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% INPUTS:
%          h {1x2}[hrow hcol] the scale of ellipse in the row and col 
%                             direction
%          y {1x2}[row col] matrix containing the location of ellipse center
%          locXi {nx2}[row col] matrix containing the location of all 
%                               pixels inside ellipse
%          X 1-D vector of all pixel values in ellipse
%          m {1x1} the number of bins
%
% OUTPUTS:
%          P {1xm} the normalized pdf
%          binNums the bin number to which the pixel at coordinate locXi 
%                  belongs to
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [P, binNums] = probProfile(h, y, locXi, X, m)

% find the distance from ellipse center, need to obtain weight
scaledDistSquared = ((y(1) - locXi(:,1))/(h(1)/2)).^2 + ((y(2) - locXi(:,2))/(h(2)/2)).^2;

% find the wieight of pixels in ellipse
kLocXi = kernalProfile(scaledDistSquared);

% calculate the normalization factor (NOTE this can be precalculated)
Ch = 1/sum(kLocXi);

% find the bin number of all pixels inside ellipse
binNums = binNum(X,m);

% for each bin number find the probability
for i = 0:m-1
    P(i+1) = sum(kLocXi(find(binNums==i)))*Ch;
end