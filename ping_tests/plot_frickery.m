
v = linspace(-100, 100, 400);

figure; hold on;
title("\alpha_m")
plot(v, alpham(v))
plot(v, alpham(v) + perturb(1))
xtickformat('%1.0f mV')
legend("\alpha_m", "\alpha_{m, perturbed}")
saveas(gcf, "alpham_pert.png")
%.25

figure; hold on;
title("\beta_m")
plot(v, betam(v))
plot(v, betam(v)+ perturb(2))
xtickformat('%1.0f mV')
saveas(gcf, "betam.png")
%1

figure; hold on;
title("\alpha_h")
plot(v, alphah(v))
plot(v, alphah(v) + perturb(5))
xtickformat('%1.0f mV')
legend("\alpha_h", "\alpha_{h, perturbed}")
saveas(gcf, "alphah_pert.png")
%0.01


figure; hold on;
title("\beta_h")
plot(v, betah(v) )
plot(v, betah(v) + perturb(6))
xtickformat('%1.0f mV')
saveas(gcf, "betah.png")
%.01


figure; hold on;
title("\alpha_n")
plot(v, alphan(v))
plot(v, alphan(v) + perturb(3))
xtickformat('%1.0f mV')
legend("\alpha_n", "\alpha_{n, perturbed}")
saveas(gcf, "alphan_pert.png")
%0.05

figure; hold on;
title("\beta_n")
plot(v, betan(v))
plot(v, betan(v) + perturb(4))
xtickformat('%1.0f mV')
saveas(gcf, "betan.png")
%0.01
function am=alpham(x)
    am=0.1*(x+35)./(1-exp(-(x+35)/10)) ;
end

function bm=betam(x)
    bm=4*exp(-(x+60)/18);
end

function ah=alphah(x)
    ah=0.07*exp(-(x+58)/20) ;
end

function bh=betah(x)
    bh=1./(exp(-0.1*(x+28))+1);
end

function an=alphan(x)
    an=-0.01*(x+34)./(exp(-0.1*(x+34))-1) ;
end

function bn=betan(x)
    bn=0.125*exp(-(x+44)/80);
end
