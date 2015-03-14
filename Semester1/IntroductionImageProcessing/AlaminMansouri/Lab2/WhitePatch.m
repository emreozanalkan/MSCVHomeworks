function [ RGB_Out ] = WhitePatch( RGB_In )
%WhitePatch Implementation of the White Patch Algorthm for Color Constancy
%   Algorithms for CC - White patch Algorithm - Page 23 in paper

RGB_Out = zeros(size(RGB_In));

RGB_max = max(max(RGB_In));

R_max = RGB_max(1, 1, 1);
G_max = RGB_max(1, 1, 2);
B_max = RGB_max(1, 1, 3);

S_r_max = 255;
S_g_max = 255;
S_b_max = 255;

K_r = S_r_max / R_max;
K_g = S_g_max / G_max;
K_b = S_b_max / B_max;

RGB_Out(:, :, 1) = RGB_In(:, :, 1) * K_r;
RGB_Out(:, :, 2) = RGB_In(:, :, 2) * K_g;
RGB_Out(:, :, 3) = RGB_In(:, :, 3) * K_b;

RGB_Out = uint8(RGB_Out);

end

