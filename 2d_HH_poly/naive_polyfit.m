function naive_polyfit()
ub = 60;
lb = -90;
shift = (ub - lb)/2 - ub;
scale = (ub-lb)/2;
I_app = 8;
odefun = @(t, v) dxdt(t, v, I_app);
tspan = [0, 100];
v0 = [-70.0433, 0.3170];
vs = linspace(lb, ub, 1000);
min((vs+shift))
max((vs+shift))
an = alpha_n(vs);
bn = beta_n(vs);
am = alpha_m(vs);
bm = beta_m(vs);

n=6;
an_p = polyfit(vs,an,n);
bn_p = polyfit(vs,bn,n);

am_p = polyfit(vs,am,n);
bm_p = polyfit(vs,bm,n);

a = an_p;
b = bn_p;
save("matfiles/polyvecs/an.mat", "a")
save("matfiles/polyvecs/bn.mat", "b")
a = am_p;
b = bm_p;
save("matfiles/polyvecs/am.mat", "a")
save("matfiles/polyvecs/bm.mat", "b")

an_poly = polyval(an_p, vs);
bn_poly = polyval(bn_p, vs);

am_poly = polyval(am_p, vs);
bm_poly = polyval(bm_p, vs);

figure; hold on;
title("\alpha_m")
xtickformat("%d mV")
plot(vs, am)
plot(vs, am_poly)


legend("\alpha_{m}", "\alpha_{m, poly}");
saveas(gcf, "alpham_fit.png")

figure; hold on;
title("\beta_m")
xtickformat("%d mV")
plot(vs, bm)
plot(vs, bm_poly)

legend("\beta_{m}", "\beta_{m, poly}");
saveas(gcf, "betam_fit.png")

figure; hold on;
title("\alpha_n")
xtickformat("%d mV")
plot(vs, an)
plot(vs, an_poly)


legend("\alpha_{n}", "\alpha_{n, poly}");
saveas(gcf, "alphan_fit.png")

figure; hold on;
title("\beta_n")
xtickformat("%d mV")
plot(vs, bn)
plot(vs, bn_poly)


legend("\beta_{n}", "\beta_{n, poly}");
saveas(gcf, "betan_fit.png")

legend();

figure; hold on;
plot(vs,an)
plot(vs,bn)

plot(vs,an_poly)
plot(vs,bn_poly)

legend("\alpha_n", "\beta_n", "\alpha_{n, poly}", "\beta_{n, poly}");

figure; hold on;

plot(vs,am)
plot(vs,bm)

plot(vs,am_poly)
plot(vs,bm_poly)

legend("\alpha_m", "\beta_m", "\alpha_{m, poly}", "\beta_{m, poly}");

function xdot = dxdt(t, x, I_app)
    C = 1;
    g_na = 120;
    g_k = 36;
    g_l = 0.3;
    E_na = 45;
    E_k = -82;
    E_l = -59;
    v = x(1);
    n = x(2);
    
    I_na = g_na * m_inf(v).^3.*(0.83-n).*(E_na - v);
    I_k = g_k .* n.^4 * (E_k - v);
    I_l = g_l * (E_l - v);
    
    dvdt = (I_na + I_k + I_l + I_app)/C;
    
    dndt = (n_inf(v) - n)/(tau_n(v));
    
    xdot = [dvdt; dndt];
    
end
function m = m_inf(v)
    m = alpha_m(v)./(alpha_m(v) + beta_m(v));
end
function t = tau_n(v)
    t = 1./(alpha_n(v) + beta_n(v));
end
function n = n_inf(v)
    n = alpha_n(v)./(alpha_n(v) + beta_n(v));
end
function am = alpha_m(v)
    am = ((v + 45)./10)./(1-exp(-(v+45)/10));
end
function bm = beta_m(v)
    bm = 4*exp(-(v+70)/18);
end
function an = alpha_n(v)
   an = (1/100)*(v+60)./(1-exp(-(v+60)/10));
end
function bn = beta_n(v)
   bn = (1/8) * exp(-(v+70)/80);
end
end