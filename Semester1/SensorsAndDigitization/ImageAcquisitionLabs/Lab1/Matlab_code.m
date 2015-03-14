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
Im_0 = double(imread('0.png'));
Im_45 = double(imread('45.png'));
Im_90 = double(imread('90.png'));
Im_135 = double(imread('135.png'));
Im_180 = double(imread('180.png'));
Im_225= double(imread('225.png'));
Im_270= double(imread('270.png'));
Im_315 = double(imread('315.png'));
% calcultion of stocks vecor parametres
S0 = Im_0+Im_90;
S1 = Im_0-Im_90;
S2 = Im_45-Im_135;

figure(2); imshow([uint8(S0) uint8(S1) uint8(S2*25)]);title('S0 S1 S2');

[m n] = size(Im_0);


M = n*m;
P1 = zeros(1,M);
P2 = zeros(1,M);
P3 = zeros(1,M);
P4 = zeros(1,M);
P5 = zeros(1,M);
P6 = zeros(1,M);
P7 = zeros(1,M);
P8 = zeros(1,M);
for j = 1:M
    P1(j) = 1/2*(S0(j) + S1(j)*cos(2*0) + S2(j)*sin(2*0));
    P2(j) = 1/2*(S0(j) + S1(j)*cos(2*45) + S2(j)*sin(2*45));
    P3(j) = 1/2*(S0(j) + S1(j)*cos(2*90) + S2(j)*sin(2*90));
    P4(j) = 1/2*(S0(j) + S1(j)*cos(2*135) + S2(j)*sin(2*135));
    P5(j) = 1/2*(S0(j) + S1(j)*cos(2*180) + S2(j)*sin(2*180));
    P6(j) = 1/2*(S0(j) + S1(j)*cos(2*210) + S2(j)*sin(2*210));
    P7(j) = 1/2*(S0(j) + S1(j)*cos(2*270) + S2(j)*sin(2*270));
    P8(j) = 1/2*(S0(j) + S1(j)*cos(2*315) + S2(j)*sin(2*315));
end
Y = [P1;P2;P3;P4;P5;P6;P7;P8];



I = S0;
Ro = sqrt(S1.^2 + S2.^2)./S0;
Phi = 0.5*angle(S1+S2*i);
Image_out = uint8(cat(3,atan(Phi),Ro,I));
% figure(3);subplot(131),imshow(I/255);title('Intensity');
% subplot(132),imshow(Ro);title('Degree of polarization');
% subplot(133),imshow(Phi*10);title('Angle of polarization');


%figure(4); imshow([uint8(I) uint8(Ro*255) uint8(Phi*255)]);title('I Ro Fi using LLS method');
figure(4),imshow([uint8(I) uint8(Ro*255) uint8(Phi*255)]);title('I Ro Fi using LLS method');

figure(5), imshow(Image_out);colormap(hsv);title('Out put image using LLC method');

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
