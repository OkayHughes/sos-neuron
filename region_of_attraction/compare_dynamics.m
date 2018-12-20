function main()
[dvdt, dndt, dmdt] = gen_msspoly_HH("matfiles/polyvecs/an.mat", "matfiles/polyvecs/bn.mat", "matfiles/polyvecs/am.mat", "matfiles/polyvecs/bm.mat");
I_app = 8;
dvdt = subs(dvdt, iapp_var(), I_app);
dynfun = gen_poly_HH("matfiles/polyvecs/an.mat", "matfiles/polyvecs/bn.mat", "matfiles/polyvecs/am.mat", "matfiles/polyvecs/bm.mat");
grid_v = linspace(-90, 60, 10);
grid_v_sc = linspace(-1, 1, 10);
grid_n = linspace(0, 1, 10);
grid_m = linspace(0, 1, 10);

[X, Y, Z] = meshgrid(grid_v, grid_n, grid_m);
xs = reshape(X, [numel(X), 1]);
ys = reshape(Y, [numel(Y), 1]);
zs = reshape(Z, [numel(Z), 1]);

pts = horzcat(xs, ys, zs);

[X, Y, Z] = meshgrid(grid_v_sc, grid_n, grid_m);
xs = reshape(X, [numel(X), 1]);
ys = reshape(Y, [numel(Y), 1]);
zs = reshape(Z, [numel(Z), 1]);

pts_sc = horzcat(xs, ys, zs);

eval_polyval = dynfun(pts, I_app);
size(eval_polyval)

[dvdt, dndt, dmdt] = scaled_dynamics(I_app);

eval_msspoly_dvdt = dmsubs(dvdt, [vvar(); nvar(); mvar()], pts_sc');
eval_msspoly_dndt = dmsubs(dndt, [vvar(); nvar(); mvar()], pts_sc');
eval_msspoly_dmdt = dmsubs(dmdt, [vvar(); nvar(); mvar()], pts_sc');
eval_msspoly = vertcat(eval_msspoly_dvdt, eval_msspoly_dndt, eval_msspoly_dmdt);
norm(eval_msspoly'-eval_polyval')

end



