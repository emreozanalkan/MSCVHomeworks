%% Grayscale

function [ DSC ] = RegionGrowingGrayscale( I, groundTruth, delta )

[ rows cols ] = size(I);

% matrix that keeps the visited pixel information
visited = zeros(rows, cols);

% Region array to keep the region information. A pixel is marked with a
% number that indicates a region.
regionMatrix = zeros(rows, cols);

% Neighborhood to be considered when growing a seed.
neighborhood = 4;

% Number of seeds that will be placed on the image.
seedNum = 100;

% Create random values for seeds
seedsR = ceil(rows*rand(seedNum,1));    % x-coordinate
seedsC = ceil(cols*rand(seedNum,1));    % y-coordinate

seeds = [ seedsR seedsC ];  % concatenate them to have just one seed list

% Region counter, increases as we grow each seed.
currentRegion = 1;

while( size(seeds,1) ~= 0 )

    % Our seed value
    seed = seeds(1,:);
    
    % Extraxt the coordinates of the seed
    seedX = seed(1);
    seedY = seed(2);

    % Discard the used seed from the seed queue
    seeds = seeds(2:end,:);
    
    % If the seed already exists inside a region, ignore it.
    if(regionMatrix( seedX, seedY ) ~= 0)
        continue;
    end

    % Our region
    region = [ I(seedX,seedY) ];

    % Mark the pixel as selected
    visited( seedX, seedY ) = 1;

    % Assign this pixel's region number
    regionMatrix( seedX, seedY ) = currentRegion;

    % Find the neighbors of this pixel
    neighbors = getNeighbors( I, seed, neighborhood );

    % Create a queue for the explored pixels
    queue = [ ];
    
    % This is a flag to check if all the neighbors of this pixel are
    % visited.
    allNeighborsVisited = 1;

    % Explore the neighbors of this pixel
    for i=1 : size(neighbors,1)

        x = neighbors(i,1);
        y = neighbors(i,2);

        % if this neighbor is not visited
        if( visited(x,y) == 0 )

            visited(x,y) = 1;   % mark it as visited
            
            % set the flag to false, since there is a neighbor which was
            % not visited
            allNeighborsVisited = 0;     
            
            % calculate the difference between the intensity value and the
            % mean intensity value of the current region
            diff = abs( double(I( x, y )) - mean(region) );

            % if the difference is smaller than a delta value
            if( diff  < delta )
                
                % take the pixel into this region
                region = [ region; I(x,y) ];
                
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

        pixel = queue(1,:);

        x = pixel(1);
        y = pixel(2);

        queue = queue(2:end,:);

        neighbors = getNeighbors( I, pixel, neighborhood );

        for i=1 : size(neighbors,1)

            x = neighbors(i,1);
            y = neighbors(i,2);

            if( visited(x,y) == 0 )

                visited(x,y) = 1;

                if( abs( double(I( x, y )) - mean(region) ) < delta )
                    region = [ region; I(x,y) ];
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

% apply color coding to colorize the segmented image and also to convert
% it to a binary image
[ binaryImg colorSegImg ] = applyColorCoding( regionMatrix );

%binaryImg = convertToBinary(colorSegImg);

% apply median filter to binary image to eliminate the noise
binaryImg = medfilt2(binaryImg);

figure; imshow(colorSegImg); title('Segmented Image');

figure; imshow(binaryImg); title('Binary Image');


% Find the Dice Similarity Coefficient, comparing the ground truth
% image and the algorithm result
dsc = findDSC(groundTruth, binaryImg);

DSC = dsc;



