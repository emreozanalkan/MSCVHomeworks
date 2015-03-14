function [out]=PSN(orgimg,mimg)
% PSN is PSNR of Image Peak signal to noise ratio.
% orgimg    = Orignal Image
% mimg      = Modified Image
% Size of two images must be same.

% Code Developed BY : Suraj Kamya
% kamyasuraj@yahoo.com

orgimg =im2double(orgimg);
mimg   =im2double(mimg);

Mse=sum(sum((orgimg-mimg).^2))/(numel(orgimg)); %Mse = Mean square Error
out=10*log10(1/Mse);