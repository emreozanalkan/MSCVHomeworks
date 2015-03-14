function [ B ] = HitORMiss( A, T1, T2 )
%HitORMiss The hit-or-miss transformation enables specific pixel
%configurations to be detected.
%   T1 = "hit" part
%   T2 = "miss" part

AErodeT1 = imerode(A, T1);

AErodeT2 = imerode(imcomplement(A), T2);

B = AErodeT1 & AErodeT2;

end

