clc;clear all;close all;
t = -5:0.01:5;
y = sinc(5*t).^2;
N = 128;
W = linspace(-4*pi,4*pi,N);

for fs=[4,5,10,20]
    figure;hold on
    ts = -5:(1/fs):5;
    ys = sinc(5*ts).^2;
    Hs = freqz(ys,1,W);
    subplot(211);
    plot((W/pi) , abs(Hs));
    subplot(212);
    
    plot(ts,ys,'o')
    plot(t,y)
    xlabel(['fs = ' num2str(fs)]);
end





