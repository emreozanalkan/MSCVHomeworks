clc
close all

% Get screen size
set(0,'units','pixels')
scr=get(0,'screensize');

% Create figure
figure('units','pixels','position',[.25*scr(3) .25*scr(4) .5*scr(3) .5*scr(4)],'color','k','toolbar','none','menubar','none')

% Create axes  
set(gcf,'resize','off')
axes('position',[0 0 1 1],'color','k','xlim',[0 1],'ylim',[0 1])

L = zeros(5); %Set the size of L.
L = populate(L); %A random configuration.
L = check(L,0); %This is where we'll check L. The 0 sets the counter
opening
[row col] = lights(L);