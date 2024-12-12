% Done by: Vishnu P S
% Reads 2 image signals; Mixes them; Later try separate them using fastICA

clc
clear;

a1 = imread("testpat1.png");
a2 = imread("text.png");

figure;
subplot(2,3,1)
imshow(a1);
subplot(2,3,4)
imshow(a2);

[m,n] = size(a1);

a1 = reshape(double(a1),1,[]);
a2 = reshape(double(a2),1,[]);

A = rand(2,2);
%A = [0.4,0.2;0.6,0.8];
mixed_data = A * [a1;a2];

subplot(2,3,2)
imshow(reshape(mixed_data(1,:),m,n));
subplot(2,3,5)
imshow(reshape(mixed_data(2,:),m,n));

[s,mixM] = fastICA(mixed_data);
unmixM = pinv(mixM);

subplot(2,3,3)
imshow(reshape(s(1,:),m,n));
subplot(2,3,6)
imshow(reshape(s(2,:),m,n));

recons_img = unmixM * s;
