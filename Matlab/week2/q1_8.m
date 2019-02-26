clc;clear all;close all;
t = linspace(-5,5,256);
y = sinc(2*t);
%%
N = 128;
W = linspace(-2*pi,2*pi,N);
Hs = freqz(y,1,W);
%%
figure
subplot(211);
plot((W/pi) , abs(Hs));
xlabel('freq');
subplot(212);
plot(t,y);
xlabel('time');
%%
figure
Hss = freqz(y(1:2:length(y)),1,W);
subplot(211);
plot((W/pi) , abs(Hss));
xlabel('freq');
subplot(212);
plot(t,y);hold on
plot(t(1:2:length(y)),y(1:2:length(y)),'o');
xlabel('time');
%% 3 * fr
ys = zeros(1,length(y)*3);
ys(1:3:length(ys)) = y;
Ts = t(2)-t(1);
hr =@(x,Ts,Sn,Sm) sinc( repmat(x+Ts,Sn,1) - repmat(((1:Sn)*Ts)' , 1 , Sm) / Ts );
hr(t,Ts,256,256*3);



    