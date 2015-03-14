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
% Description:  meerTrack.m
%               Perform the mean shift tracking for a given image sequence.
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
%          getImage Handle to a function with prototype
%                   [I] = getImage(currFrameNum). That is given a frame
%                   number the function will return the image of that frame
%                   as a grayscale uint8 image.
%          h {1x2}[hrow hcol] the scale of ellipse in the row and col 
%                             direction
%          y {1x2}[row col] matrix containing the location of ellipse
%                           center
%          m The number of bins to use in the histogram.
%          startFrame The starting frame number, to be sent to getImage.
%          endFrame The ending frame number.
%          displayImages When true will show a figure with tracked images.
%          movieFileName When sent it will save the tracked results as this
%                        avi. Make sure avi extention is present. The movie
%                        is UNCOMPRESSED AVI.
%          FramePerSec The fps for avi. Default is 2 if this parameter is
%                      not sent in.
%
% OUTPUTS:
%          ModelLocs {nx2}[row col] location of the model from startFrame
%                                   to endFrame
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ModelLocs] = meerTrack(getImage, y, h, m, startFrame, endFrame, ...
    displayImages, movieFileName,FramePerSec)

if nargin <= 7
    makeMovie = false;
else
    makeMovie = true;
    if (nargin <=8)
        FramePerSec = 2;
    end
end

% set the current frame number to start frame number
currFrameNum = startFrame;

% get the image by calling getImage function handle
I = getImage(currFrameNum);

% get model pdf
[q] = getModel(I, y, h, m);

if (makeMovie == true)
    fig=figure;
    set(fig,'DoubleBuffer','on');
    mov = avifile(movieFileName,'compression','none','fps',FramePerSec)
elseif (displayImages == true)
    fig = figure;
end

if (makeMovie == true || displayImages == true)
    % get points in ellipse
    [RowCol, loc] = getPointsInEllipseBorder(y, h, size(I));
    imshow(I); hold on; plot(RowCol(:,2),RowCol(:,1),'-','LineWidth',2); plot(y(2),y(1),'.','MarkerSize',5);
end

if makeMovie == true
    F = getframe(gca);
    mov = addframe(mov,F);
elseif (displayImages == true)
    pause(0.1);
end

ModelLocs(1,:) = y;
index = 2;
y1 = y;
hPrev = h;
hCurr = h;
currFrameNum = currFrameNum + 1;
while (currFrameNum <= endFrame)
    
    % load next frame by calling getImage function handle    
    F_I = getImage(currFrameNum);
    currFrameNum = currFrameNum + 1;
    
    % get size of frame F_I
    ImgSize = size(F_I);
    
    % find the location of model in current frame using mean shift
    [y1] = meanShift(y1, hCurr, q, F_I, m);
    
    % The scale change function has been removed. It is not working as
    % expected. There seems to be a problem with the value of gamma when
    % tracking a small ellipse
    
    % find the new scale given the old scale hCurr
%     [hCurr] = getScaleChange(y1, hCurr, q, F_I, m);
    
    % save location
    ModelLocs(index,:) = y1;
    index = index + 1;
    
    if (makeMovie == true || displayImages == true)
        [RowCol, loc] = getPointsInEllipseBorder(y1, hCurr, size(F_I));
        imshow(F_I); hold on; plot(RowCol(:,2),RowCol(:,1),'-','LineWidth',2); plot(y1(2),y1(1),'.','MarkerSize',5);
    end
    
    if makeMovie == true
        F = getframe(gca);
        mov = addframe(mov,F);
    elseif (displayImages == true)
        pause(0.1);
    end
end

if makeMovie == true
    mov = close(mov);
end