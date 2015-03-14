function [ RGB_Out ] = GreyWorld( RGB_In )
%GreyWorld Implementation of the Grey World Algorthm for Color Constancy
%   Algorithms for CC - Grey world Algorithm - Page 21 in paper

% figure(1);
% imshow(RGB_In);

meanR = mean(mean(RGB_In(:, :, 1)));
meanG = mean(mean(RGB_In(:, :, 2)));
meanB = mean(mean(RGB_In(:, :, 3)));

% display(meanR);
% display(meanG);
% display(meanB);

Avg = mean([meanR meanG meanB]);

% display(Avg);

% alfa  = meanR / Avg;
% beta  = meanG / Avg;
% delta = meanB / Avg;

% display(alfa)
% display(beta)
% display(delta)

K_r = Avg / meanR; % K_r = 1 / alfa;
K_g = Avg / meanG; % K_g = 1 / beta;
K_b = Avg / meanB; % K_b = 1 / delta;

RGB_Out = zeros(size(RGB_In)); 

RGB_Out(:, :, 1) = RGB_In(:, :, 1) * K_r;
RGB_Out(:, :, 2) = RGB_In(:, :, 2) * K_g;
RGB_Out(:, :, 3) = RGB_In(:, :, 3) * K_b;

RGB_Out = uint8(RGB_Out);

% figure(2);
% imshow(RGB_Out);


end

