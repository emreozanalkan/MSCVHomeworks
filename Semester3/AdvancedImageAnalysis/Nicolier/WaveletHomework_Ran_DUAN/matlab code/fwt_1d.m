% wavelet homework function
% N level wavelet transform for 1D signal
% Ran DUAN 16-01-2015
function c_d = fwt_1d(s, N, h)

if nargin < 2
    N = 1;
    h = [0.48296 0.83652 0.22414 -0.12941];
end

if nargin == 2
    h = [0.48296 0.83652 0.22414 -0.12941];
end

dn = [];
c = [];

for ii = 1:N
    [d, c] = analysis_bank_1d_basic(s,h);
    dn = [d dn];
    s = c;
end

c_d = [c dn];

end