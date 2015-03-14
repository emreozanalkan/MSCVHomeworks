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
% Description:  Example1.m
%               This is a script illustrating the use of the meer mean
%               shift tracking algorithm.
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
%
% OUTPUTS:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clear all; % closes any lost handels to avi
clc

% algorithm parameters
getImage = @walk1;
h = [25 25];	
y = [168 175];
m = 5;
startFrame = 315;
endFrame = 350;
displayImages = true;

% display the image used to derive the model. Note the image is displayed
% using the specified number of bins.
I = getImage(startFrame);
I_bined = uint8(reshape(binNum(reshape(I,1,[]),m),size(I,1),[]));
figure; imshow(I_bined,[]); hold on;
[RowCol, loc] = getPointsInEllipseBorder(y, h, size(I));
plot(RowCol(:,2),RowCol(:,1),'-','LineWidth',2); plot(y(2),y(1),'.','MarkerSize',5);
title('Binned image used to obtain model q.');
% pause;

% create video. When creating video, regardless of the value of
% displayImages, the images will be displayed.
[ModelLocs] = meerTrack(getImage, y, h, m, startFrame, endFrame, ...
    displayImages,'walk1_tracked.avi',5);

% default frame rate
% [ModelLocs] = meerTrack(getImage, y, h, m, startFrame, endFrame, ...
%     displayImages,'walk1.avi');

% no video will be created
% [ModelLocs] = meerTrack(getImage, y, h, m, startFrame, endFrame, ...
%     displayImages);

% no images will be displayed. No video created.
% [ModelLocs] = meerTrack(getImage, y, h, m, startFrame, endFrame, ...
%     false);