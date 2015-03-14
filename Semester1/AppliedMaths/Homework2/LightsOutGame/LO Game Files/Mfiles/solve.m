function hint = solve(L)

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

% Find all solutions
solution = myrref(A,b);
s1 = solution;
s2 = mod(solution + n1,2);
s3 = mod(solution + n2,2);
s4 = mod(solution + n2 + n1,2);
s = [s1 s2 s3 s4];

% Find the fastest solution
s1size = size(find(s1'));
s2size = size(find(s2'));
s3size = size(find(s3'));
s4size = size(find(s4'));

[y,j] = min([s1size(1,2) s2size(1,2) s3size(1,2) s4size(1,2)]);
fsolution = s(:,j);


hint = [fsolution(1:5,1)';fsolution(6:10,1)';fsolution(11:15,1)';fsolution(16:20,1)';fsolution(21:25,1)'];

