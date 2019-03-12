%% init workspace
clc;clear all;close all;
%%
M = 300;
n = 0:M;

sn = sin(0.2*pi*n);
vn = sin(0.05*pi*n) + sin(0.35*pi*n);
xn = sn + vn;
%plot(n,xn)
wa = 0.15 * pi;
wb = 0.25*pi;
W = 0.54 - 0.46*sin(2*pi.*n/M);
h = W.*(wb./pi.*sinc(wb/pi.*(n - 0.5*M)) - wa./pi.*sinc(wa/pi.*(n - 0.5*M))); 
y = filter(h,1,xn);

hold on
plot(sn)
plot(y)


