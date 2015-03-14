function [on off solon soloff lotitle] = cskin(c)

off = imread('crulightoff.bmp'); 
soloff = imread('crulightsoloff.bmp');

if c == 3
    on = imread('crulighton1.bmp');
    solon = imread('crulightsolon1.bmp');
    lotitle = imread('lotitle3.bmp');
elseif c == 2
    on = imread('crulighton2.bmp');
    solon = imread('crulightsolon2.bmp');
    lotitle = imread('lotitle2.bmp');
elseif c == 1
    on = imread('sphere.bmp');
    solon = imread('spheresol.bmp');
    off = imread('sphereoff.bmp');
    soloff = imread('spheresoloff.bmp');
    lotitle = imread('lotitle1.bmp');
elseif c == 4
    on1 = imread('robo.bmp');
    solon1 = imread('robosol.bmp');
    on2 = imread('frog.bmp');
    solon2 = imread('frogsol.bmp');
    on3 = imread('magus.bmp');
    solon3 = imread('magussol.bmp');
    on4 = imread('chrono.bmp');
    solon4 = imread('chronosol.bmp');
    on5 = imread('lucca.bmp');
    solon5 = imread('luccasol.bmp');
    on6 = imread('marle.bmp');
    solon6 = imread('marlesol.bmp');
    on7 = imread('ayla.bmp');
    solon7 = imread('aylasol.bmp');
    on = [on1 on2 on3 on4 on5 on6 on7];
    solon = [solon1 solon2 solon3 solon4 solon5 solon6 solon7];
elseif c == 5
    on = imread('noahon.bmp');
    solon = imread('noahsolon.bmp');
elseif c == 6
    on = imread('daveon.bmp');
    solon = imread('davesolon.bmp');
    lotitle = imread('lotitle1.bmp');
end
