function f = calc_freq(x)
addpath 'PING code'/

for i=1:num_steps
    hand = params(p_ies(i));
    [f, ~] = gamma_simulator(fullfile(pwd(), "params0.mat"));
    spiketimes = spiketimes(spiketimes(:, 2) >20, :);
    spiketimes(:, 2) = spiketimes(:, 2) - 20;
    mpcs(i) = mpc_network(80, spiketimes);
    [ts,vtraces,~] = spiketraces(80,spiketimes);
    burstms(i) = burst_measure(80, vtraces);
    xcorrs(i) = crcorr_network(80, vtraces);
end
save("comps.mat", 'freqs', "mpcs", "xcorrs", "burstms", "p_ies")



end
% 
% load("comps.mat")
% 
% figure; hold on;
% xlim([0.1, 1]);
% ylim([0, 1]);
% xtickformat('%.2f')
% ytickformat('%1.2f')
%     
% title("Exitatory synapse density vs MPC")
% plot(p_ies, mpcs)
% 
% saveas(gcf, "MPC.png");
% 
% 
% figure; hold on;
% xlim([0.1, 1]);
% ylim([0, 1]);
% xtickformat('%.2f')
% ytickformat('%1.2f')
%     
% title("Exitatory synapse density vs Mean Cross Correlation")
% plot(p_ies, xcorrs)
% 
% saveas(gcf, "crcorr.png");
% 
% 
% figure; hold on;
% xlim([0.1, 1]);
% ylim([0, 1]);
% xtickformat('%.2f')
% ytickformat('%1.2f')
%     
% title("Exitatory synapse density vs Bursting Measure")
% plot(p_ies, burstms)
% 
% saveas(gcf, "burst.png");
% 
% 
% hand = params(0.1);
% freqs(i) = gamma_simulator(fullfile(pwd(), hand), "raster_pie_0.1.png");
% 
% hand = params(0.5);
% freqs(i) = gamma_simulator(fullfile(pwd(), hand),  "raster_pie_0.5.png");
% 
% hand = params(1);
% freqs(i) = gamma_simulator(fullfile(pwd(), hand),  "raster_pie_1.png");