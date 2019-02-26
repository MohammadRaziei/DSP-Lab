clc;clear all;close all;
t = -5:0.01:5;
y = sinc(5*t).^2;
for fs=[4,5,10,20]
    figure;hold on
    ts = -5:(1/fs):5;
    ys = sinc(5*ts).^2;
    plot(ts,ys,'o')
    plot(t,y)
end





