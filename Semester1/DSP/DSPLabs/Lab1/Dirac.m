function dirac = Dirac( k, N )
%DIRAC Dirac function
%   1 if k = 0
%   0 elsewhere

if(k < 1 || k > N)
    disp('k must be in this range: 1 <= k <= N');
    dirac = 0;
    return;
end

dirac = zeros(1, N);
dirac(k) = 1;

end

