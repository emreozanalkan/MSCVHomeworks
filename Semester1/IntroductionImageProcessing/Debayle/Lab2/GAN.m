function [ V ] = GAN( A, x, y, m )
%GAN The GAN of a point x using the luminance criterion and the homogeneity
%   A: gray-level image
%   x, y: pair coordinates
%   m: homogeneity tolarance

d = A(x, y);
Alow = A >= d - m;
Ahigh = A <= d + m;
AThres = Alow & Ahigh;

V = AThres;

end

