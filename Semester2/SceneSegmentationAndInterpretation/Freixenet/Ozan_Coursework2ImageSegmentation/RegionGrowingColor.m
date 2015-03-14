%% Color Images

function [ DSC ] = RegionGrowingColor( I, groundTruth, delta )

[ rows cols ] = size(rgb2gray(I));

visited = zeros(rows, cols);

% Region array to keep the region information. A pixel is marked with the
% number of its region.
regionMatrix = zeros(rows, cols);

neighborhood = 4;

% Number of seeds that will be placed on the image.
seedNum = 100;

% Create random values for seeds
seedsR = ceil(rows*rand(seedNum,1));    % x-coordinate
seedsC = ceil(cols*rand(seedNum,1));    % y-coordinate

seeds = [ seedsR seedsC ];  % concatenate them to have just one seed list

%seeds = [ 72 49; 138 188; 244 103; 180 47 ];   %used for color.tif
%exceptionally

% Region counter, increases as we grow each seed.
currentRegion = 1;

while( size(seeds,1) ~= 0 )
    
    % Our seed value
    seed = seeds(1,:);
    
    seedX = seed(1);
    seedY = seed(2);

    % Discard the used seed from the seed queue
    seeds = seeds(2:end,:);
    
    % If the seed already exists inside a region, ignore it.
    if(regionMatrix( seedX, seedY ) ~= 0)
        continue;
    end

    % Our region
    region = [  I(seedX,seedY,1)  I(seedX,seedY,2)  I(seedX,seedY,3)  ];

    % Mark the pixel as selected
    visited( seedX,seedY ) = 1;
    
    % Assign this pixel's region number
    regionMatrix( seedX, seedY ) = currentRegion;

    % Explore the neighbors of this pixel
    neighbors = getNeighbors( I, seed, neighborhood );

    % Create a queue for the explored pixels
    queue = [ ];
    
    % This is a flag to check if all the neighbors of this pixel are
    % visited.
    allNeighborsVisited = 1;

    % Explore the neighbors of this pixel
    for i=1 : size(neighbors)

        x = neighbors(i,1);
        y = neighbors(i,2);

        % currently explored pixel
        current = [ I(x, y, 1) I(x, y, 2) I(x, y, 3) ];

        % if this neighbor is not visited
        if( visited(x,y) == 0 )

            visited(x,y) = 1;   % mark it as visited
            
            % set the flag to false, since there is a neighbor which was
            % not visited
            allNeighborsVisited = 0;
            
            if(size(region,1)==1)
                regionMean = region;
            else
                regionMean = mean(region);
            end

            % calculate the difference between the intensity value and the
            % mean intensity value of the current region
            diff = abs( double(current) - double(regionMean) );

            % if the difference is smaller than a delta value
            if( diff < delta )
                
                % take the pixel into this region
                region = [ region; I(x,y,1) I(x,y,2) I(x,y,3) ];
                
                % label it as inside the current region
                regionMatrix(x,y) = currentRegion;
                
                % put it to queue to explore its neighbors later
                queue = [ queue; x y ];
            % if it's outside the given delta    
            else
                % put it as a new seed to the seed list
                seeds = [ seeds; x y ];
            end
        end
    end
    
    % if all neighbors of this seed were visited
    if ( allNeighborsVisited == 1 )
        
        % check its neighbors to estimate which region it belongs to
        estimatedRegion = getNeighborsRegion(regionMatrix, neighbors);            
            
        % put it to that estimated region
        regionMatrix( seedX, seedY ) = estimatedRegion;
        
    end

    % now explore the pixels contained in the queue
    % same process as above
    while( size(queue,1) ~= 0 )
        
        size(queue,1)

        pixel = queue(1,:);

        x = pixel(1);
        y = pixel(2);

        queue = queue(2:end,:);

        neighbors = getNeighbors( I, pixel, 8 );

        for i=1 : size(neighbors)

            x = neighbors(i,1);
            y = neighbors(i,2);

            current = [ I(x, y, 1) I(x, y, 2) I(x, y, 3) ];

            if( visited(x,y) == 0 )

                visited(x,y) = 1;
                
                if(size(region,1)==1)
                    regionMean = region;
                else
                    regionMean = mean(region);
                end

                diff = abs( double(current) - double(regionMean) );


                if( diff < delta )
                    region = [ region; I(x,y,1) I(x,y,2) I(x,y,3) ];
                    regionMatrix(x,y) = currentRegion;
                    queue = [ queue; x y ];
                else
                    seeds = [ seeds; x y ];
                end

            end

        end

    end
    
    % we are done with this seed, so increase the region number for the new
    % seed
    currentRegion = currentRegion + 1;
    
end


[ binaryImg colorSegImg ] = applyColorCoding( regionMatrix );

binaryImg = medfilt2(binaryImg);

figure; imshow(colorSegImg); title('Segmented Image');

figure; imshow(binaryImg); title('Binary Image');

dsc = findDSC(groundTruth, binaryImg);

DSC = dsc;

