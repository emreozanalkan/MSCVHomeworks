clc;
close all;
clear all;

%% 1. Bayesian methods
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%//(a)
figure(1),title('HW1 (a) (b) (c) (d)'),
hold on;
n = 10;
step = 0.01;
x = -n:step:n;
myGaussian = @(x,mu,sigma)(1/(sigma*sqrt(2*pi))*exp(-(x-mu)^2/(2*sigma^2)));
%class 1
mu1 = 0;
sigma1 = sqrt(5);
class_1 = 1/sqrt(10*pi).*exp(-x.^2/10);
%class 2
mu2 = 2;
sigma2 = 1;
class_2 = 1/sqrt(2*pi).*exp(-(x-2).^2/2);

%//(b)
class1plot = plot(x,class_1);
class2plot = plot(x,class_2);
set(class1plot,'Color','blue');
set(class2plot,'Color','green');

%//(c)
likelihood = class_1./class_2;
%plot(x,likelihood,'--','Color','y');

%//(d)
x = 3;
p_w1 = 0.5;
p_w2 = 0.5;
%MAP
if(class_1((x+n)/step)*p_w1 < class_2((x+n)/step)*p_w2)
    text(x,class_2((x+n)/step),'\leftarrow MAP class 2: \mu = 2 \sigma^2 = 1','HorizontalAlignment','left');
else
    text(x,class_1((x+n)/step),'\leftarrow MAP class 1: \mu = 0 \sigma^2 = 5','HorizontalAlignment','left');
end
%ML
if(class_1((x+n)/step) < class_2((x+n)/step))
    text(x,class_2((x+n)/step),'ML class 2: \mu = 2 \sigma^2 = 1 \rightarrow ','HorizontalAlignment','right');
else
    text(x,class_1((x+n)/step),'ML class 1: \mu = 0 \sigma^2 = 5 \rightarrow ','HorizontalAlignment','right');
end
%decision region and overall probability of error
[MAP_regions,MAP_error] = DecisionRegions(class_1,class_2,p_w1,p_w2,'MAP');
xlabel(['MAP overall probability of error: ',num2str(MAP_error*step)]);
[ML_regions,ML_error] = DecisionRegions(class_1,class_2,p_w1,p_w2,'ML');
%doundaries
start = 0;
stop = 0;
boundaries = [];
for i = 2:length(MAP_regions)
    if (abs(MAP_regions(i) - MAP_regions(i-1)))
        start = (i-1)*step-n-0.1;
        stop = i*step-n+0.1;
        boundary = FindBoundary(mu1,sigma1,mu2,sigma2,start,stop);
        stem(boundary,max(max(class_1),max(class_2)),'Color','red','Marker','^');grid on;
        text(boundary,max(max(class_1),max(class_2)),'boundary \rightarrow ','HorizontalAlignment','right');
        boundaries = [boundaries,boundary];
    end
end

%//(e)
figure(2),title('HW1 (e)'),
hold on;
x = -n:step:n;
p_w1 = 0.8;
p_w2 = 0.2;
class1plot = plot(x,p_w1.*class_1);
class2plot = plot(x,p_w2.*class_2);
set(class1plot,'Color','blue');
set(class2plot,'Color','green');
%MAP
x = 3;
if(class_1((x+n)/step)*p_w1 < class_2((x+n)/step)*p_w2)
    text(x,p_w2*class_2((x+n)/step),'\leftarrow MAP class 2: \mu = 2 \sigma^2 = 1 p(w) = 0.2','HorizontalAlignment','left');
else
    text(x,p_w1*class_1((x+n)/step),'\leftarrow MAP class 1: \mu = 0 \sigma^2 = 5 p(w) = 0.8','HorizontalAlignment','left');
end
%ML
if(class_1((x+n)/step) < class_2((x+n)/step))
    text(x,p_w2*class_2((x+n)/step),'ML class 2: \mu = 2 \sigma^2 = 1 \rightarrow ','HorizontalAlignment','right');
else
    text(x,p_w1*class_1((x+n)/step),'ML class 1: \mu = 0 \sigma^2 = 5 \rightarrow ','HorizontalAlignment','right');
end
%decision region and overall probability of error
[MAP_regions,MAP_error] = DecisionRegions(class_1,class_2,p_w1,p_w2,'MAP');
xlabel(['MAP overall probability of error: ',num2str(MAP_error*step)]);
[ML_regions,ML_error] = DecisionRegions(class_1,class_2,p_w1,p_w2,'ML');
%doundaries
start = 0;
stop = 0;
boundaries = [];
for i = 2:length(MAP_regions)
    if (abs(MAP_regions(i) - MAP_regions(i-1)))
        start = (i-1)*step-n-0.1;
        stop = i*step-n+0.1;
        boundary = FindBoundary(mu1,sigma1,mu2,sigma2,start,stop);
        stem(boundary,max(max(class_1),max(class_2)),'Color','red','Marker','^');grid on;
        text(boundary,max(max(class_1),max(class_2)),'boundary \rightarrow ','HorizontalAlignment','right');
        boundaries = [boundaries,boundary];
    end
end
%loss value can be any other rather than zero-one but zero-one is the
%minimum overall probability of error
