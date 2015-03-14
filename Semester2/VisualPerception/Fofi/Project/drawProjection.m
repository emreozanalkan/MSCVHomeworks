function drawProjection(source, pattern)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

for i = 1:size(pattern,1)
X(1,:) = [source(1,1),pattern(i,1),pattern(i,4)];
Y(1,:) = [source(1,2),pattern(i,2),pattern(i,5)];
Z(1,:) = [source(1,3),pattern(i,3),pattern(i,6)];
fill3(X(1,:),Y(1,:),Z(1,:),rand()); hold on;
end
hold off;
xlabel('X')
ylabel('Y')
zlabel('Z')
end

