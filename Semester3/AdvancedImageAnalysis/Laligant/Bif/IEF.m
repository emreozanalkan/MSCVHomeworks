function [out]=IEF(orgimg,nimg,dimg)
% IEF is Image enhancement factor.
% orgimg    = Orignal Image
% nimg      = Noisy Image
% dimg      = Denoised Image
% Size of three images must be same.

% Code Developed BY : Suraj Kamya
% kamyasuraj@yahoo.com

orgimg =im2double(orgimg); 
nimg   =im2double(nimg);
dimg   =im2double(dimg);

out=sum(sum((nimg-orgimg).^2))/(sum(sum((dimg-orgimg).^2)));