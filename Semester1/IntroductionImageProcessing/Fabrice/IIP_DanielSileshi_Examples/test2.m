close all;
clear;
clc;

f=zeros(30,30);
%f(5:24,13:17)=1; 
f(14:17, 5:25) = 1;
f(5:25,17:19)=1; 

subplot(2, 3, 1);
imshow(f,'InitialMagnification', 'fit')
F=fft2(f); 
F2=abs(F);
 
subplot(2, 3, 2); 
imshow(F2,[],'InitialMagnification','fit') 
F=fft2(f, 256, 256); 
 
F2=abs(F); 
subplot(2, 3, 3);
imshow(F2, []) 

F2=fftshift(F); 
 
F2=abs(F2); 
subplot(2, 3, 4);
imshow(F2,[]) 

F2=log(1+F2); 
subplot(2, 3, 5); 
imshow(F2,[]) 
