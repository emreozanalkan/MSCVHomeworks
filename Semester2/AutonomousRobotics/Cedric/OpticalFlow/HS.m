function [u, v] = HS(im1, im2, alpha, ite)
% Horn-Schunck optical flow method 
% Horn, B.K.P., and Schunck, B.G., Determining Optical Flow, AI(17), No.
% 1-3, August 1981, pp. 185-203 http://dspace.mit.edu/handle/1721.1/6337
%
% Usage:
% [u, v] = HS(im1, im2, alpha, ite, uInitial, vInitial, displayFlow)
%
% -im1,im2 : 
% -alpha : 
% -ite : 

%
% Author: Mohd Kharbat at Cranfield Defence and Security



if nargin<3
    alpha=1;
end
if nargin<4
    ite=100;
end

uInitial = zeros(size(im1(:,:,1)));
vInitial = zeros(size(im2(:,:,1)));

 
if size(size(im1),2)==3
    im1=rgb2gray(im1);
end
if size(size(im2),2)==3
    im2=rgb2gray(im2);
end
im1=double(im1);
im2=double(im2);

im1=smoothImg(im1,1);
im2=smoothImg(im2,1);

tic;

u = uInitial;
v = vInitial;

[fx, fy, ft] = computeDerivatives(im1, im2);


kernel_1=[1/12 1/6 1/12;1/6 0 1/6;1/12 1/6 1/12];


for i=1:ite
    uAvg=conv2(u,kernel_1,'same');
    vAvg=conv2(v,kernel_1,'same');

    u= uAvg - ( fx .* ( ( fx .* uAvg ) + ( fy .* vAvg ) + ft ) ) ./ ( alpha^2 + fx.^2 + fy.^2); 
    v= vAvg - ( fy .* ( ( fx .* uAvg ) + ( fy .* vAvg ) + ft ) ) ./ ( alpha^2 + fx.^2 + fy.^2);
end

u(isnan(u))=0;
v(isnan(v))=0;

plotFlow(u, v, im1, 5, 5); 
