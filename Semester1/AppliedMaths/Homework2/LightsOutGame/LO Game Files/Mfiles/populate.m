function L = populate(L)

for i = 1:5
    for j = 1:5
        r = randi(2);
        
        if r == 1
            L(i,j) = 1;
        end
        
        if r == 2
            L(i,j) = 0;
        end
    end
end