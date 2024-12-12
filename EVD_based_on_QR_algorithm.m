% Done by: Vishnu P S
% This code computes EVD through QR algorithm

clc;clear;

m = 3;
n = 3;
N = 10;         % Number of QR iterations;
A = rand(m,n)

V = eye(n);     % Initialize eigen vector matrix

% Preprocessing
A = A - mean(A);
c = cov(A);
R1 = c;

% EVD loop
for i = 1 : N
    [Q1, R1] = qr(R1);
    R1 = R1 * Q1;
    V = V * Q1;
end

% Algorithm output
eig_val_out = R1
eig_vec_out = V

% Matlab output
[eig_vec_mat_out,eig_val_mat_out] = eigs(c,n)
