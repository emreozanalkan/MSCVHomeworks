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
% Description:  walk1.m
%               Returns the nth frame of the PETS 2004 Walk1.mpg video.
%               The handle to this function is used by the Example1.m
%               script.
%               REQUIRES: mmread by Micah Richert.
%
% References:
%     D. Comaniciu, V. Ramesh, P. Meer: Real-Time Tracking of Non-Rigid 
%     Objects using Mean Shift, IEEE Conf. Computer Vision and Pattern 
%     Recognition (CVPR'00), Hilton Head Island, South  Carolina, Vol. 2, 
%     142-149, 2000 
% 
%     PETS DATA:
%     http://www-prima.inrialpes.fr/PETS04/caviar_data.html
%
%     MMREAD:
%     http://www.mathworks.com/matlabcentral/fileexchange/loadFile.do?objec
%     tId=8028&objectType=file
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
%          frameNum - a 1x1 scalar indicating which frame number to read.
%
% OUTPUTS:
%          I - the grayscale unit8 image from the video
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [I] = walk1(frameNum)

% location of the video
Video_fileName = ['Walk1.mpg'];

video = mmread(Video_fileName,frameNum);

% convert to grayscale
I = rgb2gray(video.frames(1).cdata);