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
% Description:  getScaleChange.m
%               Determine the scale change in the ellipse.
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
%          y1 {1x2}[row col] location of targe in frame F_I
%          hPrev {1x2}[rowScale colScale] the scale of the object
%          q  {1xm} the model histogram
%          F_I The frame image (gray scale uint8) in which to search for
%              the model
%          m The number of bins in the histogram
%
% OUTPUTS:
%          hNew The new estimated scale of the target in frame F_I.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [hNew] = getScaleChange(y1, hPrev, q, F_I, m)

ImgSize = size(F_I);

delta = 0.1;

% test three scales
h0 = (1+delta)*hPrev;
h1 = hPrev;
h2 = (1-delta)*hPrev;

% get pixel locations inside ellipse
[y1_RowCol, y1_loc] = getPointsInEllipse(y1, h0, ImgSize);
% get histogram p_y0 of model
[p_y1, binNums] = probProfile(h0, y1, y1_RowCol, F_I(y1_loc), m);
% get Bhattacharyya coeffitient
b0 = sum(sqrt(p_y1.*q));

% get pixel locations inside ellipse
[y1_RowCol, y1_loc] = getPointsInEllipse(y1, h1, ImgSize);
% get histogram p_y0 of model
[p_y1, binNums] = probProfile(h1, y1, y1_RowCol, F_I(y1_loc), m);
% get Bhattacharyya coeffitient
b1 = sum(sqrt(p_y1.*q));

% get pixel locations inside ellipse
[y1_RowCol, y1_loc] = getPointsInEllipse(y1, h2, ImgSize);
% get histogram p_y0 of model
[p_y1, binNums] = probProfile(h2, y1, y1_RowCol, F_I(y1_loc), m);
% get Bhattacharyya coeffitient
b2 = sum(sqrt(p_y1.*q));

if b0 >= b1 && b0 >= b2
    hOpt = h0;
elseif b1 > b0 && b1 >= b2
    hOpt = h1;
else
    hOpt = h2;
end

gamma = 0.3;
hNew = gamma*hOpt + (1-gamma)*hPrev;

% disp(['h0 ' num2str(h0) ' h1/p ' num2str(h1) ' h2 ' num2str(h2) ' hOpt ' num2str(hOpt) ' hNew ' num2str(hNew)]);

hNew = round(hNew);