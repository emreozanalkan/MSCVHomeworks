function [u, v] = LucasKanade(im1, im2, windowSize)
%LucasKanade : Original lucas kanade algorithm, without pyramids (only 1 level);

% If first image is colored, we convert to gray scale
if size(size(im1), 2) == 3
    im1 = rgb2gray(im1);
end

% If second image is colored, we convert to gray scale
if size(size(im2), 2) == 3
    im2 = rgb2gray(im2);
end

% We convert images to double
im1 = double(im1);
im2 = double(im2);

% We compute the derivaton on x, y and time, with 2x2 mask
[fx, fy, ft] = computeDerivatives(im1, im2);

% We initializing u and v with size of the images
u = zeros(size(im1));
v = zeros(size(im2));

% We define half window size to use in loop not to go out of indexes or
% iterate less on right corners.
halfWindow = floor(windowSize / 2);


for i = halfWindow + 1 : size(fx, 1) - halfWindow
    
   for j = halfWindow + 1 : size(fx, 2) - halfWindow
       
      % We get derivatives within the window
      curFx = fx(i - halfWindow : i + halfWindow, j - halfWindow : j + halfWindow);
      curFy = fy(i - halfWindow : i + halfWindow, j - halfWindow : j + halfWindow);
      curFt = ft(i - halfWindow : i + halfWindow, j - halfWindow : j + halfWindow);
      
      % We transpose the derivative values
      curFx = curFx';
      curFy = curFy';
      curFt = curFt';

      % We vectorize the derivative values
      curFx = curFx(:);
      curFy = curFy(:);
      curFt = -curFt(:);
      
      % We put x and y derivative values into columns in one matirx
      A = [curFx curFy];
      
      % Lucas Kanade formulation to find u and v
      U = pinv(A' * A) * A' * curFt;
      
      u(i, j) = U(1);
      v(i, j) = U(2);
      
   end
   
end

% We set elements of u and v to 0 who has NaN value
u(isnan(u)) = 0;
v(isnan(v)) = 0;

% We plot our arrows into image using u and v.
plotFlow(u, v, im1, 5, 5);
