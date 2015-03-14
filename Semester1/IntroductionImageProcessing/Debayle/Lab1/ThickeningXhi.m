function [ B ] = ThickeningXhi( A, T1, T2 )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

B = (A | HitORMiss(imcomplement(A), T1, T2));


end

