% sampling effect on noise

clear all
figure(30);
ax=[-5 5 0 0.5]; % for the axis of the distribution randn
%ax=[-0.5 0.5 0 0.1]; % for the axis of the distribution rand

N = 1000000; % or N = 2^nextpow2(1000000) -> fft faster
s=randn(1,1000000); % white noise, gaussian distribution
%s=rand(1,1000000); % white noise, uniform distribution
s=s-mean(s);

h=0;
figure(60), plot(s);
[h, xh]=hist(s,50);
h = h/sum(h)/(xh(2)-xh(1)); 
figure(30), subplot(4,2,1), plot(xh,h, '*-');
axis(ax);
% note : pmf is the probability mass function (for discrete random
%   variable), pdf is the probability density function
%   To obtain the pdf from the pmf (because here we have a continuous
%   random variable: pdf = pmf / dh where dh is the bean step)
title('pdf (histogram)');
fs=10000;
f=fftshift(fft(s));% we can apply the fft on outcomes
df=fs/N;
figure(30), subplot(4,2,2), plot(-fs/2:df:fs/2-df,abs(f));

%figure(50), plot(abs(fft(xcorr(s)))); PSD


% -------- sub-sampling : change of spectrum ---------
sb=0;
sb = s(1:2:end);
Nb=length(sb) 
h=0;
[h, xh]=hist(sb,50);
h = h/sum(h)/(xh(2)-xh(1));
figure(30), subplot(4,2,3), plot(xh,h, '*-');
axis(ax);
title('pdf - sub-sampling');

fsb=fs/2;
f=fftshift(fft(sb));
df=fsb/Nb;
figure(30), subplot(4,2,4), plot(-fsb/2:df:fsb/2-df,abs(f));
% the frequency distribution is modified: range is divided by 2
% the spatial distribution is unchanged


% -------- change of distribution (sin transform)---------
sc=0;
sc = sin(s);
sc=sc-mean(sc);
Nc=length(sc) 
h=0;
[h, xh]=hist(sc,50);
h = h/sum(h);
figure(30), subplot(4,2,5), plot(xh,h, '*-');
axis(ax);
title('pdf - sin transform');

fsc=fs;
f=fftshift(fft(sc));
df=fsc/Nc;
figure(30), subplot(4,2,6), plot(-fsc/2:df:fsc/2-df,abs(f));
% the frequency is unchanged
% the spatial distribution is modified



% -------- filtering : change of spectrum ---------
sf=0;
sf=conv2(s, [1 1]/2, 'same');
sf=sf/max(sf)*max(s); % to conserve approx. the ddp
h=0;
[h, xh]=hist(sf,50);
h = h/sum(h);
figure(30), subplot(4,2,7), plot(xh,h, '*-');
axis(ax);
title('pdf - filtering [1 1]/2');

fsf=fs;
f=fftshift(fft(sf));
df=fsc/Nc;
figure(30), subplot(4,2,8), plot(-fsf/2:df:fsf/2-df,abs(f));
% the frequency distribution is modified (filetring)
% the spatial distribution is unchanged (the gain has been corrected to
%   conserve the same range in amplitude



