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
% Description:  getPointsInEllipse.m
%               Given an ellipse centered at y and with a sclae of h and
%               the size of image (ImgSize) this function will return the
%               coordinates of all pixels inside the ellipse as well as the
%               lexographically ordered index of the locations.
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
%          ImgSize {1x2}[rowsize colsize] the size of image frame
%          y {1x2}[row col] matrix containing the location of ellipse center
%
% OUTPUTS:
%          RowCol {nx2}[row col] matrix containing the loc of all points 
%                   in ellipse
%          loc {nx1} vector conatining the lexographical index of all 
%                   points in ellipse
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [RowCol, loc] = getPointsInEllipse(y, h, ImgSize)

% get the meshgrid (all x,y locations) for a rectangle fitting an ellipse
% with major and minor axis of lenght h along x and y axis.
[C R] = meshgrid(-floor((h(2)-1)/2):ceil((h(2)-1)/2), -floor((h(1)-1)/2):ceil((h(1)-1)/2));
C = reshape(C,1,[]);
R = reshape(R,1,[]);

% Calculate the ellipse formula for all points in box
ONE = (R).^2/(h(1)/2)^2 + (C).^2/(h(2)/2)^2;

% Only points with ellipse formula lessthan or equal to 1 are inside
% ellipse
RowCol2(:,1) = R(find(ONE<=1))+y(1);
RowCol2(:,2) = C(find(ONE<=1))+y(2);

% eliminate all points outside image size
index = 1;
for i = 1:size(RowCol2,1)
    if (RowCol2(i,2) > 0 & RowCol2(i,2) <= ImgSize(2) & RowCol2(i,1) > 0 & RowCol2(i,1) <= ImgSize(1))
        RowCol(index,:) = RowCol2(i,:);
        index = index + 1;
    end
end

% convert image coorinates to lexographically ordered index
loc = RowCol(:,1) + (RowCol(:,2)-1)*ImgSize(1);