clear all

% Question 1
sigma1 = [0.475 -0.425;-0.425 0.475];
sigma2 = [1 0;0 1];
u1 = [1 1]';
u2 = [4 4]';
% lets generate 50 samples now from each distribution
samples1 =mgd(50,2,u1,sigma1);
samples2 =mgd(50,2,u2,sigma2);
figure(1),
plot(samples1);
title('samples distribution 1')
figure(2),
plot(samples2);
title('samples distribution 2')
% lets now estimate mean and covariance
disp('mean of distrib 1 estimate')
mean(samples1)
disp('actual mean of distr 1')
u1
disp('estimated covariance of distr 1')
cov(samples1(1,:),samples1(2,:))
disp('actual covariance of distribution 1')
sigma1

% now for second distribution
disp('mean of distrib 2 estimate')
mean(samples2)
disp('actual mean of distr 2')
u2
disp('estimated covariance of distr 2')
cov(samples2(1,:),samples2(2,:))
disp('actual covariance of distribution 2')
sigma2
% it can be seen that there is lot of estimation error 
% lets augment the number of samples to 1000
samples1 =mgd(1000,2,u1,sigma1);
samples2 =mgd(1000,2,u2,sigma2);

figure(1),
plot(samples1);
title('samples distribution 1')
figure(2),
plot(samples2);
title('samples distribution 2')
% lets now estimate mean and covariance
disp('mean of distrib 1 estimate')
mean(samples1)
disp('actual mean of distr 1')
u1
disp('estimated covariance of distr 1')
cov(samples1(1,:),samples1(2,:))
disp('actual covariance of distribution 1')
sigma1

% now for second distribution
disp('mean of distrib 2 estimate')
mean(samples2)
disp('actual mean of distr 2')
u2
disp('estimated covariance of distr 2')
cov(samples2(1,:),samples2(2,:))
disp('actual covariance of distribution 2')
sigma2
% it can be seen that error has been significantly decreased 
estimatedmean1 = mean(samples1);
estimatedmean2 = mean(samples2);
% to do calcualting z value an dploting then measuring distance in 2d
% feature space and plot again to find class and also with manhalobis
% distance

%% Question 2 Naive Bayes 
trainingimage = imread('training.tif');
maskvessel = imread('training_mask.gif');
vesselimage = imread('training_vessels.gif');
% subplot(2,4,1),
% imshow(trainingimage)
%vesselimage = im2bw(vesselimage,0.5);
% now preprocessing training image
[imageG,imgLaba,imgLabb] = preprocessingImg(trainingimage);
imageG = double(imageG);
imgLaba = double(imgLaba);
imgLabb = double(imgLabb);
% subplot(2,4,2),
% imshow(imageG,[])
% subplot(2,4,3),
% imshow(imgLaba,[])
% subplot(2,4,4),
% imshow(imgLabb,[])

% Lets build Image vessels mask as it can be seen that training mask image
% selects the overall lobe circular of eye and training vessels selct
% vessels inside that circular region. As given our vessels inside circular
% lobe are positive features and everything else negative. Sop lets make
% Vessel image by combining both mask and vessel training
vesselmaksimage = (maskvessel/2) + (vesselimage/2);
figure(110),
imshow(vesselmaksimage);
%% Now we will apply mask to get positive features from all spaces whcih represent our features

% lets apply mask
%lets make our vessel mask logical first so we can directly access the
%positive features form alll spaces there
logiccalvesselmake = (vesselmaksimage == 255); % as in our mask 255 represent vessels
pos_feat_imG = imageG(logiccalvesselmake);
pos_feat_imgLaba = imgLaba(logiccalvesselmake);
pos_feat_imgLabb = imgLabb(logiccalvesselmake);
% now we have posiive features of all features
figure(112),
% Lets Plot Histogram of these features
subplot(1,3,1)
hist(double(pos_feat_imG))
title('Positive feature imG')
subplot(1,3,2)
hist(double(pos_feat_imgLaba))
title('Positive feature imlabA')
subplot(1,3,3)
hist(double(pos_feat_imgLabb))
title('Positive feature imlabb')

