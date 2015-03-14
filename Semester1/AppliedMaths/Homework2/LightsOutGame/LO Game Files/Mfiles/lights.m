function [col,row] = lights(L)

clc
axes('position',[.05 .0 .9 1],'color','k')

% Thank you Mina Ayman
demo_on = 0; % Turn off demo.
hintcue = 0; % Turn off hints.
savewin = 0; % Turn off win.
winset = zeros(5); % Set winning condition.

% The tiles.
c = 1;
[on off solon soloff lotitle] = cskin(c);
new = imread('new.bmp');
skin = imread('skin.bmp');
hint = imread('hint.bmp');
bdemo = imread('demo.bmp');
quit = imread('quit.bmp');
blank = imread('blank.bmp');

% Organizing the grid.
board = [lotitle blank blank;
    off off off off off blank new;
    off off off off off blank skin;
    off off off off off blank hint;
    off off off off off blank bdemo; 
    off off off off off blank quit];

while 1

% Skin details.
[on off solon soloff lotitle] = cskin(c);
s = size(on);
strick = s(2)/50;
board(1:50,1:250,:) = lotitle;
% Determine hint.
if hintcue == 1
    hint = solve(L);
else
    hint = zeros(5);
end

% Create new board.
for i = 2:6
    for j = 1:5
            if hint(i-1,j) == 1
                if L(i-1,j) == 1
                    pick = randi(strick);
                    board((((i-1)*50+1):(i*50)),(((j-1)*50+1):(j*50)),:) = solon(:,((pick-1)*50+1):((pick)*50),:);
                elseif L(i-1,j) == 0
                    board((((i-1)*50+1):(i*50)),(((j-1)*50+1):(j*50)),:) = soloff;
                end            
            elseif L(i-1,j) == 1
                pick = randi(strick);
                board((((i-1)*50+1):(i*50)),(((j-1)*50+1):(j*50)),:) = on(:,((pick-1)*50+1):((pick)*50),:);
            elseif L(i-1,j) == 0
                board((((i-1)*50+1):(i*50)),(((j-1)*50+1):(j*50)),:) = off;
            end
    end
end

% Plotting the board
set(gcf,'color','k')
imshow(board)
% Get the play of Player
if savewin ~= 1 % Don't stop here on winning play. 
    try
        if demo_on ~= 1
            [C,R,P] = impixel(board);
        end
        row = ceil(R/50)-1;
        col = ceil(C/50);
        
        % Menu options and capture faulty selections.
        if row == 3 && col == 6
              [C,R,P] = impixel(board);
              row = ceil(R/50);
              col = ceil(C/50);
              if row == 6 && col == 3                            
                  [C,R,P] = impixel(board);
                  row = ceil(R/50);
                  col = ceil(C/50);
                  if row == 3 && col == 0      
                     if c == 1
                        c = 6;
                     elseif c == 2
                        c = 5;
                     elseif c == 3
                        c = 4;
                     end
                     
                   end
              end
       
        elseif row == 1 && col == 7
            L = populate(L);
            L = check(L,0);
            hintcue = 0;
            continue
            
        elseif col == 8
                L = picture(L,row);
                hintcue = 0;
                continue
                
        elseif row == 2 && col == 7
            c = c + 1;
            if c > 3
                c = 1;
            end
            continue
            
        elseif row == 3 && col == 7
            hintcue = mod(hintcue + 1,2);
            continue
            
        elseif row == 4 && col == 7 || demo_on == 1
            demo_on = 1;
            if hintcue == 1
                hintcue = 0;
                continue
            end
            [row col] = demo(L);
            pause(.5)
            if L(row,col) == 1
                pick = randi(strick);
                board((((row)*50+1):((row+1)*50)),(((col-1)*50+1):(col*50)),:) = solon(:,((pick-1)*50+1):((pick)*50),:);
            elseif L(row,col) == 0
                board((((row)*50+1):((row+1)*50)),(((col-1)*50+1):(col*50)),:) = soloff;
            end
            imshow(board)
            pause(.5)
            
        elseif row == 5 && col == 7
            pause(.2)
            close all
            break
        
        end
        
    catch ME
        continue
    end
end
% Switch the states.
L = activate(L,row,col);
        
    if savewin == 1
        demo_on = 0;
        savewin = 0;
        win(c)
        pause(.5)
        L = populate(L);
        L = check(L,0);
        hintcue = 0;
        continue
    end
    
    if L == winset
       savewin = 1;
    end
end
end