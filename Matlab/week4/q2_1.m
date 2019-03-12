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
% stem(y)
%% c) use myconv
h = 0.25*(0.75).^(1:14);
t= 1:200;
% stem(x)
y = myconv(h,x);
% stem(y)
%% d) use myconv
H = 0.2 * conv([1,-1],conv([1,-1],conv([1,-1],conv([1,-1],[1,-1]))));
y = myconv(H,x);
stem(y)

