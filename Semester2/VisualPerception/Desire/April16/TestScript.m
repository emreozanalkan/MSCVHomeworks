close all;
clear all;
clc;
return;

%% Features detection: Run Harris corner detector on the two images cars1 and guard2
% How many corners do you get in each image
close all;
clear all;
clc;

cars1 = imread('matching_data/cars1.tif');
cars2 = imread('matching_data/cars2.tif');
cars_scene = imread('matching_data/cars_scene.tif');
guard2 = imread('matching_data/guard2.tif');


scaleFactor = 1;

cars1 = imresize(cars1, scaleFactor);
guard2 = imresize(guard2, scaleFactor);

cars1Gray = rgb2gray(cars1);
guard2Gray = rgb2gray(guard2);

% cars1Corners = corner(cars1Gray, 'Harris', 10000);
% guard2Corners = corner(guard2Gray, 'Harris', 10000);

% 'MinQuality' ? Minimum accepted quality of corners. Default: 0.01
% 'FilterSize' ? Gaussian filter dimension. Default: 5
cars1HarrisFeatures = detectHarrisFeatures(cars1Gray, 'MinQuality', 0.01, 'FilterSize', 13);
guard2HarrisFeatures = detectHarrisFeatures(guard2Gray, 'MinQuality', 0.01, 'FilterSize', 13);

cars1SURFFeatures = detectSURFFeatures(cars1Gray);
guard2SURFFeatures = detectSURFFeatures(guard2Gray);

cars1MSERFeatures = detectMSERFeatures(cars1Gray);
guard2MSERFeatures = detectMSERFeatures(guard2Gray);


display(strcat('cars1 number of harris features detected: ', num2str(length(cars1HarrisFeatures))));
display(strcat('guard2 number of harris features detected: ', num2str(length(guard2HarrisFeatures))));

display(strcat('cars1 number of SURF features detected: ', num2str(length(cars1SURFFeatures))));
display(strcat('guard2 number of SURF features detected: ', num2str(length(guard2SURFFeatures))));

display(strcat('cars1 number of MSER features detected: ', num2str(length(cars1MSERFeatures))));
display(strcat('guard2 number of MSER features detected: ', num2str(length(guard2MSERFeatures))));

% figure, imshow(cars1);
% hold on;
% plot(cars1Corners(:, 1), cars1Corners(:, 2), '*r');
% 
% figure, imshow(guard2);
% hold on;
% plot(guard2Corners(:, 1), guard2Corners(:, 2), '*b');


% figure, imshow(cars1), hold on, plot(cars1HarrisFeatures.selectStrongest(200));
% figure, imshow(guard2), hold on, plot(guard2HarrisFeatures.selectStrongest(200));

% figure, imshow(cars1), hold on, plot(cars1SURFFeatures.selectStrongest(200));
% figure, imshow(guard2), hold on, plot(guard2SURFFeatures.selectStrongest(200));

figure, imshow(cars1), hold on, plot(cars1MSERFeatures);
figure, imshow(guard2), hold on, plot(guard2MSERFeatures);

%% Features matching: Using detected futures from previous section, find correspoinding points/regions
% How many corners do you get in each image
close all;
clear all;
clc;

cars1 = imread('matching_data/CAR1.tif');
cars2 = imread('matching_data/CAR5.tif');
cars_scene = imread('matching_data/cars_scene.tif');
guard2 = imread('matching_data/guard2.tif');

cars1Gray = rgb2gray(cars1);
cars2Gray = rgb2gray(cars2);
guard2Gray = rgb2gray(guard2);


cars1HarrisFeatures = detectHarrisFeatures(cars1Gray, 'MinQuality', 0.01, 'FilterSize', 13);
guard2HarrisFeatures = detectHarrisFeatures(guard2Gray, 'MinQuality', 0.01, 'FilterSize', 13);

cars1SURFFeatures = detectSURFFeatures(cars1Gray);
cars2SURFFeatures = detectSURFFeatures(cars2Gray);
guard2SURFFeatures = detectSURFFeatures(guard2Gray);

cars1MSERFeatures = detectMSERFeatures(cars1Gray);
guard2MSERFeatures = detectMSERFeatures(guard2Gray);

[featurescars1,   validPointscars1]  = extractFeatures(cars1Gray,  cars1SURFFeatures);
[featurescars2,   validPointscars2]  = extractFeatures(cars2Gray,  cars2SURFFeatures);

indexPairs = matchFeatures(featurescars1, featurescars2);
indexPairs = matchFeatures(featurescars1, featurescars2);

showMatchedFeatures(cars1Gray, cars2Gray, validPointscars1(indexPairs(:, 1)), validPointscars2(indexPairs(:, 2)), 'montage');















