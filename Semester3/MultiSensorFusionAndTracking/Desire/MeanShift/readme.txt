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
% Description:  
%     The provided code constitues the Mean Shift tracking algorithm as
%     implemented in Matlab. Run the Example1.m filte to see the algorithm
%     work on the sample video provided from the PETS 2004 dataset.
%     NOTE: This is by no means an optimal implementaion, there are many
%           redundent calculations that can be eliminated. 
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
%
% Required Library/Code
%     To run the walk1.m file (needed when running Example1.m) the mmread
%     functions by Micah Richert is need. The mmread and associated files,
%     used to read video and audio files, can be obtained from MathWorks 
%     file exchange. 
%     http://www.mathworks.com/matlabcentral/fileexchange/loadFile.do?objectId=8028&objectType=file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%