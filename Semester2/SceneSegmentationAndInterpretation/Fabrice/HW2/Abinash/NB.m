
clear all;
close all;
clc;
imgIn = imread('training.tif');
imgMask = imread('training_mask.gif');
imgVes = imread('training_vessels.gif');
[imgEq, imgLabA, imgLabB] = preprocessImg(imgIn);

imgVes = imgVes + imgMask/2; 
figure;imshow(imgIn); % input Image
figure;imshow(mat2gray(imgVes)); % Image showing regions

feEqPos = double(imgEq(imgVes == 255));
feLabAPos = double(imgLabA(imgVes == 255));
feLabBPos = double(imgLabB(imgVes == 255));

figure;hist(double(feEqPos));
figure;hist(double(feLabAPos));
figure;hist(double(feLabBPos));

eqMeanPos = mean(feEqPos);
eqSSPos = std(feEqPos);
labAMeanPos = mean(feLabAPos);
labASDPos = std(feLabAPos);
labBMeanPos = mean(feLabBPos);
labBSDPos = std(feLabBPos);

feEqNeg = double(imgEq(imgVes == 128));
feLabANeg = double(imgLabA(imgVes == 128));
feLabBNeg = double(imgLabB(imgVes == 128));
figure;hist(double(feEqNeg));
figure;hist(double(feLabANeg));
figure;hist(double(feLabBNeg));
eqMeanNeg = mean(feEqNeg);
eqSSNeg = std(feEqNeg);
labAMeanNeg = mean(feLabANeg);
labASDNeg = std(feLabANeg);
labBMeanNeg = mean(feLabBNeg);
labBSDNeg = std(feLabBNeg);
neg = [feEqNeg feLabBNeg feLabBNeg];
pos = [feEqPos feLabBPos feLabBPos];
train = [pos ; neg];
trainClass = [ones(size(pos,1),1);zeros(size(neg,1),1)];
size(train);
size(trainClass);
nb = NaiveBayes.fit(train, trainClass);

imgTest = imread('test.tif');
imgSeg = zeros(size(imgTest));
imgTestMask = imread('test_mask.gif');
[imgEqT, imgLabAT, imgLabBT] = preprocessImg(imgTest);
maskId = find(imgTestMask ==255); 
testEq = double(imgEqT(imgTestMask == 255));
testLabA = double(imgLabAT(imgTestMask == 255));
testLabB = double(imgLabBT(imgTestMask == 255));
testing = [testEq testLabA testLabB];

y = nb.predict(testing);
segId = maskId(y == 1); % mark the data indentified as the blood vessels as 1
imgSeg(segId) = 255; % set those pixel to red
figure;imshow(imgTest);
figure;imshow(imgSeg);
