function fi_plots()

fromabove = load("matfiles/fi_results/fromabove.mat");
fromabove_sos = load("matfiles/fi_results/fromabove_sos.mat");
fromabove_reg = load("matfiles/fi_results/fromabove_reg.mat");

frombelow = load("matfiles/fi_results/frombelow.mat");
frombelow_sos = load("matfiles/fi_results/frombelow_sos.mat");
frombelow_reg = load("matfiles/fi_results/frombelow_reg.mat");

figure; hold on;
plot(frombelow.current, frombelow.freqs);
plot(frombelow_sos.current, frombelow_sos.freqs);

saveas(gcf, "figs/fi_curves/fi_blw_orig_vs_sos.png")

figure; hold on;
plot(fromabove.current, fromabove.freqs);
plot(fromabove_sos.current, fromabove_sos.freqs);

saveas(gcf, "figs/fi_curves/fi_abv_orig_vs_sos.png")

figure; hold on;
plot(frombelow.current, frombelow.freqs);
plot(fromabove.current, fromabove.freqs);

saveas(gcf, "figs/fi_curves/fi_orig.png")

figure; hold on;
plot(frombelow_reg.current, frombelow_reg.freqs);
plot(fromabove_reg.current, fromabove_reg.freqs);

saveas(gcf, "figs/fi_curves/fi_polyreg.png")

figure; hold on;
plot(frombelow_sos.current, frombelow_sos.freqs);
plot(fromabove_sos.current, fromabove_sos.freqs);

saveas(gcf, "figs/fi_curves/fi_sos.png")

end
