function [ s ] = step( k, N )
%STEP Step Function
%   1 if k >= 0
%   0 elsewhere

if(k < 2 || k > N)
    disp('k must be in this range: 2 <= k <= N');
    s = 0;
    return;
end

s(1:k-1) = zeros(1, k-1);
s(k:N) = ones(1, N - k + 1);

end

