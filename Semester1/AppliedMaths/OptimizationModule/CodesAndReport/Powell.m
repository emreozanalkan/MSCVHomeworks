
% Computation of the minimum of a 2D function via Powell's Method

%% search directions
D1 = [1;0];
D2 = [2;1];

%% starting point
Pstart = [4;4];
thresh = 1;  %Threshold
t=-5:0.01:5;
a=8;  %Parabolic values of a
b=3;   %Parabolic values of b


%% Plot

[x,y]=meshgrid(-2:0.1:2,-4:0.1:4); % Range of Values for x and y
f = @(x,y) (x.^2/a.^2)+(y.^2/b.^2)-1;   % Quadratic equation
z = f(x,y);

figure;
hold on
contour(x,y,z);

%% initial step
vec = repmat(Pstart,[1,length(t)])+repmat(D1,[1,length(t)]).*[t;t];

z = f(vec(1,:),vec(2,:));    

minimum = min(z); % Brut force
minf = find(z == minimum);
Pnew = vec(:,minf);
plot([Pstart(1),Pnew(1)],[Pstart(2),Pnew(2)],'k');
P1=Pnew;

plot(P1(1),P1(2),'ro');
i=1;

%% minimisation

while thresh>10^-4
    i=i+1;

    vec = repmat(P1,[1,length(t)])+repmat(D2,[1,length(t)]).*[t;t];
    
    z = f(vec(1,:),vec(2,:));    
    
    minimum = min(z);
    minf = find(z == minimum);
    Pnew = vec(:,minf);
    
    thresh = norm(Pnew-P1);
    plot([P1(1),Pnew(1)],[P1(2),Pnew(2)],'k');
    D2 = Pstart-Pnew;
    Pstart=P1;
    P1=Pnew;
    plot(P1(1),P1(2),'ro');
    drawnow
end
i