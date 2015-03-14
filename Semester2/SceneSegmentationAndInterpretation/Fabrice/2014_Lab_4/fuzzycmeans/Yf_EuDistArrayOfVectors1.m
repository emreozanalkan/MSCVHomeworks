function dist = Yf_EuDistArrayOfVectors1 (V, X)
%Yf_EuDistArrayOfVectors1: Finds Euclidean norm between vectors in two array.
%
%   V: Array 1, (c by p) (holds c vector each one with length p)
%   X: Array 2, (n by p) (holds n vector each one with length p)
%
%   dist: (c by n), dist(i,k) = norm (Xk - Vi)
%
%   Mahdi Amiri, June 15, 2003
%   http://yashil.20m.com/

c = size(V, 1);
p = size(V, 2);
n = size(X, 1);

dist = zeros(c, n);

% fill the output matrix

if p > 1,
    for k = 1:c,
	dist(k, :) = sqrt( sum(((X-ones(n, 1)*V(k, :)).^2)') );
    end
else	% 1-D data
    for k = 1:c,
	dist(k, :) = abs(V(k)-X)';
    end
end
