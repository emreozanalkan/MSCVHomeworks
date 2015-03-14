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
% Description:  binNum.m
%               Given a pixel value between 0 and 255, this function will 
%               get the bin number of the pixel between 0 and m-1. Assume 
%               there are m bins.
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
%          m {1x1} bin number
%          x_i {nx1} vector of gray scale value between 0 and 255
%
% OUTPUTS:
%          b {nx1} bin number between 0 and m-1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [b] = binNum(x_i, m)

x_i = double(x_i);
b = round(x_i / 255 * (m-1));