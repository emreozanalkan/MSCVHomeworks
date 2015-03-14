function [ waveletCoefficients ] = jLevelWaveletTransform( image, J, lowPassFilter )
%JLEVELWAVELETTRANSFORM J-level wavelet transform
%   A Matlab function for computing the J-level wavelet transform of an NxN image (assume N is a power of 2).

if ~isempty(J) && J < 1
    error('J is not valid');
end

[row, col] = size(image);

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

% Initialization
waveletCoefficients = zeros(row, row);
temp = zeros(row, row);

for ii = 1 : row
    % Low Pass Filtering
    imageRowLowPass = pconv(lowPassFilter, image(ii, :));
    % Downsampling
    downSampledRowLow = imageRowLowPass(1 : 2 : length(imageRowLowPass));
    % High Pass Filtering
    imageRowHighPass = pconv(highPassFilter, image(ii, :));
    % Downsampling
    downSampleRowHigh = imageRowHighPass(1 : 2 : length(imageRowHighPass));
    % Storing rows for jth level
    temp(ii, :) = [downSampledRowLow, downSampleRowHigh];
end

for ii = 1 : col
    % Low Pass Filtering
    imageColLowPass = pconv(lowPassFilter, temp(:, ii)'); % temp used
    % Downsampling
    downSampledColLow = imageColLowPass(1 : 2 : length(imageColLowPass));
    % High Pass Filtering
    imageColHighPass = pconv(highPassFilter, temp(:, ii)'); % temp used
    % Downsampling
    downSampleColHigh = imageColHighPass(1 : 2 : length(imageColHighPass));
    % Output for jth level
    waveletCoefficients(:, ii) = [downSampledColLow, downSampleColHigh];
end

% Recursive Call for (j-1)th Level
if J > 1
    waveletCoefficients(1 : (row / 2), 1 : (col / 2)) = jLevelWaveletTransform(waveletCoefficients(1 : (row / 2), 1 : (col / 2)), J - 1, lowPassFilter);
end

end

