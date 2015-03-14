


D1 = [1;0];  % Direction for the search
D2 = [2;1];


Pstart = [-4;4];   % Point of starting
thresh = 1;  %Threshold
t=-5:0.01:5; % interval
a=10;  
b=4;  %Parabola parameters


% Plot
[x,y]=meshgrid(-2:0.1:2,-4:0.1:4); % Range of Values for x and y
f = @(x,y) (x.^2/a.^2)+(y.^2/b.^2)-1;   % Quadratic equation
z = f(x,y);
figure;
hold on
contour(x,y,z);

% finding minimum
i = 0;
while thresh>10^-6
    i=i+1;  % iteration counter
    
    vect = repmat(Pstart,[1,length(t)])+repmat(D1,[1,length(t)]).*[t;t]; %The 1st direction
    % storing x and y values in a vector.
    z = f(vect(1,:),vect(2,:));    
    
    minimum = min(z); %finding minimum with brute force.
    minf = find(z == minimum); % getting index of minimum value
    Pnew = vect(:,minf);       % setting end point
    plot([Pstart(1),Pnew(1)],[Pstart(2),Pnew(2)],'k'); 
    Pstart=Pnew;    % new start point = current end point
    
    plot(Pstart(1),Pstart(2),'ro');
    %same repeatation in other direction
    vect = repmat(Pstart,[1,length(t)])+repmat(D2,[1,length(t)]).*[t;t];
    
    z = f(vect(1,:),vect(2,:));    
    
    minimum = min(z);
    minf = find(z == minimum);
    Pnew = vect(:,minf);
    
    thresh = norm(Pnew-Pstart);   % drawn line distance
    plot([Pstart(1),Pnew(1)],[Pstart(2),Pnew(2)],'k');
    Pstart=Pnew;
    plot(Pstart(1),Pstart(2),'ro');
    drawnow                     % draw with the iteration
end
i         % check the iterations