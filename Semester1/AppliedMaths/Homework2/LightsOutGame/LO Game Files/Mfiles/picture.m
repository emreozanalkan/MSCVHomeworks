function L = picture(L,choose)

if nargin == 1
    choose = randi(4);
end

if choose == 1
 % Heart
 L = [0 1 0 1 0;
      1 0 1 0 1;
      1 0 0 0 1;
      0 1 0 1 0;
      0 0 1 0 0];
  
elseif choose  == 2
% Arrow
L = [0 0 0 0 0;
     0 1 1 1 0;
     0 1 1 0 0;
     0 1 0 1 0;
     0 0 0 0 1];

elseif choose == 3 
% Rocket Ship 
L = [0 0 1 0 0;
     0 1 1 1 0;
     0 1 0 1 0;
     1 1 1 1 1;
     1 0 1 0 1];
 
elseif choose == 4 
% Sail Boat
L = [0 0 1 0 0;
     0 1 1 0 0;
     0 0 1 0 0;
     1 1 1 1 1;
     0 1 1 1 0];
end
end