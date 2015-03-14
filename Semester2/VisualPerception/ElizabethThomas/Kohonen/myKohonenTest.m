function [ testVectorsWithLabels ] = myKohonenTest(maxCluster, inputVectorSize, W, testVectors)
%MYKOHONENTEST Summary of this function goes here
%   Detailed explanation goes here

testVectorsWithLabels = [testVectors zeros(size(testVectors, 1), 1)];

testVectorsCount = size(testVectors, 1);

for ii = 1 : testVectorsCount
    
    eucledianDistances = zeros(maxCluster, 1);
    
    for jj = 1 : maxCluster
        
        for kk = 1 : inputVectorSize
            
            eucledianDistances(jj) = eucledianDistances(jj) + power(W(kk, jj) - testVectors(ii, kk), 2);
            
        end
        
    end
    
    minDistanceIndex = find(eucledianDistances == min(eucledianDistances));
    
    testVectorsWithLabels(ii, end) = minDistanceIndex;
    
end

end

