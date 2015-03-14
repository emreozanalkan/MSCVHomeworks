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

% Setting the arguments left empty
if nargin < 3
    alpha = 1;
    ite = 100;
elseif nargin < 4
    ite = 100;
end

% We initializing u and v with size of the images
uInitial = zeros(size(im1(:, :, 1)));
vInitial = zeros(size(im2(:, :, 1)));

% If first image is colored, we convert to gray scale
if size(im1, 3) == 3
    im1 = rgb2gray(im1);
end
% If second image is colored, we convert to gray scale
if size(im2, 3) == 3
    im2 = rgb2gray(im2);
end

% We convert images to double
im1 = double(im1);
im2 = double(im2);

% We smooth the images for better results with reducing sharp corners
im1 = smoothImg(im1, 1);
im2 = smoothImg(im2, 1);

tic;

% We let u and v equal the uInitial and vInitial we initialzed with zeros
% as size of the images
u = uInitial;
v = vInitial;

% We compute the derivaton on x, y and time, with 2x2 mask
[fx, fy, ft] = computeDerivatives(im1, im2);

% We define our kernel, sum to 1, to convolve our u and v
kernel_1 = [1/12 1/6 1/12; 1/6 0 1/6; 1/12 1/6 1/12];

for i = 1:ite
    
    % We convolve u and v with our kernel
    uAvg = conv2(u, kernel_1, 'same');
    vAvg = conv2(v, kernel_1, 'same');

    % We find u and v with using uAvg and vAvg, also usin the weighted derivative of
    % the two images
    u = uAvg - ( fx .* ( ( fx .* uAvg ) + ( fy .* vAvg ) + ft ) ) ./ ( alpha^2 + fx.^2 + fy.^2);
    v = vAvg - ( fy .* ( ( fx .* uAvg ) + ( fy .* vAvg ) + ft ) ) ./ ( alpha^2 + fx.^2 + fy.^2);
    
end

% We set elements of u and v to 0 who has NaN value
u(isnan(u)) = 0;
v(isnan(v)) = 0;

% We plot our arrows into image using u and v.
plotFlow(u, v, im1, 5, 5);
