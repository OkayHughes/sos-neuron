vgrid = linspace(-1.1, 1.1, 100);
ngrid = linspace(-1.1, 1.1, 100);
[X, Y] = meshgrid(vgrid, ngrid);
X = reshape(X, [numel(X), 1]);
Y = reshape(Y, [numel(Y), 1]);
th = load('vdp.mat');
th = th.fspotless;

Z = dmsubs(th, [vvar; nvar], [X'; Y']);

X = reshape(X, [100, 100]);
Y = reshape(Y, [100, 100]);
Z = reshape(Z, [100, 100]);
figure;
mesh(X, Y, Z)
clear all;





