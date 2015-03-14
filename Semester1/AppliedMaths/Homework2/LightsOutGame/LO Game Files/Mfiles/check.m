function L = check(L,x)

b = [L(1,1:5),L(2,1:5),L(3,1:5),L(4,1:5),L(5,1:5)]';

B = [1 1 0 0 0;1 1 1 0 0;0 1 1 1 0;0 0 1 1 1;0 0 0 1 1];
I = eye(5);
O = zeros(5);
A = [B I O O O;I B I O O;O I B I O;O O I B I;O O O I B];

R = mod(rref(A),2);

n1 = R(:,24);
n1(24,1) = 1;
n2 = R(:,25);
n2(25,1) = 1;

% Check that b is in C(A).
perp = mod(dot(n1,b),2) + mod(dot(n2,b),2);

if perp ~= 0
    x = x+1;
    L = populate(L);
    L = check(L,x);
elseif perp == 0
    return
end