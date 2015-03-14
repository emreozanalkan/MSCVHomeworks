function [ B ] = ThinningTheta( A, T1, T2 )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%B = (A \ HitORMiss(A, T1, T2));

B = (A - HitORMiss(A, T1, T2));

%B = imcomplement(ThickeningXhi(imcomplement(A), T1, T2));


end

