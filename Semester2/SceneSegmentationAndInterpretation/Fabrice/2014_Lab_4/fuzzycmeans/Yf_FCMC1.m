function [V, U, E] = Yf_FCMC1 (X, c, options, init_V)
%Yf_FCMC1: Fuzzy C-Means Clustering.
%
%   [V, U, E] = Yf_FCMC1 (X, c, options, inti_V)
%   X: Input data (n by p)
%      n: Number of feature vectors
%      p: Length of each feature vector
%   c: Number of clusters
%   init_V: Initial cluster centers
%   OPTIONS(1): Weighting exponent (m) (default: 2.0)
%   OPTIONS(2): Maximum number of iterations (default: 100)
%   OPTIONS(3): Termination threshold (default: 1e-3)
%   OPTIONS(4): Info display during iteration (default: 1)
%   OPTIONS(5): Use provided init_V (default: 0)
%
%   V: Cluster centers (c by p)
%   U: Membership degrees (c by p)
%   E: Termination measure values (max_iter by 1)
%
%   This is based on fcm.m in MATLAB's Fuzzy Logic Toolbox with a few
%   modifications; considering the algorithm presented in [BezKKP99]
%   - Starting with initial guess for V instead of U
%   - Considering the situation of "singularity"
%   - Termination measure: norm (V(t) - V(t-1))
%
%   The clustering process stops when the maximum number of iterations
%   is reached, or when the termination measure is less than the termination
%   threshold.
%
%   Related M-files: Yf_FCMC1_InitV, Yf_FCMC1_Step, Yf_FCMC_Dist.
%
%   Reference:
%   [BezKKP99] James C. Bezdek, James Keller, Raghu Krishnapuram and
%   Nikhil R. Pal, Fuzzy Models and Algorithms for Pattern Recognition
%   and Image Processing, Kluwer Academic Publishers, TA 1650.F89 1999.
%
%   Mahdi Amiri, June 15, 2003
%   http://yashil.20m.com/

if nargin < 2,
	error('Too few input arguments!');
end

if nargin > 4,
	error('Too many input arguments!');
end

n = size(X, 1);
p = size(X, 2);

% Change the following to set default options
default_options = [2;	% weighting exponent (m)
		100;	% max. number of iteration
		1e-3;	% termination threshold
		1;      % info display during iteration 
        0];     % use provided init_V 

if nargin == 2,
	options = default_options;
else
	% If "options" is not fully specified, pad it with default values.
	if length(options) < 5,
		tmp = default_options;
		tmp(1:length(options)) = options;
		options = tmp;
	end
	% If some entries of "options" are nan's, replace them with defaults.
	nan_index = find(isnan(options)==1);
	options(nan_index) = default_options(nan_index);
end

m = options(1);	        	% Weighting exponent
max_iter = options(2);		% Max. iteration
term_thr = options(3);		% Termination threshold
display = options(4);		% Display info or not
use_init_V = options(5);    % use provided init_V

if m <= 1,
    error('The weighting exponent should be greater than 1!');
end

E = zeros(max_iter, 1);	% Array for termination measure values

if use_init_V,
    V = init_V;
else
    V = Yf_FCMC1_InitV (c, p); % Initial cluster centers
end

%U = zeros (c, n);

% Main loop
for i = 1:max_iter,
	[V, U, E(i)] = Yf_FCMC1_Step (X, V, c, m);

    if display, 
		fprintf('Iteration count = %d, Termination measure value = %f\n', i, E(i));
	end

    % check termination condition
	if E(i) <= term_thr, break; end,
end

iter_n = i;	% Actual number of iterations 
E(iter_n+1:max_iter) = [];
