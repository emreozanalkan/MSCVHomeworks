function [row col] = demo(L)

hint = solve(L);
for i = 1:5
     j = find(hint(i,:),1);     
     row = i;
     col = j;
     if size(j) == 1
         return
     end
end