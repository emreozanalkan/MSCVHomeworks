% exercise 2 : stability of systems

addpath('/Users/olivier/M/Cours/MSCV/M1TS/0TP/TP1_SignalSysteme');

N=10;
%Q1
f=step(4,N); % example of signal
F = prim(f); 
figure(10), plot(1:N, f, 'b*-', 1:N, F, 'r*-');
title('primite of the step function');
% the primitive operator as a system is unstable:
%  the ouput increases towards infinity while the input is bounded

%Q2 impulse response of the system accumulator/primitive
s=Dirac(4,N);
S = prim(s);
figure(11), plot(1:N, s, 'b*-', 1:N, S, 'r*-');
title('impulse response of the primitve operator');
% as the time increases, the sum of the coeff of the impulse
%  resp. increases (-> inifinity): the system is not stable

% Q3 
x=Dirac(4,N);
y(1)=0;
for k=2:N
    y(k)=x(k)+2*y(k-1);
end
figure(12), plot(1:N, x, 'b*-', 1:N, y, 'r*-');
title('impulse response y_k=x_k+2x_{k-1}');
% sum of the |coeff| of the impulse rep. is infinite when
%  the time -> infinity (system unstable)

% Q4 
x=Dirac(4,N);
y(1)=0;
for k=2:N
    y(k)=x(k)+y(k-1)/3;
end
figure(13), plot(1:N, x, 'b*-', 1:N, y, 'r*-');
title('impulse response y_k=x_k+x_{k-1}/3');
% sum of the |coeff| of the impulse rep. is bounded 
%  -> system stable !
y(4:N)
% we extract the first (strongest) coefficients (h truncated because the support is
% infinite)
h=[1.0000    0.3333    0.1111    0.0370]
% -> y[k] = h*x[k]
































