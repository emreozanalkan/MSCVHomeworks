function [ W ] = myKohonenTraining(alpha, alphaDecayRate, maxCluster, inputVectorSize, W, trainingVectors, iterationCount)
%MYKOHONENTRAINING Summary of this function goes here
%   Detailed explanation goes here


trainingVectorsCount = size(trainingVectors, 1);

for nn = 1 : iterationCount
    
    for ii = 1 : trainingVectorsCount
        
        eucledianDistances = zeros(maxCluster, 1);
        
        for jj = 1 : maxCluster
            
            for kk = 1 : inputVectorSize
                
                eucledianDistances(jj) = eucledianDistances(jj) + power(W(kk, jj) - trainingVectors(ii, kk), 2);
                
            end
            
        end
        
        minDistanceIndex = find(eucledianDistances == min(eucledianDistances));
        
        for mm = 1 : inputVectorSize
            
            W(mm, minDistanceIndex) = W(mm, minDistanceIndex) + alpha * (trainingVectors(ii, mm) - W(mm, minDistanceIndex));
            
        end
        
    end
    
    alpha = alpha * alphaDecayRate;
    
end

end

