clc; clear all; close all;
%%
sample = imread('Image02.jpg');
sample = im2double(sample);
imshow(sample);
figure;
noisy_sample = imnoise(sample, 'gaussian', 0.01);
imshow(noisy_sample);
figure;
mean_filt = 1/9 *ones(3,3);
imshow(imfilter(noisy_sample,mean_filt));
mean_filt_5by5 = 1/25 * ones(5,5);
figure;
imshow(imfilter(noisy_sample, mean_filt_5by5));
figure;
noisy_sample_salt = imnoise(sample,'salt & pepper',0.1);
imshow(noisy_sample_salt);
figure; imshow(imfilter(noisy_sample_salt, mean_filt));
figure; imshow(imfilter(noisy_sample_salt, mean_filt_5by5));


