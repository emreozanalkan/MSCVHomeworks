% step function: k correspond to the true abscissa from 1 to N
function s = step(k, N)
    if ((k<2) | (k>N))
        disp('!!!! k must be in the range [1,N]');
        s=0;
        return
    end
    s(1:k-1) = zeros(1,k-1);
    s(k:N) = ones(1,N-k+1);
end % function step
 
