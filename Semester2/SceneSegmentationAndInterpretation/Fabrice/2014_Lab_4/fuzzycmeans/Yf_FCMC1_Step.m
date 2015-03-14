function [V, U, E] = Yf_FCMC1_Step(X, V, c, m)
%Yf_FCMC1_Step One step in fuzzy c-mean clustering.
%
%   See Yf_FCMC1.m  
%
%   Mahdi Amiri, June 15, 2003
%   http://yashil.20m.com/

n = size (X, 1);
p = size (X, 2);

dist = Yf_EuDistArrayOfVectors1 (V, X); % fill the distance matrix

% calculate new U, suppose m != 1
tmp = dist.^(-2/(m-1));
U = tmp./(ones(c, 1)*sum(tmp));

% Correct the situation of "singularity" (one of the data points is
% exactly the same as one of the cluster centers).
si = find (tmp == Inf);
U(si) = 1;
if (size (si, 1) ~= 0)
    display ('FCMC, Warning: Singularity occured and corrected.');
end

% Check constraint
tmp = find ((sum (U) - ones (1, n)) > 0.0001);
if (size(tmp,2) ~= 0)
    display ('FCMC, Warning: Constraint for U is not hold.');
end

V_old = V;
mf = U.^m; % MF matrix after exponential modification
V = mf*X./((ones(p, 1)*sum(mf'))'); % new center

E = norm (V - V_old, 1);

