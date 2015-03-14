function [ B ] = GANmean( A, m )
%GANmean GAN Choquet filters suck as the GAN mean operator.
%   For each point x of the image, the mean value of all the interesities
%   of the posints inside the GAN of x is computed.

B = zeros(size(A));

for s = 0:255
    seed = (A == s);
    thresh = (A >= s - m) & (A <= s + m);
    threshGAN = imreconstruct(seed, thresh);
    labelGAN = bwlabel(threshGAN, 8);
    nLabelGAN = max(max(labelGAN));
    for label = 1:nLabelGAN
        currentLabel = (labelGAN == label);
        grayValues = A(currentLabel);
        meanValue = mean(grayValues);
        B = B + meanValue .* double(seed .* currentLabel);
    end
end


end

