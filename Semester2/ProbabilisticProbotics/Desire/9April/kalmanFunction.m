function [ hN ] = kalmanFunction( xN, hN_1, N )
%KALMANFUNCTION Summary of this function goes here
%   Detailed explanation goes here

hN = hN_1 + (1/N) * (xN - hN_1);

end

