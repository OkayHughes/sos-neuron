minf_sos = load("matfiles/polyvecs/minf_sos.mat");
minf_sos = minf_sos.minf;
minf_reg = load("matfiles/polyvecs/minf_reg.mat");
minf_reg = minf_reg.minf;

vs = linspace(-90, 60, 1000);
minf_orig = m_inf(vs);
minf_sos = polyval(minf_sos, vs);
minf_reg = polyval(minf_reg, vs);

figure; hold on;
xtickformat("%0.1f mV")
plot(vs, minf_orig.^3);
plot(vs, minf_sos);
plot(vs, minf_reg);
legend("m_{\infty, reg}^3", "m_{\infty, sos}^3", "m_\infty^3")
saveas(gcf, "figs/gating_funcs/minf.png");


function m = m_inf(v)
    m = alpha_m(v)./(alpha_m(v) + beta_m(v));
end
function am = alpha_m(v)
    am = ((v + 45)./10)./(1-exp(-(v+45)/10));
end
function bm = beta_m(v)
    bm = 4*exp(-(v+70)/18);
end