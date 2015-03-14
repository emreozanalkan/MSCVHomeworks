function [ Image_CFA ] = bayer( Input_RGB )
%bayer Transforms an input color image into an image simulating the output
%of a CFA before demosaicing
%   Input_RGB is the input color image of dimensions(Nb_Lines,Nb_Columns,3)
%   Image_CFA is an image of the same dimensions supposed issued from a CFA
%   CFA = Color Filter Array

inputSize = size(Input_RGB);
Nb_Lines = inputSize(1);
Nb_Columns = inputSize(2);


Image_CFA = zeros(size(Input_RGB));
Image_CFA = uint8(Image_CFA);

R_Mask = [0 1; 0 0];
G_Mask = [1 0; 0 1];
B_Mask = [0 0; 1 0];

R_Rep = uint8(repmat(R_Mask, floor(Nb_Lines/2), floor(Nb_Columns/2)));
G_Rep = uint8(repmat(G_Mask, floor(Nb_Lines/2), floor(Nb_Columns/2)));
B_Rep = uint8(repmat(B_Mask, floor(Nb_Lines/2), floor(Nb_Columns/2)));

Image_CFA(:, :, 1) = Input_RGB(:, :, 1) .* R_Rep;
Image_CFA(:, :, 2) = Input_RGB(:, :, 2) .* G_Rep;
Image_CFA(:, :, 3) = Input_RGB(:, :, 3) .* B_Rep;

end

