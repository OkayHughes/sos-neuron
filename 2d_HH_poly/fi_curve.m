function fi_curve()
% odefun = gen_poly_HH('matfiles/polyvecs/an.mat', 'matfiles/polyvecs/bn.mat', "matfiles/polyvecs/am.mat", "matfiles/polyvecs/bm.mat");
% current1 = linspace(0, 11, 200)';
% current2 = linspace(11, 60, 50)';
% current = [current1; current2];
% totnumcurr = size(current, 1);
% 
% freqs = zeros(totnumcurr, 1);
% initcs = zeros(totnumcurr, 3);
% initcs(1, :) = [-70.0200,    0.3164,    0.0523];
% prevfreq = 0;
% for cind=1:totnumcurr
%     curr = current(cind)
%     [freq, initc] = f_for_i(odefun, current(cind), initcs(cind, :));
%     freq
%     freqs(cind) = freq;
%     initcs(1+cind, :) = initc;
% end
% save('matfiles/fi_results/frombelow_poly.mat','current','freqs', 'initcs')
% % 
% current = [flipud(current2); flipud(current1)];
% totnumcurr = size(current, 1);
% 
% freqs = zeros(totnumcurr, 1);
% initcs = zeros(totnumcurr, 3);
% initcs(1, :) = [-70.0200,    0.3164,    0.0523];
% prevfreq = 0;
% for cind=1:totnumcurr
%     curr = current(cind)
%     [freq, initc] = f_for_i(odefun, current(cind), initcs(cind, :));
%     freq
%     freqs(cind) = freq;
%     initcs(1+cind, :) = initc;
% end
% save('matfiles/fi_results/fromabove_poly.mat','current','freqs', 'initcs')

current1 = linspace(0, 11, 200)';
current2 = linspace(11, 60, 50)';
current = [current1; current2];
totnumcurr = size(current, 1);

freqs = zeros(totnumcurr, 1);
initcs = zeros(totnumcurr, 3);
initcs(1, :) = [-70.0200,    0.3164,    0.0523];
prevfreq = 0;
for cind=1:totnumcurr
    curr = current(cind)
    [freq, initc] = f_for_i(@HH_orig, current(cind), initcs(cind, :));
    freq
    freqs(cind) = freq;
    initcs(1+cind, :) = initc;
end
save('matfiles/fi_results/frombelow_orig.mat','current','freqs', 'initcs')

current = [flipud(current2); flipud(current1)];
totnumcurr = size(current, 1);

freqs = zeros(totnumcurr, 1);
initcs = zeros(totnumcurr, 3);
initcs(1, :) = [-70.0200,    0.3164,    0.0523];
prevfreq = 0;
for cind=1:totnumcurr
    curr = current(cind)
    [freq, initc] = f_for_i(@HH_orig, current(cind), initcs(cind, :));
    freq
    freqs(cind) = freq;
    initcs(1+cind, :) = initc;
end
save('matfiles/fi_results/fromabove_orig.mat','current','freqs', 'initcs')


end