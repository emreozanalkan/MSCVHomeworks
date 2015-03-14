function [ result ] = getNeighborsRegion( img, neighbors )

values = [ ];

for i=1 : size(neighbors,1)

    x = neighbors(i,1);
    y = neighbors(i,2);
        
    values = [ values img(x,y) ];
        
end

%return the most frequent region of neighbors around this pixel
result = mode(values);

end