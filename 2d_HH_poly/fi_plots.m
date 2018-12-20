function fi_plots()

fromabove = load("matfiles/fi_results/fromabove_orig.mat");
fromabove_poly = load("matfiles/fi_results/fromabove_poly.mat");

frombelow = load("matfiles/fi_results/frombelow_orig.mat");
frombelow_poly = load("matfiles/fi_results/frombelow_poly.mat");

figure; hold on;
title("Current Sweep from Below");
plot(frombelow.current, frombelow.freqs, 'k--');
plot(frombelow_poly.current, frombelow_poly.freqs, 'k-');
legend("Original", "Polynomial Model");

saveas(gcf, "figs/fi_curves/fi_blw_orig_vs_reg_3d.png")

figure; hold on;
title("Current Sweep from Above");
plot(fromabove.current, fromabove.freqs, 'k--');
plot(fromabove_poly.current, fromabove_poly.freqs, 'k-');
legend("Original", "Polynomial Model");

saveas(gcf, "figs/fi_curves/fi_abv_orig_vs_reg_3d.png")

figure; hold on;
title("Original 3d F-I Relations");
plot(frombelow.current, frombelow.freqs);
plot(fromabove.current, fromabove.freqs);
legend("From below", "From above");

saveas(gcf, "figs/fi_curves/fi_orig_3d.png")

figure; hold on;
title("Polynomial 3d F-I Relations");
plot(frombelow_poly.current, frombelow_poly.freqs);
plot(fromabove_poly.current, fromabove_poly.freqs);
[(1:250)', frombelow_poly.current, frombelow_poly.freqs]
frombelow_poly.initcs(146, :)

legend("From below", "From above");

saveas(gcf, "figs/fi_curves/fi_poly_3d.png")


end