% now lets calculate mean and standard deviation of these posiitive
% features extracted above independently as we have to input it to our
% classifier
pos_feat_imG_mean = mean(pos_feat_imG);
pos_feat_imG_std = std(pos_feat_imG);
pos_feat_imgLaba_mean = mean(pos_feat_imgLaba);
pos_feat_imgLaba_std = std(pos_feat_imgLaba);
pos_feat_imgLabb_mean = mean(pos_feat_imgLabb);
pos_feat_imgLabb_std = std(pos_feat_imgLabb);
%% Now we will Find Negative Features
% if we see our Vessel mask image we created at start negative features are
% all other than vessels and in that image they are equal to 128 inside
% circlelob
logiccalvesselmake_neg = (vesselmaksimage == 128); % as in our mask 255 represent vessels
neg_feat_imG = imageG(logiccalvesselmake);
neg_feat_imgLaba = imgLaba(logiccalvesselmake);
neg_feat_imgLabb = imgLabb(logiccalvesselmake);
% now we have neg features of all features
% Lets Plot Histogram of these features
figure(113),
subplot(1,3,1)
hist(double(neg_feat_imG))
title('neg feature imG')
subplot(1,3,2)
hist(double(neg_feat_imgLaba))
title('neg feature imlabA')
subplot(1,3,3)
hist(double(neg_feat_imgLabb))
title('neg feature imlabb')
% now lets Augment our Parametrs to use with Our Naive Bayes
% help from Abinash and http://www.alceufc.com/2013/09/texture-classification.html
% http://www.mathworks.fr/fr/help/stats/fitnaivebayes.html
% and Matlab Help

positivefeed = [pos_feat_imG pos_feat_imgLaba pos_feat_imgLabb];
negativefeed = [neg_feat_imG neg_feat_imgLaba neg_feat_imgLabb];
trainfeed = [positivefeed ; negativefeed];
trainClassfinal = [ones(size(positivefeed,1),1);zeros(size(negativefeed,1),1)]; % labels for class
myclassifier = NaiveBayes.fit(trainfeed, trainClassfinal); %Naive Bays Model created

%% Testing Phase
% Now we have to test our classifier so we will first read it than extract
% its features similarly as we did while trainig and then feed them to
% classifier and it will return class labels

TestImage = imread('test.tif');
classiifed_image = zeros(size(TestImage));  % to save segmentation result

% now we will read test mask and it can be seen that it has circular lob
% thats why while inoputing negative features to our Classifier we do not
% take into acount pixels outside circular lobe %%%%

imageTestMask = imread('test_mask.gif');
[imgG_Test, imgLaba_test, imgLabb_test] = preprocessingImg(TestImage);
% conversion to double
imgG_Test = double(imgG_Test);
imgLaba_test = double(imgLaba_test);
imgLabb_test = double(imgLabb_test);
maskId = find(imageTestMask ==255); % this will use to keep original pixel values in tesxt after claassification
% test vessel mask creation
logical_test_mask = imageTestMask == 255;
% Extracting Features 
test_imgG_Test= imgG_Test(logical_test_mask);
test_imgLaba_test = imgLaba_test(logical_test_mask);
test_imgLabb_test = imgLabb_test(logical_test_mask);
% Pakiaging them so that we can input them to our CLassifier
testfeatureset = [test_imgG_Test test_imgLaba_test test_imgLabb_test];
% Now we  will Enetr this testing feature set to Classifier
classified_postive_set = myclassifier.predict(testfeatureset);
segId = maskId(classified_postive_set == 1); 
classiifed_image(segId) = 255; % Changing color to make them visible
figure,
imshow(TestImage);
title('test Image')
figure,
imshow(classiifed_image,[]);
title('segmented Image')