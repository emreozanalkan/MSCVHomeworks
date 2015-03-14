im = imread('einstein.jpg');
%sigd = 
%[out]=bif(im,sigd,sigr,n)

out = bif(im, 3, 0.5, 0.5);
% bif   = bilateral filter
% im    = input image
% sigd  = domain parameter for spatial kernel
% sigr  = range parmeter for intensity kernel
% n     = noise intensity
% out   = output image