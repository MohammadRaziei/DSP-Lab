%% init workspace
clc;clear all;close all;
%%
fs = 500;
t = [0:1/fs:2];
sn = sin(2*pi*100*t);
% f = 100*t+200;
% chirp = cos(2*pi*f*t);
Chirp = chirp(t,200,2,400);
dlta =zeros(size(t)); dlta(250) = 50;
x = sn + dlta + Chirp;

%% fft
fft_x = fft(x,512);
fftshift_x = fftshift(fft_x);
W_fftshift =  linspace(-pi,pi,length(fftshift_x));

plot(W_fftshift/pi,abs(fftshift_x),'g'); xlabel('fftshift');
%% spectrogram
spec = spectrogram(x);
Hamming(256)



