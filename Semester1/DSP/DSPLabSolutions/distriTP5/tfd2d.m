% Practical works no 5
clear all;

% Ex. 1 --- 2D frequency
Im=0;
N=64; % image size
T=1;% T corresponds to the length of the signal
% we still use T to recall the signal is periodical from the 
% point of view of the DFT
Ts=T/N; % sampling period
Fs=1/Ts; 
df=Fs/N;% step in frequency (resolution)
% note: df=Fs/N => df=(1/Ts)/N=(N/T)/N=1/T
% the frequency range will be : [-Fs/2:df:Fs/2[ (Fs/2 not inluded
%   due to the representation of the 0 frequency)
% considering the choice for T, the frequency range is
%   [-N/2:1:N/2[, this the usual frequency range for discrete data
Im(N/8:N/4,N/4+1:N/2)=1;
Im(1:N/4,N/2+1:N)=Im;
Im(N/4+1:N/2,:) = Im;
Im(N/2+1:3*N/4,:) = Im(1:N/4,:);
Im(3*N/4+1:N,:) = Im(1:N/4,:);


figure(10), imagesc(Im);
colormap('gray'); title('Image');

tf = fft2(Im)/N/N;% normalization
% Note: fftshift is intended to correctly organize the quadants
%    of the ttf (disorganized by the fast algorithm)
tfs = fftshift(tf);
image_avegare = mean2(Im)
% the 0 frequency <=> average of the image
% Note: seeing N is even, the 0 value induces fs/2 cannot be represented
%  => the 0 frequency is located in N/2+1,N/2+1
central0freq=tfs(N/2+1,N/2+1)
% fft2 produces two images : real and imaginary parts
% locating the 0 frequency en N/2+1, N/2+1, we can graduate the 
%   two axes in frequency : [-N/2:1:N/2[
% each value of tfs(u,v) represents a component having the vertical
%   frequency u and the horizontal frequency v, the amplitude of 
%   this component is given by the modulus value and the phase
%   by the angle value
% note: a real signal/image is coded with negative and positive frequencies
%   because fft (DFT) uses the complex base fo Fourier. It follows
%   the modulus is even and the phase is odd.
figure(11), imagesc(abs(tfs));colormap('gray'); title('modulus')
figure(12), imagesc(angle(tfs)/pi*180); colormap('gray');title('phase');

hsf=0; vsf=0;
% horizontal frequency axis
hsf = tfs(N/2+1,:);
%figure(13), plot(-Fs/2:df:Fs/2-df, abs(hsf));
figure(13), plot(-N/2:N/2-1, abs(hsf));
title('horirontal freq.');
% vertical frequency axis
vsf = tfs(:,N/2+1);
%figure(14), plot(-Fs/2:df:Fs/2-df, abs(vsf));
figure(14), plot(-N/2:1:N/2-1, abs(vsf));
title('vertical freq.');










% Ex. 2 --- reconstruction

%%%%%%%%%%%%%%%%%%%%%%
% DFT of natural images
%%%%%%%%%%%%%%%%%%%%%%
Im = imread('bureau.gif');
figure(20), imagesc(Im); title('Image 1');colormap('gray');
%Im = imread('bureau.gif');
NM = size(Im,1)*size(Im,2);
tf = fft2(Im)/NM;% normalization
tfs = fftshift(tf);
image_avegare = mean2(Im)
% Image are often representation of natural scence containing
%   different objetcs. It follows images contains sharp variation
%   like step functin in an given direction (orthogonal to the edge)
%   Consequently, the DFT will produce a spectrum having a decay
%   in 1/f or 1/n, f or being one of the frequency axes.
figure(21), imagesc(log(abs(tfs)+1)); title('Modulus');
colormap('gray');
figure(22), imagesc(angle(tfs)/pi*180); title('Phase');colormap('gray');

%%%%%%%%%%%%%%%%%%%%%%%%%%
% image reconstruction with the modulus OR the pahse
%%%%%%%%%%%%%%%%%%%%%%%%%%
tfs = NM*tfs;% normalization^-1
%note: below general reconstruction with modulus AND phase
%tfs=abs(tfs).*cos(angle(tfs))+i.*abs(tfs).*sin(angle(tfs)); 

% conversion fourier Image in real+imaginary from modulus
tfsMod = abs(tfs).*cos(0)+i.*abs(tfs).*sin(0); % no phase
% conversion fourier Image in real+imaginary from phase
tfsPh = 1.*cos(angle(tfs))+i.*1.*sin(angle(tfs)); % no modulus
% reconstruction with modulus only
ImrMod = ifft2(fftshift(tfsMod));
% log to compress the amplitude range
figure(23), imagesc(log(abs(real(ImrMod)+1))); 
title('Reconstruction with modulus');
colormap('gray');
% reconstruction with phase only
ImrPh = ifft2(fftshift(tfsPh));
figure(24), imagesc(real(ImrPh));
title('Reconstruction with phase');
colormap('gray');



% merging of two natural (or synthetic) images
Im2 = imread('bureau.gif');
% imresize to be sure the sizes of the two images are the same
Im2=imresize(Im2,[size(Im,1) size(Im,2)]);
figure(25), imagesc(Im2); title('Image 2');colormap('gray');
NM2 = size(Im2,1)*size(Im2,2);
tf2 = fft2(Im2)/NM2;% normalization
tfs2 = fftshift(tf2);

% real and imaginary parts to apply fft2^-1
tfsMod1Ph2 = abs(tfs).*cos(angle(tfs2))+i.*abs(tfs).*sin(angle(tfs2));
tfsMod2Ph1 = abs(tfs2).*cos(angle(tfs))+i.*abs(tfs2).*sin(angle(tfs));
ImrMod1Ph2 = ifft2(fftshift(NM2*tfsMod1Ph2));
figure(26), imagesc(real(ImrMod1Ph2)); title('Modulus 1 et Phase 2');
colormap('gray');
ImrMod2Ph1 = ifft2(fftshift(NM2*tfsMod2Ph1));
figure(27), imagesc(real(ImrMod2Ph1)); title('Modulus 2 et Phase 1');
colormap('gray');










