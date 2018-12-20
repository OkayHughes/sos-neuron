%low high
%fig2
% odefun = gen_poly_HH_2("minf_sos_polyval.mat", "a_polyval.mat", "b_polyval.mat");
% current1 = linspace(0, 11, 200)';
% current2 = linspace(11, 60, 50)';
% current = [current1; current2];
% totnumcurr = size(current, 1);
% 
% freqs = zeros(totnumcurr, 1);
% initcs = zeros(totnumcurr, 2);
% initcs(1, :) = [-70.0433,    0.3170];
% prevfreq = 0;
% for cind=1:totnumcurr
%     curr = current(cind)
%     [freq, initc] = f_for_i(odefun, current(cind), initcs(cind, :));
%     freq
%     freqs(cind) = freq;
%     initcs(1+cind, :) = initc;
% end
% save('frombelow_sos.mat','current','freqs', 'initcs')
% 
% current = [flipud(current2); flipud(current1)];
% totnumcurr = size(current, 1);
% 
% freqs = zeros(totnumcurr, 1);
% initcs = zeros(totnumcurr, 2);
% initcs(1, :) = [-70.0433,    0.3170];
% prevfreq = 0;
% for cind=1:totnumcurr
%     curr = current(cind)
%     [freq, initc] = f_for_i(odefun, current(cind), initcs(cind, :));
%     freq
%     freqs(cind) = freq;
%     initcs(1+cind, :) = initc;
% end
% save('fromabove_sos.mat','current','freqs', 'initcs')
% 

fromabove = load("fromabove.mat");
fromabove_sos = load("fromabove_sos.mat");

frombelow = load("frombelow.mat");
frombelow_sos = load("frombelow_sos.mat");
figure; hold on;
plot(frombelow.current, frombelow.freqs);
plot(frombelow_sos.current, frombelow_sos.freqs);

saveas(gcf, "fi_blw_orig_vs_sos.png")

V0p = [-77.7109    0.1744];