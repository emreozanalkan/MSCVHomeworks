function randomSignal()


N=1000;
% an observation of the (gaussian if randn) random process
%x = randn(1,N);
x = rand(1,N);

% distribution
[h, xh] = hist(x,30);
dh = xh(2)-xh(1);
h = h/(sum(h)*dh);
figure(1), plot(xh,h);
%axis([0 1 0 500]); % for rand

% correlation
xx = xcorr(x, 'biased');
figure(2), plot(xx);


% gaussian model (randn)
% g(x) = 1/std/sqrt(2pi)*exp(-x^2/2/std^2)
m = mean(x);
std = sqrt(var(x));
figure(1), hold on 
plot(xh, g(xh, m, std), 'r*-');
hold off

% localisation -> synchronization
s1=round(rand(1,50));
s2=round(rand(1,50));
s3=round(rand(1,50)); 
s(101:150)=s1;
s(191:240)=s2;
s(301:350)=s3;
%sum(s1)
xc1=xcorr(s,s1); 
figure(3), plot(xc1);
xc2=xcorr(s,s2); 
figure(4), plot(xc2);
xc3=xcorr(s,s3); 
figure(5), plot(xc3);
% %xc=xcorr([s1 s1 s1], s1, 'none');
% xc=xcorr(s1, s1, 'none'); % biased ou coeff ou none
% figure(3), plot(xc);
% %xc=xcorr([s1 s1 s1],s2, 'none');
% xc=xcorr(s1,s2, 'biased');
% figure(4), plot(xc);


% observation-detection of the impulse response
% input signal : x (random signal)
% system : h
h=[18 8 5 2 1];
% output : y
y = conv(x, h, 'same');
xyc = xcorr(x,y, 'biased');
figure(6), plot(xyc, '*-');



% distribution and power spectral density
v= rand(1,N);
% distribution
[h, xv] = hist(v,30);
dv = xv(2)-xv(1);
h = h/(sum(h)*dv);
figure(7), plot(xv,h);

% power spectral density
fv = fftshift(fft(v));
dv = fv.*conj(fv)/length(fv);

fx = fftshift(fft(x));
dx = fx.*conj(fx)/length(fx);

figure(8), plot(dv); % not a white noise !
figure(9), plot(dx);














end % function randomSignal


%  normale law
function y= g(x, m, std)
    y = 1/std/sqrt(2*pi)*exp(-(x-m).^2/2/std^2);
end % function 





























