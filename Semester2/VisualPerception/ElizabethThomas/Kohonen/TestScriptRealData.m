% Kohonen Self-Organizing Maps
clc;

alpha = 0.6;

alphaDecayRate = 0.5;

%learningRadius = 0;

maxCluster = 2;

iterationCount = 10;

inputVectorSize = 650;

W = rand(inputVectorSize, maxCluster);

control = load('control.txt');
patient = load('patient.txt');
test_four = load('test_four.txt');

trainingVectors = [patient; control];
testVectors = test_four;


Wnew = myKohonenTraining(alpha, alphaDecayRate, maxCluster, inputVectorSize, W, trainingVectors, iterationCount);


testVectorsWithLabels = myKohonenTest(maxCluster, inputVectorSize, Wnew, testVectors);


%display(testVectorsWithLabels);

%display(testVectorsWithLabels(:, end));