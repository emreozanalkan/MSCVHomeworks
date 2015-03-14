function [ B ] = MorphSkeleton( A, radius )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

AErode = imerode(A);
AOpenErode = imopen(AErode);

for ii = 1:100
    ball = strel('disk', ii);
    Image = AErode - AOpenErode;
    
    
end




end

