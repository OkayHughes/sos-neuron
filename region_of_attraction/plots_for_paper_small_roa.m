a = load("SOS_main.mat");
poly = a.fspotless;

initcs = [ -0.6715; 0.3901; 0.0883];

hXT = -((vvar - initcs(1))^2/0.01^2 + (nvar - initcs(2))^2/0.0025^2 + (mvar - initcs(3))^2/0.005^2 - 1);

res = 80
% v_grid = linspace(-0.6715 - 0.1, -0.6715 + 0.1, res);
% n_grid = linspace(0.3901 - 0.1, 0.3901 + 0.1, res);
% m_grid = linspace(0.0883 - 0.083, 0.0883 + 0.1, res);
v_grid = linspace(-1, 1, res);
n_grid = linspace(0, 1, res);
m_grid = linspace(0, 1, res);
[V,N, M] = meshgrid(v_grid,n_grid, m_grid);
V = reshape(V, [1, numel(V)]);
N = reshape(N, [1, numel(N)]);
M = reshape(M, [1, numel(M)]);

pts = [V;N;M];

'evaluating'

evals = msubs(poly, [vvar; nvar; mvar], pts);

'finished'

mask = evals <= 1;

figure(); hold on;
scatter3(V(mask), N(mask), M(mask))
zlabel("m")
xlabel("V")
ylabel("n")
view(45,30)
pbaspect([1 1 1])
saveas(gcf, "easy.png")
