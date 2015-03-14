clc
%read all the images
image_zero = imread('0.png');
I_0 = double(image_zero);

image_45 = imread('45.png');
I_45 = double(image_45);

image_90 = imread('90.png');
I_90 = double(image_90);
%============= Wolff's method ==============
%intiallize the out put images to zero first
I = zeros(size(I_0));
Phi = zeros(size(I_0));
Ro = zeros(size(I_0));

for i=1:size(I_0,1)
    for j=1:size(I_0,2)
        for k=1:size(I_0,3)
            I(i,j,k) = I_0(i,j,k) + I_90(i,j,k);
            Phi(i,j,k) = (((I(i,j,k)-2*I_45(i,j,k))/(I(i,j,k)-2*I_90(i,j,k))));
            Ro(i,j,k) = (sqrt(((I(i,j,k)-2*I_45(i,j,k)).^2) + ((I(i,j,k)-2*I_90(i,j,k)).^2))/I(i,j,k));
        end
    end
end

%  I = I_0 + I_90;
%  Phi =( I-2.*I_45)./(I-2.*I_90);
%  Ro = (sqrt(((I-2.*I_45).^2 + I-2.*I_90.^2)./I));

%create the 3D color image by concating the above three results and
%display the image
% Image_out = uint8(cat(3,atan(Phi),Ro,I));%this image is hsv image 
% 
% figure,subplot(131), imshow(image_zero);title('Image at zero degree of pol');
% subplot(132),imshow(image_45);title('Image at 45 degree of pol');
% subplot(133),imshow(image_90);title('Image at 90 degree of pol');
% 
%  figure (2),subplot(131), imshow(uint8(I));title('Intensity');
%  subplot(132),imshow(uint8((Phi)));title('Angle of polarization');
%  subplot(133),imshow(uint8(Ro*100));title('Degree of Polarization');
%  figure(3), imshow(Image_out);colormap(hsv);title('out put image color image');
% % 
%%%=========Least Mean Square Method=======
Im(1,:,:) = double(imread('0.png'));
Im(2,:,:) = double(imread('45.png'));
Im(3,:,:) = double(imread('90.png'));
Im(4,:,:) = double(imread('135.png'));
Im(5,:,:) = double(imread('180.png'));
Im(6,:,:)= double(imread('225.png'));
Im(7,:,:)= double(imread('270.png'));
Im(8,:,:) = double(imread('315.png'));

[m n] = size(Im_0);


Im_out = zeros(m,n,3);
for i=1:m
for j=1:n
A = [];
Y = [];
for k=1:8 
    
A = [ A; 1 cos(2*k*45) sin(2*k*45) ];
Y =  [Y ;Im(k,i,j)];

end

X = 2 .* (inv(A' * A)) * (A' * Y);
I = X(1);
Ro = sqrt(X(2).^2 + X(3).^2) ./ X(1);
Phi = atan(X(3) ./ X(2));
Im_out(i,j,:) = [ I Ro Phi];
end
end

figure(6);subplot(131); subimage(Im_out(:,:,2));  title('degree of polarization');
subplot(132); subimage(Im_out(:,:,3));  title('angle of polarization');
subplot(133); subimage((uint8(Im_out(:,:,1)))); title('intensity');


% I = S0;
% Ro = sqrt(S1.^2 + S2.^2)./S0;
% Phi = 0.5*angle(S1+S2*i);
% 
% figure(4),imshow([I Ro Phi]);title('I Ro Fi using LLS method');
% 
% yaxis=[Im_0(162,520) Im_45(162,520) Im_90(162,520) Im_135(162,520) Im_180(162,520) Im_225(162,520) Im_270(162,520) Im_315(162,520)];
% xaxis = [0 45 90 135 180 225 270 315];
% figure(5);plot(xaxis,yaxis,'--rs','LineWidth',2,...
%                 'MarkerEdgeColor','k',...
%                 'MarkerFaceColor','g',...
%                 'MarkerSize',10);
% title('sinusoidal relationship');
% xlabel('Angles');
% ylabel('ROI');



% % Diffuse Specular reflection
% parell = imread('Metal_0V.png');
% Orto = imread('Metal_1V.png');
% 
% Total_Intensity = parell + Orto;
% Contrast = parell - Orto;
% Contrast_ratio = Contrast./Total_Intensity;
% 
% 
% figure(), imagesc(uint8(Total_Intensity));colormap(gray); title('Total Intensity');
% figure(7), imagesc(uint8(Contrast));colormap(gray);title('Image Contrast');
% figure(8), imagesc(uint8(Contrast_ratio));colormap(gray);title('Contrast ration');
% 
