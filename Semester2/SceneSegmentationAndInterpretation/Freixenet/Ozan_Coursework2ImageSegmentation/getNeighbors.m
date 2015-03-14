function [ neighbors ] = getNeighbors( image, pixel, neighborhood )

m = size(image,1);
n = size(image,2);

i = pixel(1);
j = pixel(2);

% if the pixel is inside the borders of the image
if(i<m && i>1 && j<n && j>1)

    if(neighborhood == 4)
        neighbors = [ i j-1; i+1 j; i j+1; i-1 j ];
    end

    if(neighborhood == 8)
        neighbors = [ i j-1; i+1 j-1; i+1 j; i+1 j+1; ...
            i j+1; i-1 j+1; i-1 j; i-1 j-1; ];
    end
    
    % top-left corner
else if( i==1 && j==1)
        
        if(neighborhood == 4)
            neighbors = [ i j+1; i+1 j ];
        end

        if(neighborhood == 8)
            neighbors = [ i j+1; i+1 j; i+1 j+1 ];
        end
        
        % upper edge 
    else if( i==1 && j>1 && j<n )
            
            if(neighborhood == 4)
                neighbors = [ i j+1; i j-1; i+1 j ];
            end

            if(neighborhood == 8)
                neighbors = [ i j+1; i j-1; i+1 j; i+1 j-1; i+1 j+1 ];
            end
            
            % top-right corner
        else if( i==1 && j==n )
                
                if(neighborhood == 4)
                    neighbors = [ i+1 j; i j-1 ];
                end

                if(neighborhood == 8)
                    neighbors = [ i j-1; i+1 j-1; i+1 j ];
                end
                
                % bottom-left corner
            else if( i==m && j==1 )
                    
                    if(neighborhood == 4)
                        neighbors = [ i-1 j; i j+1 ];
                    end

                    if(neighborhood == 8)
                        neighbors = [ i-1 j; i j+1; i-1 j+1 ];
                    end
                    
                    % lower edge
                else if( i==m && j>1 && j<n )
                        
                        if(neighborhood == 4)
                            neighbors = [ i j-1; i j+1; i-1 j ];
                        end

                        if(neighborhood == 8)
                            neighbors = [ i j-1; i j+1; i-1 j; i-1 j-1; i-1 j+1 ];
                        end
                        
                        % bottom-right corner
                    else if( i==m && j==n )
                            
                            if(neighborhood == 4)
                                neighbors = [ i-1 j; i j-1 ];
                            end

                            if(neighborhood == 8)
                                neighbors = [ i-1 j; i j-1; i-1 j-1 ];
                            end
                            
                            % left edge
                        else if( i<m && i>1 && j==1 )
                                
                                if(neighborhood == 4)
                                    neighbors = [ i-1 j; i+1 j; i j+1 ];
                                end

                                if(neighborhood == 8)
                                    neighbors = [ i-1 j; i+1 j; i j+1; i-1 j+1; i+1 j+1 ];
                                end 
                                
                                % right edge
                            else if( i<m && i>1 && j==n )
                                    
                                    if(neighborhood == 4)
                                        neighbors = [ i-1 j; i+1 j; i j-1 ];
                                    end

                                    if(neighborhood == 8)
                                        neighbors = [ i-1 j; i+1 j; i j-1; i-1 j-1; i+1 j-1 ];
                                    end 
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

