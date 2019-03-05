%% init workspace
clc;clear all;close all;
addpath('../scripts');
% includes :
run handel_functions.m
%% def problem parameters 
t = linspace(-5,5,256);
y = sinc(2*t);
%% solution parameters
N = 128;
W = linspace(-2*pi,2*pi,N);
Hs = freqz(y,1,W);
%% plot A
figure
subplot(211);
plot((W/pi) , abs(Hs));
xlabel('freq');
subplot(212);
plot(t,y);
xlabel('time');
%% plot B
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
% hr =@(t_r,Ts,Sn) sinc( ( repmat(t_r + Ts - min(t_r),Sn,1) - repmat(((1:Sn)*Ts)' , 1 , length(t_r)) ) / Ts );
t_re = linspace(-5,5,256*3);
% y_re = y * H_sinc_inter(t_re,Ts,256);
y_re = sinc_inter(t_re,y,3);
%% plot 3 * fr || plot C
figure
subplot(212);
plot(t,y,'o');hold on
plot(t_re,y_re,'*')
xlabel('time');
legend('y : F_s = f_s','y_{re} : F_s = 3 f_s');

H3s = freqz(ys,1,W);
H3ss = freqz(y_re,1,W);
subplot(211);
hold on;
plot((W/pi) , abs(Hs));
plot((W/pi) , abs(H3s));
plot((W/pi) , abs(H3ss));
xlabel('freq');
legend('y','y_{zero padding}','y_{reconstructed}')
% close all



    