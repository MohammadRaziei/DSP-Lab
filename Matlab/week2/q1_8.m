clc;clear all;close all;
t = linspace(-5,5,256);
y = sinc(2*t);
%%
N = 128;
W = linspace(-2*pi,2*pi,N);
Hs = freqz(y,1,W);
%%
subplot(211);
plot((W/pi) , abs(Hs));
xlabel('freq');
subplot(212);
plot(t,y);
xlabel('time');


    