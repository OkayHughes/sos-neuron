function plot_onset()

plot_for_file("matfiles/fi_results/fromabove_sos.mat", 1, 1, "SOS onset of firing from above", "figs/spike_traces/SOS_above.png");

plot_for_file("matfiles/fi_results/fromabove_reg.mat", 1, 0, "Regression onset of firing from above", "figs/spike_traces/reg_above.png");

plot_for_file("matfiles/fi_results/frombelow_sos.mat", 0, 1, "SOS onset of firing from below", "figs/spike_traces/SOS_below.png");

plot_for_file("matfiles/fi_results/frombelow_reg.mat", 0, 0, "Regression onset of firing from below", "figs/spike_traces/reg_below.png");


plot_for_file_below("matfiles/fi_results/fromabove_sos.mat", 1, 1, "SOS below threshold from above", "figs/spike_traces/SOS_above_eq.png");

plot_for_file_below("matfiles/fi_results/fromabove_reg.mat", 1, 0, "Regression below threshold from above", "figs/spike_traces/reg_above_eq.png");

plot_for_file_below("matfiles/fi_results/frombelow_sos.mat", 0, 1, "SOS below threshold from above", "figs/spike_traces/SOS_below_eq.png");

plot_for_file_below("matfiles/fi_results/frombelow_reg.mat", 0, 0, "Regression below threshold from below", "figs/spike_traces/reg_below_eq.png");





end

function plot_for_file(matname, flip, is_sos, plotitl, plotname)
    res = load(matname);
    if flip
        curr = flipud(res.current);
        initcs = flipud(res.initcs);
        freqs = flipud(res.freqs);
    else
        curr = res.current;
        initcs = res.initcs;
        freqs = res.freqs;
    end
    curr_val = curr(freqs > 0);
    ics_val = initcs(freqs > 0, :);
    curr = curr_val(1);
    ics = ics_val(1, :);
    odefun = odefun_poly(is_sos, curr);
    [t, v] = sim_model(1, 100, odefun, ics);
    saveas(spiketrace(t, v, plotitl), plotname);
end

function plot_for_file_below(matname, flip, is_sos, plotitl, plotname)
    res = load(matname);
    if flip
        curr = flipud(res.current);
        initcs = flipud(res.initcs);
        freqs = flipud(res.freqs);
    else
        curr = res.current;
        initcs = res.initcs;
        freqs = res.freqs;
    end
    curr_val = curr(~(freqs > 0));
    ics_val = initcs(~(freqs > 0), :);
    curr = curr_val(end);
    ics = ics_val(end, :);
    odefun = odefun_poly(is_sos, curr);
    [t, v] = sim_model(1, 100, odefun, ics);
    saveas(spiketrace(t, v, plotitl), plotname);
end