function [ result ] = measureMetric( actualImg, algImg, metric )

[rows cols] = size(actualImg);

if( strcmp(metric,'TP') == 1 )
    vals = [ 255 255 ];
end

if( strcmp(metric,'TN') == 1 )
    vals = [ 0 0 ];
end

if( strcmp(metric,'FP') == 1 )
    vals = [ 0 255 ];
end

if( strcmp(metric,'FN') == 1 )
    vals = [ 255 0 ];
end

numOfPixels = 0;

for i=1 : rows
    for j=1 : cols
        
        if( actualImg(i,j) == vals(1) && algImg(i,j) == vals(2) )
            numOfPixels = numOfPixels + 1;     
        end
    end
end

result = numOfPixels;
            