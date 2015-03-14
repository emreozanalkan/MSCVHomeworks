function [ binaryImg colorImg ] = applyColorCoding( segImg )

% Color values to be used in color generation
colorValues = [ 255 200 160 128 84 40 10 ];
        
% Extract the region values
values = unique(reshape(segImg, [], 1));

colors = []; 

% as the length of the distinct values of regions
for i=1 : size(values)
    
    % generate a random color
    colorIndex = ceil(size(colorValues,2)*rand(1,1));
    colorR = colorValues(colorIndex);
    
    colorIndex = ceil(size(colorValues,2)*rand(1,1));
    colorG = colorValues(colorIndex);
    
    colorIndex = ceil(size(colorValues,2)*rand(1,1));
    colorB = colorValues(colorIndex);
    
    % put it in an array
    colors = [ colors; colorR colorG colorB ];
    
end

% generate the indices
colorArray = 1 : size(values);
colorArray = colorArray';

% create a hashList containing the indices and region numbers
hashList = [ values colorArray ];

% find the most frequent region - which is the background
mostFrequent = mode(mode(segImg));

[ rows cols ] = size(segImg);

outputColor = uint8(zeros(rows, cols, 3));

outputBinary = uint8(zeros(rows, cols));

for i=1 : rows
    for j=1 : cols
        
        % assign a color to the region by looking up at the hashList
        
        color = findColor(hashList,segImg(i,j));
        
        outputColor(i,j,1) = colors(color,1);
        
        outputColor(i,j,2) = colors(color,2);
        
        outputColor(i,j,3) = colors(color,3);
        
        
        % for binary image, make the background black
        if( segImg(i,j) == mostFrequent )
            outputBinary(i,j) = 0;
        else
            outputBinary(i,j) = 255;
        end
        
    end
end

binaryImg = outputBinary;
colorImg = outputColor;