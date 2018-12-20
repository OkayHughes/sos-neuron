initc = [0, 1E-5, 1E-5];
odefun = @(t, v) HH_orig(v', 8);
[ts, vs, te] = sim_model(0, 100, odefun, initc);

figure; hold on;
xtickformat("%d ms")
ytickformat("%d mV")
plot(ts, vs(:, 1))
title("Original")
saveas(gcf, "3d_orig_spiketrace.png")



odefun = gen_poly_HH('matfiles/polyvecs/an.mat', 'matfiles/polyvecs/bn.mat', "matfiles/polyvecs/am.mat", "matfiles/polyvecs/bm.mat");
odefun = @(t, v) odefun(v', 8);
[ts, vs, te] = sim_model(0, 100, odefun, initc);

figure; hold on;
xtickformat("%d ms")
ytickformat("%d mV")
plot(ts, vs(:, 1))
title("Polynomial")

saveas(gcf, "3d_poly_spiketrace.png")