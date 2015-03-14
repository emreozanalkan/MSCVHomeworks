function [ fx1DResult ] = fx1D( x )

fx1DResult = -exp(-((x) .^ 2.0)) + exp(-((x+1) .^ 2.0));

end