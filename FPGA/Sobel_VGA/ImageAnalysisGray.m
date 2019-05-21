clear
clc
close all

I0 = imread('Image04.tif');
I = I0(:,:,1:3);
I1 = rgb2gray(I);

imshow(I1);
[m,n] = size(I1);	

R = 0;
G = I1;
B = 0;
I2 = zeros(m,n,3);
I2(:,:,1)=R;
I2(:,:,2)=G;
I2(:,:,3) = B;

R = double(R);
G = double(G);
B = double(B);
I2 = uint8(I2);
figure, imshow(I2)
 
R = R.^(5/8);
G = G.^(6/8);
B = B.^(5/8);


R = uint16(R);
G = uint16(G);
B = uint16(B);

R = R-1;
G = G-1;
B = B-1;

G = bitshift(G, 5); 
B = bitshift(B, 11);
COLOR = R+G+B;

fileID = fopen ('Image04.list', 'w');
for i = 1:size(COLOR(:), 1)-1
    fprintf (fileID, '%x\n', COLOR(i));
end
fprintf (fileID, '%x', COLOR(size(COLOR(:), 1)));
fclose (fileID);
COLOR_HEX = dec2hex(COLOR);
