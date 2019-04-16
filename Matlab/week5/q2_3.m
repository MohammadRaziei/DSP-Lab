%% init workspace
clc;clear all;close all;
%% a)  audioread
[aud,fs] = audioread('Audio01.wav');
freqz(aud);
plot(aud);
%% b) filter
load filter.mat
% sound(aud,0.5*fs);

n = 0:length(aud)-1;
f0 = 1e4;
s = 2*cos(2*pi*f0/fs*n);
y0 = filter(Num,1,aud);
y = filter(Num,1,s'.*y0);

% sound(y,fs);
%% c) 
y0_new = filter(Num,1,y);
y_new = filter(Num,1,s'.*y0_new);
% sound(y_new,fs);