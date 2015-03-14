function [ uN, vN ] = update( u1, v1, u2, v2 )
%UPDATE Summary of this function goes here
%   Detailed explanation goes here

uN = ((v1 * u2) + (v2 * u1)) / (v1 + v2);

vN = ((v1 * v2) / (v1 + v2));

end

