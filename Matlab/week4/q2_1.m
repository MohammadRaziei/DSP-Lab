%% init workspace
clc;clear all;close all;
%% a) test myconv
x = ones(1,5);
h = ones(1,3);
y_my = myconv(x,h);
y_mat = conv(x,h);

%% b) use myconv
h = 0.1*ones(1,10);
t= 1:200;
x = square(2*pi/50*t);
% stem(x)
y = myconv(h,x);
stem(y)
