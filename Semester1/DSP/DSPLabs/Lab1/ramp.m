function [ r ] = ramp( k, slope, N )
%RAMP Ramp Function
%   Detailed explanation goes here

if ((k<1) | (k>N))
    disp('!!!! k must be in the range [1,N]');
    r = 0;
    return
end

r(1:k) = zeros(1, k);
r(k + 1:N) = slope * (1:N-k);

end

