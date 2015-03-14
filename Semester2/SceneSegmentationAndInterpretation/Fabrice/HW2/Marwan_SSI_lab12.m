clear all;close all;
%%
norm1 = @(x) (1/sqrt(10*pi)) * exp(-0.5*(x/5).^2);
norm2 = @(x) (1/sqrt(2*pi)) * exp(-0.5*((x-5)).^2);

figure(1);hold on;
xaxis = [-15:0.0001:15];
pxw1 = norm1(xaxis);
pxw2 = norm2(xaxis);
plot(xaxis,pxw1,'r');
plot(xaxis,pxw2,'b');
%hold off;
Prior1 = 0.5; Prior2 = 0.5;
%%
% MAP
if(norm1(3)*Prior1 > norm2(3)*Prior2)
    disp('class 1');
else
    disp('class 2');
end
%%
% ML
% Likelihood ratio
% P(x|w1)/p(x|w2) > P(w2)/P(w1)
likelihood = norm1(3)/norm2(3);
if(likelihood > Prior2/Prior1)
    disp('class 1');
else
    disp('class 2');
end

[row,column,v] = find(diff(sign(pxw1 - pxw2)));
xx = xaxis(column);
yy = pxw1(column);
plot(xx,yy,'go','MarkerSize',10);
hold off;
%%
Prior1 = 0.8; Prior2 = 0.2;
figure(2);hold on;
xaxis = [-15:0.0001:15];
pxw1 = norm1(xaxis);
pxw2 = norm2(xaxis);
plot(xaxis,pxw1*Prior1,'r');
plot(xaxis,pxw2*Prior2,'b');

% MAP
if(norm1(3)*Prior1 > norm2(3)*Prior2)
    disp('class 1');
else
    disp('class 2');
end

% ML
% Likelihood ratio
% P(x|w1)/p(x|w2) > P(w2)/P(w1)
likelihood = norm1(3)/norm2(3);
if(likelihood > Prior2/Prior1)
    disp('class 1');
else
    disp('class 2');
end

%%
a1 = 0; b1 =1; a2 =1 ; b2 = 2;
norm1 = @(x) exp(-abs(x-a1)/b1);
norm2 = @(x) exp(-abs(x-a2)/b2);

figure(3);hold on;
xaxis = [-15:0.01:15];
pxw1 = norm1(xaxis);
pxw2 = norm2(xaxis);
plot(xaxis,pxw1./pxw2,'r');
hold off;

