function gen_plot_for_paper()
    pert_0 = load('best_ping_burst0.0.mat');
    pert_5 = load('best_ping_burst0.5.mat');
    pert_1 = load('best_ping_burst1.0.mat');
    
    perturb_0 = pert_0.x;
    perturb_1 = pert_1.x;
    perturb_5 = pert_5.x;
    [spiketimes_e_0, spiketimes_i_0] = gamma_simulator_plots(perturb_0, fullfile(pwd(), 'params0.0.mat'));
    [spiketimes_e_0_nom, spiketimes_i_0_nom] = gamma_simulator_plots(zeros(1, 6), fullfile(pwd(), 'params0.0.mat'));
    fig_hand = raster_plot(0, 200, spiketimes_e_0_nom, spiketimes_i_0_nom, spiketimes_e_0, spiketimes_i_0, 'p_{e \rightarrow i} = 1 \times 10^{-5}');
    saveas(fig_hand, 'ping_figs/0.0_raster.png')
    
    [spiketimes_e_5, spiketimes_i_5] = gamma_simulator_plots(perturb_5, fullfile(pwd(), 'params0.5.mat'));
    [spiketimes_e_5_nom, spiketimes_i_5_nom] = gamma_simulator_plots(zeros(1, 6), fullfile(pwd(), 'params0.5.mat'));
    fig_hand = raster_plot(0, 200, spiketimes_e_5_nom, spiketimes_i_5_nom, spiketimes_e_5, spiketimes_i_5, 'p_{e \rightarrow i} = 0.5');
    saveas(fig_hand, 'ping_figs/0.5_raster.png')
    
    [spiketimes_e_1, spiketimes_i_1] = gamma_simulator_plots(perturb_1, fullfile(pwd(), 'params1.0.mat'));
    [spiketimes_e_1_nom, spiketimes_i_1_nom] = gamma_simulator_plots(zeros(1, 6), fullfile(pwd(), 'params1.0.mat'));
    fig_hand = raster_plot(0, 200, spiketimes_e_1_nom, spiketimes_i_1_nom, spiketimes_e_1, spiketimes_i_1, 'p_{e \rightarrow i} = 1.0');
    saveas(fig_hand, 'ping_figs/1.0_raster.png')
    
%     spiketimes = spiketimes(spiketimes(:, 2) >20, :);
%     spiketimes(:, 2) = spiketimes(:, 2) - 20;
%     [~,vtraces,~] = spiketraces(80,spiketimes);  
%     m = mpc_network(80, spiketimes)
%     b = burst_measure(80, vtraces)
%     c = crcorr_network(80, vtraces)
end

function fig_handle = raster_plot(t0, tend, te_nom, ti_nom, te_exp, ti_exp, titl)
    figure; hold on;
    plot([t0, tend], [20, 20], 'k')
    xtickformat('%d ms')
    xlabel('t') 
    ytickformat('%d')
    xlabel('Neuron Index') 
    size(te_nom)
    
    sz = size(te_nom, 1);
    s = scatter(te_nom(:, 1),te_nom(:, 2)+20, 20 * ones(sz, 1), 1 * ones(sz, 1),'filled');
    s.LineWidth = 0.1;
    s.MarkerEdgeColor = 'k';
    
    sz = size(ti_nom, 1);
    s = scatter(ti_nom(:, 1),ti_nom(:, 2), 20 * ones(sz, 1), 0.8 * ones(sz, 1),'filled');
    s.LineWidth = 0.1;
    s.MarkerEdgeColor = 'k';
    
    sz = size(te_exp, 1);
    s = scatter(te_exp(:, 1),te_exp(:, 2)+20, 20 * ones(sz, 1), 0 * ones(sz, 1),'filled');
    s.LineWidth = 0.1;
    s.MarkerEdgeColor = 'k';
    
    sz = size(ti_exp, 1);
    s = scatter(ti_exp(:, 1),ti_exp(:, 2), 20 * ones(sz, 1), 0.2 * ones(sz, 1),'filled');
    s.LineWidth = 0.1;
    s.MarkerEdgeColor = 'k';
    
    
    title(titl)
    fig_handle = gcf;
end