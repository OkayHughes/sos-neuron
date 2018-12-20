function fighand = spiketrace(ts, vs, titl)
figure; hold on;
ylim([-100, 100]);
xtickformat('%1.0f ms')
ytickformat('%.1f mV')
plot(ts, vs(:, 1));
title(titl);
fighand = gcf;
end