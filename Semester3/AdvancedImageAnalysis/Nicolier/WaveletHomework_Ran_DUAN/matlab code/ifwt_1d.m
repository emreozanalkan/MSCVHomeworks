function s = ifwt_1d(c,dn,N,h)

if nargin < 3
    N = 1;
    h = [0.48296 0.83652 0.22414 -0.12941];
end

if nargin == 3
    h = [0.48296 0.83652 0.22414 -0.12941];
end

for ii = 1:N
    d = dn(1:length(c));
    dn = dn(length(c)+1:end);
    c = Synthesis_bank_1d_basic(c,d,h);
end

s = c;

end