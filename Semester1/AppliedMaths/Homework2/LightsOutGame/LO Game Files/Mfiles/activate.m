function L = activate(L,i,j)    
try
if j == 5
    for col = -1
        L(i,j+col) = invert(L(i,j+col));
    end
end

if i == 5
    for row = -1:0
        L(i+row,j) = invert(L(i+row,j));
    end 
end

if j == 1 
    for col = 1
        L(i,j+col) = invert(L(i,j+col));
    end
end

if i == 1
    for row = 0:1
        L(i+row,j) = invert(L(i+row,j));
    end 
end

if j ~= 5 && j ~= 1
    for col = -1:2:1
        L(i,j+col) = invert(L(i,j+col));
    end
end

if i ~= 5 && i ~= 1
    for row = -1:1
        L(i+row,j) = invert(L(i+row,j));
    end
end

catch ME
    return
end