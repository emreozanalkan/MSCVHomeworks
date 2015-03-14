close all
clear all
image=imread('lena.jpg');
image=imnoise(image,'gaussian');
[row col d]=size(image);
if d>2
image=rgb2gray(image);
end
% subplot(1,2,1)
figure (1);
imshow(image)
title('Input Image');
% image=double(image)/255;
w=9; % window size
sigma_d=10; % Playes prominent role in smoothing
sigma_r=30;
[x y]=meshgrid(-w:w,-w:w);
Domain_fil=exp(-(x.^2+y.^2)/(2*sigma_d^2)); % Domain filter  
[r c]=size(image);
output=zeros(size(image));
for i=1:r
    for j=1:c
        imin=max(i-w,1);
        imax=min(i+w,r);
        jmin=max(j-w,1);
        jmax=min(j+w,c);
        I=image(imin:imax,jmin:jmax);
        Range_fil=exp(-double(I-image(i,j)).^2/(2*sigma_r^2)); % Range filter
        F=Range_fil.*Domain_fil((imin:imax)-i+w+1,(jmin:jmax)-j+w+1); 
        Fnorm=sum(F(:));
        output(i,j)=sum(sum(F.*double(I)))/Fnorm;
    end
end
% subplot(1,2,2);
figure (2);
imshow(output,[])
title('d=1;r=30');

