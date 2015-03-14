A=double(imread('academy.jpg'));
A=A/255;
w=5; sigma_d=10; sigma_r=30;
figure(1);
imshow(A);
% Implements bilateral filter for color images.
% Convert input sRGB image to CIELab color space
choice=input('Enter 1 for CIE_Lab,2 for HSV ---> ');
switch(choice)
    case 1
colorTransform = makecform('srgb2lab','AdaptedWhitePoint',whitepoint('d65'));
A = applycform(A, colorTransform);
    case 2
        A=rgb2hsv(A);
    otherwise
        display('Run program again');
end
% Pre-compute Gaussian domain weights.
[X,Y] = meshgrid(-w:w,-w:w);
G = exp(-(X.^2+Y.^2)/(2*sigma_d^2));

% Rescale range variance (using maximum luminance).
sigma_r = 100*sigma_r;
% Apply bilateral filter.
dim = size(A);
B = zeros(dim);
for i = 1:dim(1)
   for j = 1:dim(2)
      
         % Extract local region.
         iMin = max(i-w,1);
         iMax = min(i+w,dim(1));
         jMin = max(j-w,1);
         jMax = min(j+w,dim(2));
         I = A(iMin:iMax,jMin:jMax,:);
      
         % Compute Gaussian range weights.
         dL = I(:,:,1)-A(i,j,1); 
         da = I(:,:,2)-A(i,j,2); 
         db = I(:,:,3)-A(i,j,3); 
         H = exp(-(dL.^2+da.^2+db.^2)/(2*sigma_r^2));
      
         % Calculate bilateral filter response.
         F = H.*G((iMin:iMax)-i+w+1,(jMin:jMax)-j+w+1);
         norm_F = sum(F(:));
         B(i,j,1) = sum(sum(F.*I(:,:,1)))/norm_F;
         B(i,j,2) = sum(sum(F.*I(:,:,2)))/norm_F;
         B(i,j,3) = sum(sum(F.*I(:,:,3)))/norm_F;
                
   end
end
figure(2);
imshow(B);
% B=uint8(B);
% Convert filtered image back to sRGB color space.
if (choice==1)
colorTransform1 = makecform('lab2srgb');
   B = applycform(B,colorTransform1);
elseif (choice==2)
    B=hsv2rgb(B);
else
    disp('Run Program Again')
end
figure(3);
imshow(B);
title('d=10;r=30');