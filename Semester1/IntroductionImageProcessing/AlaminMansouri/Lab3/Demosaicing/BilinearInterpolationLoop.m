function [ Output_RGB ] = BilinearInterpolationLoop( Image_CFA )
%MyBilinearInterpolation Bilinear interpolation using a loop
%   Replicate the line/column N-1 if the dimension is N, on the borders
%   of the image in order to avoid boundaries artefacts

[x y chCount] = size(Image_CFA);

I_R = Image_CFA(:, :, 1);
I_G = Image_CFA(:, :, 2);
I_B = Image_CFA(:, :, 3);

Output_RGB = zeros(size(Image_CFA));


% RED
for ii = 2:x-1
    for jj = 2:y-1
        Output_RGB(ii, jj, 1) = 
    end
end



Output_RGB = Image_CFA;

end

