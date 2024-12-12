% Done by: Vishnu P S
% Reads 3 audio signals; Mixes them; Later try separate them using fastICA

clc
clear;

[a1,fs1] = audioread("ICA_mix_1.wav");
[a2,fs2] = audioread("ICA_mix_2.wav");
[a3,fs3] = audioread("ICA_mix_3.wav");

sound(a1,fs1);
sound(a2,fs2);
sound(a3,fs3);

mixed_data = [a1,a2,a3];

s = fastICA(mixed_data');
s = s';

soundsc(s(:,1),fs1);
soundsc(s(:,2),fs2);
soundsc(s(:,3),fs3);
