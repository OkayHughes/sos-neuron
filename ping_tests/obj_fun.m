function res = obj_fun(x)
addpath 'PING code'/
[f, ~] = gamma_simulator(x, fullfile(pwd(), 'PING code/params0.mat'));

if isfile("best_ping.mat")
    dat = load("best_ping.mat");

    if (abs(dat.f - 46.4820) < abs(f - 46.4820))
        best_difference = abs(dat.f - 46.4820)
        save("best_ping.mat", "f", "x")
    end
else
    fprintf("Saving ping_best.mat\n");
    save("best_ping.mat", "f", "x")
end

res = -abs(dat.f - 46.4820)


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