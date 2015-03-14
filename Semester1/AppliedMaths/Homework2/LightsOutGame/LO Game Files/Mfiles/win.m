function cont = win(c)

[on off] = cskin(c);
win = imread('lowin.bmp');
new = imread('new.bmp');
skin = imread('skin.bmp');
hint = imread('hint.bmp');
bdemo = imread('demo.bmp');
quit = imread('quit.bmp');
blank = imread('blank.bmp');
winm = [win blank blank];
if c == 4
    s = size(on);
    strick = s(2)/50;
    pick = randi(strick);
    on = on(:,((pick-1)*50+1):((pick)*50),:);
end

for r = 1:3
for j = 1:5
   
    board = [off off off off off blank new;
    off off off off off blank skin;
    off off off off off blank hint;
    off off off off off blank bdemo; 
    off off off off off blank quit];

    board((((0)*50+1):(1*50)),(((j-1)*50+1):(j*50)),:) = on;
    board((((4)*50+1):(5*50)),((((6-j)-1)*50+1):((6-j)*50)),:) = on;
    
    pause(.005)
    imshow([winm;board])
end

for i = 1:5
    board = [off off off off off blank new;
    off off off off off blank skin;
    off off off off off blank hint;
    off off off off off blank bdemo; 
    off off off off off blank quit];

    board((((i-1)*50+1):(i*50)),(((5-1)*50+1):(5*50)),:) = on;
    board(((((6-i)-1)*50+1):((6-i)*50)),((1-1)*50+1):((1*50)),:) = on;
    
    pause(.005)
    imshow([winm;board])
end

pause(.005)

end

for k = 1:3
    
    board = [off off off off off blank new;
    off off off off off blank skin;
    off off off off off blank hint;
    off off off off off blank bdemo; 
    off off off off off blank quit];
  
    imshow([blank blank blank blank blank blank blank;
        board])
    
    pause(.2)
    
    board = [on on on on on blank new;
    on on on on on blank skin;
    on on on on on blank hint;
    on on on on on blank bdemo; 
    on on on on on blank quit];
    
    imshow([winm;board])
    
    windisp = title('WIN                    ');
    set(windisp,'Color',[1 0 1])
    set(windisp,'FontWeight','bold')
    set(windisp,'FontSize',14)
    
    pause(.3)
end