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
% Description:  getWeights.m
%               Find the weights (w) for each pixels given the pixels bin 
%               number (binNums) and the model pdf (q) and the current 
%               frame pdf p_y0.
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
%          q  {1xm} the model histogram
%          p_y0 {1xm} the target histogram at current possition on current
%                     frame
%          binNums {nx1} bin number between 0 and m-1
%
% OUTPUTS:
%          w {nx1} the weights associated with each pixel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [w] = getWeights(q, p_y0, binNums)

count = 0;
for i = 1:numel(binNums)
    % display warning and pause for user intervention when dividing by zero
    % is detected.
    if (p_y0(binNums(i)+1) == 0)
        disp('Warning Divide by zero detected because p_y0 = 0');
%         count = count + 1
%         i
%         pause
    end
    
    % calculate weight
    w(i,1) = sqrt(q(binNums(i)+1)/(p_y0(binNums(i)+1)+eps));
end