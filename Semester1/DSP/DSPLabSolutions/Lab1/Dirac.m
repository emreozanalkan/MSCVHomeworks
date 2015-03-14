% --- Dirac function ---
% parameter : k -> Dirac(k); N -> length of the discrete signal
function s = Dirac(k, N) % dirac existe en matlab
    if ((k<1) | (k>N))
        disp('!!!! k must be in the range [1,N]');
        s=0;
        return
    end
    s = zeros(1,N);
    s(k) = 1;
end % function dirac
