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
% Description:  getModel.m
%               Given the image I, location of model y, the scale of model
%               h and the number of bins for the histogrm, this function
%               will get the normalized model pdf.
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
%          I the image in grayscale uint8 format
%          y {1x2}[row col] location of ellipse center
%          h {1x2}[rowScale colScale] the scale of ellipse centered at y
%          m {1x1} number of bins to use in histogram
%
% OUTPUTS:
%          q {1xm} the normalized histogram (pdf)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [q] = getModel(I, y, h, m)

% get size of model image
ImgSize = size(I);
% get pixel locations inside model ellipse
[q_RowCol, q_loc] = getPointsInEllipse(y, h, ImgSize);
% get histogram q of model
[q, binNums] = probProfile(h, y, q_RowCol, I(q_loc), m);