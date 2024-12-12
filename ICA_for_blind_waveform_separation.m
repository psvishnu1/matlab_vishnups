% Done by: Vishnu P S
% Reads 3 waveforms; Mixes them; Later try separate them using fastICA

clc
clear

amplitude = 1;         
f = 1;
num_cycles = 4;        
sampling_rate = 100;   

t = linspace(0, num_cycles/f, num_cycles * sampling_rate);

y1 = amplitude * square(2 * pi * f * t);
y2 = amplitude * sawtooth(2 * pi * f * t);
y3 = amplitude * sinc(2 * pi * f * t);

figure;
subplot(3,3,1)
plot(t, y1)
subplot(3,3,4)
plot(t, y2)
subplot(3,3,7)
plot(t, y3)

A = rand(3,3);
S = [y1;y2;y3];
X = A * S;

subplot(3,3,2)
plot(t, X(1,:))
subplot(3,3,5)
plot(t, X(2,:))
subplot(3,3,8)
plot(t, X(3,:))

s1 = fastICA(X);

subplot(3,3,3)
plot(t, s1(1,:))
subplot(3,3,6)
plot(t, s1(2,:))
subplot(3,3,9)
plot(t, s1(3,:))
