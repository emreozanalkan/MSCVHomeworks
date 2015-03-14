close all
clc 

if size(timerfind,1) > 0  % Find active timers.
    stop(timerfind)
    delete(timerfind)
end

score = 0;
L = zeros(5);
L(3,1) = 3;
row = 3;
col = 1;

c = 2;

[on off solon soloff] = cskin(c);
new = imread('new.bmp');
skin = imread('skin.bmp');
hint = imread('hint.bmp');
bdemo = imread('demo.bmp');
quit = imread('quit.bmp');
blank = imread('blank.bmp');
del = imread('crulightdelon1.bmp');
chrono = imread('chrono.bmp');
robo = imread('robo.bmp');

% Organizing the grid.
board = [off off off off off blank;
    off off off off off blank;
    off off off off off blank;
    off off off off off blank; 
    off off off off off blank];
try
t1 = timer;
set(t1,'TimerFcn','if L(:,:) ~= 4; L(randi(5),randi(5)) = 4; end')
set(t1,'Period',2)
set(t1,'ExecutionMode','fixedRate')
start(t1) 

t2 = timer;
set(t2,'TimerFcn','[rowi,colj] = find(L == 4);')
set(t2,'Period',2)
set(t2,'ExecutionMode','fixedRate')
start(t2) 

t3 = timer;
set(t3,'TimerFcn','board((((rowi(:,1)-1)*50+1):(rowi(:,1)*50)),(((colj(:,1)-1)*50+1):(colj(:,1)*50)),:) = chrono;')
set(t3,'Period',2)
set(t3,'ExecutionMode','fixedRate')
start(t3) 

t4 = timer;
set(t4,'TimerFcn','imshow(board)')
set(t4,'Period',2)
set(t4,'ExecutionMode','fixedRate')
start(t4) 
catch ME
end
while 1
    d=0;
    s=0;
    a=0;
    w=0;
    r=0;
    q=0;
    
for i = 1:5
    for j = 1:5            
            if L(i,j) == 1
                board((((i-1)*50+1):(i*50)),(((j-1)*50+1):(j*50)),:) = del;
            elseif L(i,j) == 0
                board((((i-1)*50+1):(i*50)),(((j-1)*50+1):(j*50)),:) = off;
            elseif L(i,j) == 2
                board((((i-1)*50+1):(i*50)),(((j-1)*50+1):(j*50)),:) = off;
            elseif L(i,j) == 3
                board((((i-1)*50+1):(i*50)),(((j-1)*50+1):(j*50)),:) = robo;
            %elseif L(i,j) == 4     
            %    board((((i-1)*50+1):(i*50)),(((j-1)*50+1):(j*50)),:) = chrono;
            end
    end
end

% Plotting the board
set(gcf,'Color',[0 0 0])
imshow(board)
waitforbuttonpress
k = get (gcf, 'CurrentCharacter');
try    
if L(row,col) == 1
    L(row,col) = 0;
else
    L(row,col) = 2;
end

if k=='d'
    col = col+1;
elseif k=='w'
    row = row-1;
elseif k=='s'
    row = row+1;
elseif k=='a'
    col = col-1;
elseif k == 'g'
    L(col,row) = 2;
elseif k == 'q'
    close all
    stop(timerfind)
    delete(timerfind)
    break
elseif k == 'r'
    L = zeros(5);
    L(3,1) = 3;
    row = 3;
    col = 1;
    score = 0;
    continue
end

if row < 1
    row = row + 1;
elseif row > 5
    row = row - 1;
elseif col < 1
    col = col + 1;
elseif col > 5
    col = col - 1;
end

if L(row,col) == 0
    L(row,col) = 3;
elseif L(row,col) == 2
    L(row,col) = 3;
elseif L(row,col) == 4
    score = score + 1;
    L(row,col) = 3; 
end

catch ME
    continue
end
end