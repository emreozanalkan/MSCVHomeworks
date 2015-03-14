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
% Description:  meanShift.m
%               This will perform the meanShift algorithm to determine the 
%               location of target in the current frame.
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
%          y0 {1x2}[row col] initial guess of target location in frame F_I
%          hCurr {1x2}[rowScale colScale] the scale of the object
%          q  {1xm} the model histogram
%          F_I The frame image (gray scale uint8) in which to search for
%              the model
%          m The number of bins in the histogram
%
% OUTPUTS:
%          y1 {1x2}[row col] the acutal location of the model as determined
%             by the mean shift algorithm.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [y1] = meanShift(y0, hCurr, q, F_I, m)

ImgSize = size(F_I);

% ****************************
% * do MeanShift Algorithm   *
% ****************************

% set seeProbFigures to 1 to see the figure of the p_y0 prob dist slowly
% become the q dist
seeProbFigures = 0;
if (seeProbFigures == 1)
    f = figure;
end

continueWithMeanShift = true;
numItt = 0;
while (continueWithMeanShift == true & numItt < 20)

    % ****************************
    % * get p_y0                 *
    % ****************************

    % get pixel locations inside ellipse
    [y0_RowCol, y0_loc] = getPointsInEllipse(y0, hCurr, ImgSize);
    % get histogram p_y0 of model
    [p_y0, binNums] = probProfile(hCurr, y0, y0_RowCol, F_I(y0_loc), m);
    
    if (seeProbFigures == 1)
        plot(q,'r'); hold on;
        plot(p_y0,'b'); hold off;
        pause
    end

    % ****************************
    % * get weights              *
    % ****************************
    [w] = getWeights(q, p_y0, binNums);
    sum_w = sum(w);

    % ****************************
    % * get y1                   *
    % ****************************

    y1 = [sum(y0_RowCol(:,1).*w)/sum_w sum(y0_RowCol(:,2).*w) / sum_w];
    
    % Meer paper calls for the bellow line. I got better results without
    % the average.
%     y1 = 0.5*(y0+y1);

    % ****************************
    % * check stoping condition  *
    % ****************************
    
    [y1_RowCol, y1_loc] = getPointsInEllipse(round(y1), hCurr, ImgSize);
    [p_y1, binNums] = probProfile(hCurr, round(y1), y1_RowCol, F_I(y1_loc), m);

    % if the Bhattacharyya coefficient goes down stop itteration
    % if it doesn't go down keep going
    if (sum(sqrt(p_y1.*q)) > sum(sqrt(p_y0.*q)))
        % Make sure that there is a change in location of more than 0.5
        % pixels. We are not interpolating between pixel locations.
        if (max(abs(y0-y1)) > 0.5)
            y0 = round(y1);
            continueWithMeanShift = true;
        else
            y1 = round(y1);
            continueWithMeanShift = false;
        end
    else
        % if the Bhattacharyya coefficient is smaller for y1 than y0 keep
        % y0 as the tracked location
        y1 = y0;
        % stop mean shift itteration
        continueWithMeanShift = false;
    end

    numItt = numItt + 1;
end
y1 = round(y1);

if (seeProbFigures == 1)
    close(f)
end