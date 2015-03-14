% SPOMF Lab

% Images
bear = imread('qbear.png');
image = imread('a.png');

[rBear, cBear] = size(bear);

[rImage, cImage] = size(image);

% Empty Image in image size
bearImageMask = zeros(rImage, cImage);

% putting bear into middle
rowTop = floor((rImage / 2) - (rBear / 2));
if rowTop < 0
    rowTop = 0;
end

rowBottom = floor((rImage / 2) + (rBear / 2)) - 1;
if rowBottom > rImage
    rowBottom = rImage;
end;

colLeft = floor((cImage / 2) - (cBear / 2));
if colLeft < 0
    colLeft = 0;
end

colRight = floor((cImage / 2) + (cBear / 2)) - 1;
if colRight > cImage
    colRight = cImage;
end

bearImageMask(rowTop : rowBottom, colLeft : colRight) = bear;

% Two-dimensional discrete Fourrier Transform
fftImage = fft2(image); 
fftbearImageMask = fft2(bearImageMask); 

% Convolving our fft bear image mask with complex conjugate of the image we
% want to locate
bearImageLocations = conj(fftImage ./ abs(fftImage)) .* (fftbearImageMask ./ abs(fftbearImageMask));

% Inverse discrete Fourrier transform to convert image from fft2 image to
% display
bearImageLocations = ifft2(bearImageLocations);

imshow(bearImageLocations, []);








