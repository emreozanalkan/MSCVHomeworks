function [pattern] = generatePattern(number,dist, height)
% Generates planes. Num is number of planes, dist is dist between them
% Height is the only useful for plotting. Use to define area covered by
% projector
% num > 0 , dist >0, height> 0
if nargin<1    
number = 1;
end
if nargin<2    
dist = 1;
end
if nargin<3
height = 14;
end

num = ceil(number/2);
first_dist = dist;
height = height/2;
pattern_init(1,:) = [0,height,height,0,-height,height];

for i = 1:num   
    if (num == 1)
        pattern =[0,height,height,0,-height,height];
    else
        pattern_one = [first_dist,height,height,first_dist,-height,height] ;
        pattern_two = [-first_dist,height,height,-first_dist,-height,height];
        first_dist = first_dist+dist; % first_dist * 2;
        pattern1(i,:) =  pattern_one;  
        pattern2(i,:) =  pattern_two;  
    end          
end
if (num == 1)
    pattern(1,:) =[0,height,height,0,-height,height];
else
    pattern = [pattern_init;pattern1;pattern2];
end

end