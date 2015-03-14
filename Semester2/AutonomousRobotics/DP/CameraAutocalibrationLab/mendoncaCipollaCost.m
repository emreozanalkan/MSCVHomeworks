function [ C ] = mendoncaCipollaCost( X, Fs )
%MENDONCACIPOLLACOST Summary of this function goes here
%   Detailed explanation goes here

% X(1) = alfa_u
% X(2) = alfa_v
% X(3) = gamma
% X(4) = u_0
% X(5) = v_0

% Hint: For Mandonca&Cipolla, consider all the weight w_ij = 1

% SVD = and get S, first 2 sigma
% S = [sigma_1   0         0;
%      0         sigma_2   0;
%      0         0         0];
%
% Essential = A' * Fs * A;

A = [X(1)   X(3)   X(4);
    0       X(2)   X(5);
    0       0      1];

E = zeros(3, 3, 10, 10);

C = zeros(1, 10);

for ii = 1 : 10
    
    for jj = 1 : 10
        
        if ii == jj
            continue;
        end
        
        E(:, :, ii, jj) = A' * Fs(:, :, ii, jj) * A;
        
        [~, S, ~] = svd(E(:, :, ii, jj));
        
        C(ii) =  C(ii) + ((S(1, 1) - S(2, 2)) / S(2, 2));
        
    end
    
end

C = sum(C(:));


end