%% Euclidean vs Mahalanobis Distance
clear all;
N = 50;
mu_1 = [1 1]; mu_2 = [4 4];
S1 = [ 0.475  -0.425; -0.425  0.475];
S2 = [1 0; 0 1];
data1 = mgd(N,2,mu_1',S1);

cmu1 = mean(data1')
cS1 = cov(data1')

Z1 = mvnpdf(data1',mu_1,S1);
inc = 0.1;
xrange = [-2 8]; yrange = [-2 8];
[xx,yy] = meshgrid(xrange(1):inc:xrange(2),yrange(1):inc:yrange(2));
zz1 = griddata(data1(1,:),data1(2,:),Z1, xx,yy);

data2 = mgd(N,2,mu_2',S2);

cmu2 = mean(data2')
cS2 = cov(data2')

Z2 = mvnpdf(data2',mu_2,S2);
zz2 = griddata(data2(1,:),data2(2,:),Z2, xx,yy);

figure(33);hold on;
surf(xx,yy,zz1);
surf(xx,yy,zz2);
hold off;
%% Decision Boundary with Euclidean Distance
image_size = size(xx);
xy = [xx(:) yy(:)];
numxypairs = length(xy);
dist = [];
data = cell(2,1);
means = cell(2,1);
data{1} = data1; data{2} = data2;
means{1} = cmu1; means{2} = cmu2;
for ii=1:length(data)
  disttemp = sqrt(sum((xy - repmat(means{ii},[numxypairs 1])).^2, 2));
  dist = [dist disttemp];
end

[m,idx] = min(dist,[],2);
decisionmap = reshape(idx, image_size);

figure(34);hold on;
imagesc(xrange,yrange,decisionmap);
set(gca,'ydir','normal');
cmap = [139/255 0 0; 0 0 128/255];
colormap(cmap);

plot(data1(1,:),data1(2,:),'b.');
plot(data2(1,:),data2(2,:),'r.');
axis([xrange yrange]);
title('Decision Boundary with Euclidean Distance');
hold off;

%% Decision Boundary with Mahalanobis Distance
image_size = size(xx);
xy = [xx(:) yy(:)];
numxypairs = length(xy);
dist = [];
data = cell(2,1); means = cell(2,1); covariances = cell(2,1);
data{1} = data1; data{2} = data2;
means{1} = cmu1; means{2} = cmu2;
covariances{1} = inv(cS1); covariances{2} = inv(cS2);
for ii=1:length(data)
  difference = (xy - repmat(means{ii},[numxypairs 1]));
  disttemp = sqrt(difference * covariances{ii} * difference');
  dist = [dist disttemp];
end

[m,idx] = min(dist,[],2);
decisionmap = reshape(idx, image_size);

figure(35);hold on;
imagesc(xrange,yrange,decisionmap);
set(gca,'ydir','normal');
cmap = [139/255 0 0; 0 0 128/255];
colormap(cmap);

plot(data1(1,:),data1(2,:),'b.');
plot(data2(1,:),data2(2,:),'r.');
axis([xrange yrange]);
title('Decision Boundary with Mahalanobis Distance');
hold off;

%% Naive Bayes Segmentation
training_img = imread('training.tif');
training_vessel = imread('training_vessels.gif');
maskfov = imread('training_mask.gif');

[imgEq,imgLabA,imgLabB,imgG,bkgr,copyimgEq] = preprocessImg(training_img);

Feature_1_p = double(imgEq( training_vessel == 255));%( maskfov == 255 &  training_vessel == 255));
Feature_2_p = double(imgLabA( training_vessel == 255));% .* double(maskfov) .* double(training_vessel);
Feature_3_p = double(imgLabB( training_vessel == 255));% .* double(maskfov) .* double(training_vessel);
Feature_1_n = double(imgEq( maskfov == 255));%( maskfov == 255 &  training_vessel == 255));
Feature_2_n = double(imgLabA( maskfov == 255));% .* double(maskfov) .* double(training_vessel);
Feature_3_n = double(imgLabB( maskfov == 255));% .* double(maskfov) .* double(training_vessel);

figure(11);hold on;
subplot(2,4,1); imshow(training_img);
subplot(2,4,2); imshow(imgEq);
subplot(2,4,6); imhist(imgEq);
subplot(2,4,3); imagesc(imgLabA);
subplot(2,4,7); imhist(imgLabA);
subplot(2,4,4); imagesc(imgLabB);
subplot(2,4,8); imhist(imgLabB);

hold off;
%% Training
%positive = find(Feature_1(training_vessel == 255));
%negative = find(Feature_1(maskfov == 255));

% Training_Feat1 = training_img(:,:,1);
% Training_Feat2 = training_img(:,:,2);
% Training_Feat3 = training_img(:,:,3);
Training_Data = [Feature_1_p Feature_2_p Feature_3_p; Feature_1_n Feature_2_n Feature_3_n];
Training_Data = double(Training_Data);

%Classes(positive) = 1;
%Classes(negative) = 0;
Classes = [ ones(length(Feature_1_p),1); zeros(length(Feature_1_n),1) ];

% total_count = size(Feature_1,1)*size(Feature_1,2);
% P_positive = length(positive)/total_count;
% P_negative = length(negative)/total_count;

NB = NaiveBayes.fit(Training_Data, Classes);

%% Testing
test_img = imread('test.tif');
test_mask = imread('test_mask.gif');
% Test_Feat1 = test_img(:,:,1);
% Test_Feat2 = test_img(:,:,2);
% Test_Feat3 = test_img(:,:,3);
imgSeg = zeros(size(test_img));
maskimg = find(test_mask == 255);
[imgEq,imgLabA,imgLabB,imgG,bkgr,copyimgEq] = preprocessImg(test_img);
Test_Feat1 = double(imgEq( test_mask == 255)); % .* double(test_mask);
Test_Feat2 = double(imgLabA( test_mask == 255)); % .* double(test_mask);
Test_Feat3 = double(imgLabB( test_mask == 255));% .* double(test_mask);
Test_Data = [Test_Feat1(:) Test_Feat2(:) Test_Feat3(:)];
Test_Data = double(Test_Data);
Test_Classes = NB.predict(Test_Data);

segId = maskimg(Test_Classes == 1); % mark the data indentified as the blood vessels as 1
imgSeg(segId) = 255; % set those pixel to red
figure;imshow(test_img);
figure;imshow(imgSeg);

% Test_Result = reshape(Test_Classes,size(test_mask));
% figure(12);hold on;
% imshow(Test_Result); title('Classified Test Results');
% hold off;
%%










