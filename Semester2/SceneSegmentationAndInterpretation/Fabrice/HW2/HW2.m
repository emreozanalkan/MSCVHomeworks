close all;
clear all;
clc;
return;

%% 1. Euclidean distance vs. Mahalanobis distance

S1 = [0.475, -0.425;
     -0.425, 0.475];
 
S2 = [1 0; 
      0 1];
  
u1 = [1 1]';

u2 = [4 4]';

% 50 SAMPLES
samples1 = mgd(50, 2, u1, S1);
samples2 = mgd(50, 2, u2, S2);

figure;
subplot(2, 2, 1); plot(samples1); title('Samples 1 with 50');
subplot(2, 2, 2); plot(samples2); title('Samples 2 with 50');


s1M = mean(samples1);
s1C = cov(samples1);

display('Means of first distribution(first 5 of 50):');
display(s1M(1:5)');

display('Covariances of first distribution(first 5 of 50):');
display(s1C(1:5)');

s2M = mean(samples2);
s2C = cov(samples2);

display('Means of second distribution(first 5 of 50):');
display(s2M(1:5)');
display('Covariances of second distribution(first 5 of 50):');
display(s2C(1:5)');

% 1000 SAMPLES
samples1 = mgd(1000, 2, u1, S1);
samples2 = mgd(1000, 2, u2, S2);

subplot(2, 2, 3); plot(samples1); title('Samples 1 with 1000');
subplot(2, 2, 4); plot(samples2); title('Samples 2 with 1000');


s1M = mean(samples1);
s1C = cov(samples1);

display('Means of first distribution(first 5 of 1000):');
display(s1M(1:5)');

display('Covariances of first distribution(first 5 of 1000):');
display(s1C(1:5)');


s2M = mean(samples2);
s2C = cov(samples2);

display('Means of second distribution(first 5 of 1000):');
display(s2M(1:5)');
display('Covariances of second distribution(first 5 of 10000):');
display(s2C(1:5)');

%% NaiveBayes for segmentation
training = imread('training.tif');
vessel = imread('training_vessels.gif');
mask = imread('training_mask.gif');

% figure;
% subplot(1, 3, 1); imshow(training); title('Training');
% subplot(1, 3, 2); imshow(vessel);   title('Vessel');
% subplot(1, 3, 3); imshow(mask);     title('Mask');

[imgEq, imgLabA, imgLabB] = preprocessImg(training);

% figure;
% subplot(1, 3, 1); imshow(imgEq);       title('imgEq');
% subplot(1, 3, 2); imshow(imgLabA, []); title('imgLabA');
% subplot(1, 3, 3); imshow(imgLabB, []); title('imgLabB');

posSample1 = double(imgEq(find(vessel == 255)));
posSample2 = double(imgLabA(find(vessel == 255)));
posSample3 = double(imgLabB(find(vessel == 255)));

negSample1 = double(imgEq(find(mask == 255)));
negSample2 = double(imgLabA(find(mask == 255)));
negSample3 = double(imgLabB(find(mask == 255)));

figure; title('Images and Feature Histograms');
subplot(3, 3, 1); imshow(imgEq);       title('imgEq');
subplot(3, 3, 2); imshow(imgLabA, []); title('imgLabA');
subplot(3, 3, 3); imshow(imgLabB, []); title('imgLabB');
subplot(3, 3, 4); hist(posSample1);    title('Positive Sample 1');
subplot(3, 3, 5); hist(posSample2);    title('Positive Sample 2');
subplot(3, 3, 6); hist(posSample3);    title('Positive Sample 3');
subplot(3, 3, 7); hist(negSample1);    title('Negative Sample 1');
subplot(3, 3, 8); hist(negSample2);    title('Negative Sample 2');
subplot(3, 3, 9); hist(negSample3);    title('Negative Sample 3');

data = [posSample1, posSample2, posSample3;
        negSample1, negSample2, negSample3];

data = double(data);


classes = [ones(size(posSample1, 1), 1);
           zeros(size(negSample1, 1), 1)];


% Train naive Bayes classifier
NBModel = NaiveBayes.fit(data, classes);


%% Testing

testImage = imread('test.tif');
testMask = imread('test_mask.gif');

segmentedImage = zeros(size(testImage));

maskImage = find(testMask == 255);

[imgEq, imgLabA, imgLabB] = preprocessImg(testImage);

% negative samples
testSample1 = double(imgEq(find(testMask == 255)));
testSample2 = double(imgLabA(find(testMask == 255)));
testSample3 = double(imgLabB(find(testMask == 255)));

testingData = [testSample1, testSample2, testSample3];
testingData = double(testingData);

testClasses = NBModel.predict(testingData);

segmentedIDs = maskImage(testClasses == 1);
segmentedImage(segmentedIDs) = 255;

figure;
subplot(1, 2, 1); imshow(testImage);      title('Test Image');
subplot(1, 2, 2); imshow(segmentedImage); title('Segmented Image');

