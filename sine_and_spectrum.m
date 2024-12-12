% Done by: Vishnu P S
% Simple program to generate size wave of given frequency and analyse its spectrum

Fs = 150;
t = 0:1/Fs:1;
f = 5;
x_orig = sin(2*pi*f*t);
X = fftshift(fft(x_orig));

x_mag = abs(X);
df = -Fs/2:1:Fs/2;
figure(1);
plot(t,x_orig);
title('sine wave');

figure(2);
plot(df,x_mag);
title('spectrum');

%%
% adding noise

t = 0:0.01:2*pi;
x = sin(t);
plot(t,x);

y = rand(1,length(t));
x = x+y;
plot(t,x);