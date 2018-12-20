function res = obj_fun_sync(x, nom_vals, hand, pie)
addpath 'PING code'/

[b, m, c] = sim_gamma(x, hand);


save_best(sprintf("best_ping_burst%1.1f.mat", pie), nom_vals(1), x, b)
save_best(sprintf("best_ping_mpc%1.1f.mat", pie), nom_vals(2), x, m)
save_best(sprintf("best_ping_xcorr%1.1f.mat", pie), nom_vals(3), x, c)
res_b = -abs(b -  nom_vals(1));
res_m = -abs(m -  nom_vals(2));
res_c = -abs(c -  nom_vals(3));
res = min([res_b, res_m, res_c])


end



function save_best(name, nominal_val, x, b)
    if isfile(name)
        dat = load(name);

        if (abs(dat.b - nominal_val) < abs(b - nominal_val))
            save(name, "b", "x")
        end
    else
        fprintf("%s\n", name);
        save(name, "b", "x")
    end

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