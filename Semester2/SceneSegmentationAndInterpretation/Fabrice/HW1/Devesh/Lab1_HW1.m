% Patter Recognition: Lab1

%1. Bayesian methods for two-class, one-dimensional problem

% (b) Conditional densities
interv=0.001; % interval between each sample
lb=-100; ub=100; % lower and upper bounds for samples
samples=[lb:interv:ub];
mean1=0; mean2=2;
var1=5; var2=1;
std1=sqrt(var1); std2=sqrt(var2);

d1=GaussP(samples,mean1,std1);
d2=GaussP(samples,mean2,std2);

plot(samples,d1,'b-',samples,d2,'r-')
title('Conditional Densities')
axis([-8 8 0 0.5]) %selected for display purposes
legend('Class 1','Class 2');

% (d) Classification

Pw1=0.5; Pw2=1-Pw1; % Prior

% ML approach
x=3;

Pml1=GaussP(x,mean1,std1); %or d1(1031) for sample at +3 (samples at 1,11..)
Pml2=GaussP(x,mean2,std2);

figure,
plot(samples,d1,'b-',samples,d2,'r-')
title('ML Approach')
hold on
plot(x,Pml1,'-s');
plot(x,Pml2,'-rs');
axis([-8 8 0 0.5]) %selected for display purposes
legend('Class 1','Class 2');

display('By the ML approach, choose class: ')
if Pml1>Pml2
    display('w1')
else
    display('w2')
end

% MAP Approach
Post1=d1*Pw1;
Post2=d2*Pw2;

xpos=1+abs(x-lb)/interv;
Pmap1=Post1(xpos);
Pmap2=Post2(xpos);

figure,
plot(samples,Post1,'b-',samples,Post2,'r-')
title('MAP Approach')
hold on
plot(x,Pmap1,'-s');
plot(x,Pmap2,'-rs');
axis([-8 8 0 0.5/2]) %selected for display purposes
legend('Class 1','Class 2');


display('By the MAP approach, choose class: ')

if Pmap1>Pmap2
    display('w1')
else
    display('w2')
end

% Result: As expected, the decision from ML and MAP are the same since the
% priors are equal


% (e) 

Pw11=0.8; Pw22=1-Pw11;

% ML approach
% The results would remin the same as before, since the conditional density
% did not change, and the Maximum Likelihood does not take the prior into
% account.

% MAP Approach
Post11=d1*Pw11;
Post22=d2*Pw22;

xpos=1+abs(x-lb)/interv;
Pmap11=Post11(xpos);
Pmap22=Post22(xpos);

figure,
plot(samples,Post11,'b-',samples,Post22,'r-')
title('MAP Approach')
hold on
plot(x,Pmap11,'-s');
plot(x,Pmap22,'-rs');
axis([-8 8 0 max([Post11,Post22])]) %selected max for the y upper bound
legend('Class 1','Class 2');


display('By the MAP approach, choose class: ')

if Pmap11>Pmap22
    display('w1')
else
    display('w2')
end

% 2. 

a1=0;b1=1;a2=1;b2=2;
ex1=-abs(samples-a1)/b1;
ex2=-abs(samples-a2)/b2;

Lratio=exp(ex1)./exp(ex2);

figure, plot(samples,Lratio)
title('Likelihood Ratio')

