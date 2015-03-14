function [ days, stationary ] = weather_simulation( M, n, x0 )
%WEATHER_SIMULATION Simulator that can randomly generate sequences
% of weather from transition function
%
% M: transition matrix
% n: # of days
% x0: initial condition

dayCount = [0; 0; 0];

day = '';

if x0(1) == 1
    day = 's';
    dayCount(1) = dayCount(1) + 1;
elseif x0(2) == 1
    day = 'c';
    dayCount(2) = dayCount(2) + 1;
else
    day = 'r';
    dayCount(3) = dayCount(3) + 1;
end

days = '';
days = [days; day];

x = x0;

for ii = 2 : n
    x = M * x;
    r = rand(1);
    if r < x(1)
        day = 's';
        dayCount(1) = dayCount(1) + 1;
        %x = [1; 0; 0];
    elseif x(1) < r && r < x(1) + x(2)
        day = 'c';
        dayCount(2) = dayCount(2) + 1;
        %x = [0; 1; 0];
    else
        day = 'r';
        dayCount(3) = dayCount(3) + 1;
        %x = [0; 0; 1];
    end
    days = [days; day];
end


stationary = dayCount ./ n;


























% day = '';
% 
% if x0(1) == 1
%     day = 's';
% elseif x0(2) == 1
%     day = 'c';
% elseif x0(3) == 1
%     day = 'r';
% end
% 
% x = x0;
% days = day;
% 
% for ii = 1 : n
%     x = M * x;
%     [c, I] = min(abs(x - rand));
%     if I == 1
%         day = 's';
%     elseif I == 2
%         day = 'c';
%     elseif I == 3
%         day = 'r';
%     end
%     
%     days = [days; day];
% end
























% if isequal(class(x0), class(char))
%     if isequal(x0, 's')
%         x0 = 1;
%     elseif isequal(x0, 'c')
%         x0 = 2;
%     elseif isequal(x0, 'r')
%         x0 = 3;
%     else
%         error('Initial condition should be 1, 2, 3 or s, c, r');
%     end
% elseif x0 < 1 || x0 > 3
%     error('Initial condition should be 1, 2, 3 or s, c, r');
% end


%randomDays = ceil(3 .* rand(n, 1))';
%display(randomDays);


% MARWAN WRITING ON BOARD
% rand() if 0.5, x1 = (0.8, 0.4, 0.2), 0.4 is close then pick the second
% one.

% x = x0;
% days = []
% for i = 1 : n
% x = M x;
% [c, I] = min(abs(x_rand or X - rand));
% if( I == 1)
%   days = 's';
% elseif( I == 2)
%   days = 'c';
% elseif( I == 3)
%   days = 'r';
% end
% days = [days; day];
% end  etc etc etc etc etc










end