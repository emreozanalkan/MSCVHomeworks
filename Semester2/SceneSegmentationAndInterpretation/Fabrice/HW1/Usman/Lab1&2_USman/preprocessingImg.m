function [imgG,imgLabA,imgLabB] = preprocessingImg(imgIn)
% channels
cform =  makecform('srgb2lab');
imgLab = applycform(imgIn,cform);
imgLabA = imgLab(:,:,2);
imgLabB = imgLab(:,:,3);
imgG = imgLab(:,:,1);
backgroundRed = double(medfilt2(imgG,[30,30]));
imgEq = double(imgG) - backgroundRed;
imgEq(imgEq > 0) = 0;
imgEq = -1*(imgEq);
end