clear all;
close all;
clc;

%% Test Program

images = { 'gris21.tif'; 'coins.png'; 'feli.png' };

colorImages = { 'woman.tif'; 'color.tif' };

GTimages = { 'gris21GroundTruth.png'; 'coinsGroundTruth.png'; 'feliGroundTruth.png' };

colorGTimages = { 'womanGroundTruth.png'; 'colorGroundTruth.png' }; 

thresholds = [ 45 62 45 ];

colorThresholds = [ 80 80 90; 5 5 5 ];

for i=1 : 3

    image = imread(images{i});
    GTimage = imread(GTimages{i});

    DSC = RegionGrowingGrayscale( image, GTimage, thresholds(i) );

    disp(DSC);

end

for i=1 : 2

    image = imread(colorImages{i});
    GTimage = imread(colorGTimages{i});

    DSC = RegionGrowingColor( image, GTimage, colorThresholds(i,:) );

    disp(DSC);

end
