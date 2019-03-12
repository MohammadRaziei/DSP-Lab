%% init workspace
clc;clear all;close all;
%% myconv
x = ones(1,5);
h = ones(1,3);
y_my = myconv(x,h);
y_mat = conv(x,h);