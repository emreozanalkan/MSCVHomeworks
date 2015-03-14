% this is a function to extract the value corresponding to a specific
% region from the hashList

function [ result ] = findColor( hashList, region )

n = size(hashList,1);

for i=1 : n
    
    if(hashList(i,1) == region)
        found = hashList(i,2);
        break;
    end
end

result = found;