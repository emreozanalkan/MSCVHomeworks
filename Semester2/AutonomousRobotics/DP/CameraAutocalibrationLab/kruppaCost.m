function [ C ] = kruppaCost( X, Fs )
%KRUPPACOST Summary of this function goes here
%   Detailed explanation goes here

% X(1) = alfa_u
% X(2) = alfa_v
% X(3) = gamma
% X(4) = u_0
% X(5) = v_0

A = [X(1) X(3) X(4);
    0    X(2) X(5);
    0    0    1];

w_inv = A * A';

E = zeros(3, 3, 10, 10);

%C = zeros(1, 10);
C = 0;

for ii = 1 : 10
    
    for jj = 1 : 10
        
        if ii == jj
            continue;
        end
        
        %         E(:, :, ii, jj) = A' * Fs(:, :, ii, jj) * A;
        %         
        %         %[~, S, ~] = svd(E(:, :, ii, jj));
        %         C(ii) = C(ii) + norm(((Fs(:, :, ii, jj) * w_inv * Fs(:, :, ii, jj)') / norm(Fs(:, :, ii, jj) * w_inv * Fs(:, :, ii, jj)', 'fro')) - ...
        %         ((E(:, :, jj, ii) * w_inv * E(:, :, jj, ii)') / norm(E(:, :, jj, ii) * w_inv * E(:, :, jj, ii)' ,'fro') ), 'fro');
        %         %C(ii) =  C(ii) + ((S(1, 1) - S(2, 2)) / S(2, 2));
        
        
        
        % Abinash's way instead of longer equation
        currFS = Fs(:, :, ii, jj);
        ce = null(currFS');
        F = currFS * w_inv * currFS';
        F = F / norm(F, 'fro');
        currE = [0 -ce(3) ce(2); ce(3) 0 -ce(1); -ce(2) ce(1) 0];
        E = currE * w_inv * currE';
        E = E / norm(E, 'fro');
        tempC = F - E;
        C = C + norm(tempC,'fro');
        % Abinash's way
        
    end
    
end

end