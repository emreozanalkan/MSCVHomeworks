function [ reconstructedImage ] = inverseJLevelWaveletTransform( waveletCoefficients, J, lowPassFilter )
%INVERSEJLEVELWAVELETTRANSFORM Inverse J-level wavelet transform
%    Inverse J-level wavelet transform of an NxN array of wavelet coefficients.

if ~isempty(J) && J < 1
    error('J is not valid');
end

[row, col] = size(waveletCoefficients);

if row ~= col
    error('Image should be NxN');
elseif mod(row, 2) || mod(col, 2)
    error('assume N is a power of 2');
end

% High Pass Filter
for ii = 1 : length(lowPassFilter)
    highPassFilter(ii) = lowPassFilter(ii) * power(-1, ii);
end

% Flip the high pass filter
highPassFilter = fliplr(highPassFilter);

% Recursive Call for (j-1)th Level
if J > 1
    waveletCoefficients(1 : (row / 2), 1 : (col /2)) = inverseJLevelWaveletTransform(waveletCoefficients(1 : (row / 2), 1 : (col /2)), J - 1, lowPassFilter);
end

% Initialization
reconstructedImage = zeros(row, col);
temp = zeros(row, col);

for ii = 1 : col
    % Upsampling for cols
    downSampledLow = waveletCoefficients(1 : (col / 2), ii);
    upSampledLow = zeros(1, 2 * length(downSampledLow));
    upSampledLow(1 : 2 : length(upSampledLow)) = downSampledLow;
    % Upsampling for cols
    downSampledHigh = waveletCoefficients((col / 2) + 1 : col, ii);
    upSampledHigh = zeros(1, 2 * length(downSampledHigh));
    upSampledHigh(1 : 2 : length(upSampledHigh)) = downSampledHigh;
    % Low pass filter
    upSampledLow = pconv(lowPassFilter, fliplr(upSampledLow));
    % High pass filter
    upSampledHigh = pconv(highPassFilter, fliplr(upSampledHigh));
    % Storing constructed cols for jth level
    temp(:, ii) = fliplr(upSampledLow + upSampledHigh);
end

for ii = 1 : row
    % Upsampling for rows
    downSampledLow = temp(ii, 1 : (row / 2));
    upSampledLow = zeros(1, 2 * length(downSampledLow));
    upSampledLow(1 : 2 : length(upSampledLow)) = downSampledLow;
    % Upsampling for rows
    downSampledHigh = temp(ii, (row / 2) + 1 : row);
    upSampledHigh = zeros(1, 2 * length(downSampledHigh));
    upSampledHigh(1 : 2 : length(upSampledHigh)) = downSampledHigh;
    % Low pass filter
    upSampledLow = pconv(lowPassFilter, fliplr(upSampledLow));
    % High pass filter
    upSampledHigh = pconv(highPassFilter, fliplr(upSampledHigh));
    % Stroing reconstructed rows for jth level
    reconstructedImage(ii, :) = fliplr(upSampledLow + upSampledHigh);
end

end

