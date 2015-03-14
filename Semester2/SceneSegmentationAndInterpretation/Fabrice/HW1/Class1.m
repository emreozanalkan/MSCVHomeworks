function [ class1 ] = Class1( X, mu, sigma )
%CLASS1 Summary of this function goes here
%   Detailed explanation goes here

class1 = normpdf(X, mu, sigma);

%class1 = (1 / (sqrt(sigma * 2 * pi))) * exp( (-pow2(X - mu)) / (2 * sigma) );

%a = 1 / sqrt(sigma * 2 * pi);
%b = exp(-pow2(X - mu) / (2 * sigma));

%class1 = a * b;

end

