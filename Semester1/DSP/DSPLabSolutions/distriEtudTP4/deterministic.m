% influence of the sampling on deterministic signals
clear all;
f=1000;
NT=6;
Np=50;
s=0;
s = sinus(f, 0, NT, 'N', Np); % NT can be non-integer
figure(32), subplot(2,1,1), plot(s, '*-');

N = length(s);
sf=fftshift(fft(s));
fs = 1/((1/f)*NT/N)
df=fs/N;
subplot(2,1,2), plot(-fs/2:df:fs/2-df,abs(sf), '*-');
ch=sprintf('sampling frequency %f', fs);
title(ch);
% if NT is integer => one component at -f and +f
% if NT is not integer, the sinuso?d is a "different" signal and its
%  periodicity correspond to its length => fondamental + harmonics


% % square signal
% % do not use the matlab square function (irregular pattern)
sc = Square(NT, Np);
figure(33), subplot(2,1,1), plot(sc, '*-');
N = length(sc);
sf=fftshift(fft(sc));
fs = 1/((1/f)*NT/N)
df=fs/N;
subplot(2,1,2), plot(-fs/2:df:fs/2-df,abs(sf), '*-');
ch=sprintf('sampling frequency %f', fs);
title(ch);
% Comparison to the Fourier series:
%  continuous square signal ->
%  sin(wt)-1/3sin(3wt)+1/5sin(5wt)-1/7sin(7wt)...
% In the fft: same frequencies but limited to fs/2 because this signal is
%  defined in the discrete domain


% sound signal
fSampRecord = 10000; % Hz
nBitsRecord = 16;
nChannelsRecord = 1;
deviceRecord = -1; %default
fSampPlay = 5000; % Hz
r = audiorecorder(fSampRecord, nBitsRecord, nChannelsRecord, deviceRecord); % RTC: 3400Hz, GSM:4kHz
record(r);
ch=sprintf(' <<< recording during 3s at frequency %5.0f Hz >>>', fSampRecord); disp(ch)
pause(3); %3 secondes
stop(r); % stop recording
disp('-> playback !');
play(r); % sampling rate cannot be changed in the record
pause(4);
p = audioplayer(r); % create a player from the record
set(p, 'SampleRate', fSampPlay); % new sampling rate
ch=sprintf('-> playing at frequency %5.0f Hz', fSampPlay);disp(ch);
play(p);
% for small fs, deformation of the voice (lack of high frequencies)
% if fs for playing is different : change of speed of the message

