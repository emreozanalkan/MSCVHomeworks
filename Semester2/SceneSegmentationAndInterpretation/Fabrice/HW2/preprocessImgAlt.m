function [imgEq, imgLabA, imgLabB] = preprocessImgAlt(imgIn)

%channels
imgLabA = imgIn(:, :, 1);
imgLabB = imgIn(:, :, 3);
imgG = imgIn(:, :, 2);

backgroundRed = double(medfilt2(imgG, [30 30]));
imgEq = double(imgG) - backgroundRed;
imgEq( imgEq > 0 ) = 0;
imgEq = -1 * (imgEq);

end