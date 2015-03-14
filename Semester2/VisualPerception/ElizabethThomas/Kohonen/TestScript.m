% Kohonen Self-Organizing Maps
clc;

alpha = 0.6;

alphaDecayRate = 0.5;

%learningRadius = 0;

maxCluster = 2;

iterationCount = 1;

inputVectorSize = 4;

%W = rand(inputVectorSize, maxCluster);

W = [.2, .8;
     .6, .4;
     .5, .7;
     .9, .3];
 
%trainingVectors = round(rand(4, inputVectorSize));
 
trainingVectors = [1, 1, 0, 0;
                   1, 0, 0, 0;
                   0, 0, 0, 1;
                   0, 0, 1, 1];

Wnew = myKohonenTraining(alpha, alphaDecayRate, maxCluster, inputVectorSize, W, trainingVectors, iterationCount);


testVectors = [0,  0,  0, .9;
               0,  0, .8, .9;
              .7,  0,  0,  0;
              .7, .9,  0,  0];


testVectorsWithLabels = myKohonenTest(maxCluster, inputVectorSize, Wnew, testVectors);


%display(testVectorsWithLabels);

%display(testVectorsWithLabels(:, end));
