function V = Yf_FCMC1_InitV (c, p)
%Yf_FCMC1_InitV: Generate initial cluster centers for FCM clustering.
%
%   See Yf_FCMC1.m  
%
%   Mahdi Amiri, June 21, 2003
%   http://yashil.20m.com/

V = rand(c, p);
