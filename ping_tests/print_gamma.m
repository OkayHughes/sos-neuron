function [b, m, c] = print_gamma(x, hand, plotname)
    perturb = x
    [~, spiketimes] = gamma_simulator(x, fullfile(pwd(), hand), plotname);
    spiketimes = spiketimes(spiketimes(:, 2) >20, :);
    spiketimes(:, 2) = spiketimes(:, 2) - 20;
    [~,vtraces,~] = spiketraces(80,spiketimes);  
    m = mpc_network(80, spiketimes)
    b = burst_measure(80, vtraces)
    c = crcorr_network(80, vtraces)
end