function naive_polyfit_2d()
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

minf_eval = m_inf(vs);
minf_eval = minf_eval.^3;

n=4;
an_p = polyfit(vs,an,n);
bn_p = polyfit(vs,bn,n);
minf_p = polyfit((vs + shift)/scale,minf_eval,20);

a = an_p;
b = bn_p;
minf = minf_p;
save("matfiles/polyvecs/a.mat", "a")
save("matfiles/polyvecs/b.mat", "b")
save("matfiles/polyvecs/minf_reg_scaled.mat", "minf")

vars = msspoly('x', 1);
mons = monomials(vars, 0:n);
a_mss = fliplr(an_p) * mons;
b_mss = fliplr(bn_p) * mons;
a = a_mss;
b = b_mss;

save("matfiles/msspolys/a.mat", "a")
save("matfiles/msspolys/b.mat", "b")


an_poly = polyval(an_p, vs);
bn_poly = polyval(bn_p, vs);
minf_poly = polyval(minf_p, (vs+shift)/scale);



% options = odeset('MaxStep',1);
% [t,v] = ode15s(odefun,tspan,v0,options);
% 
% figure
% plot(t,v(:,1))

figure; hold on;
plot(vs,an)
plot(vs,bn)

plot(vs,an_poly)
plot(vs,bn_poly)

legend("\alpha_n", "\beta_n", "\alpha_{n, poly}", "\beta_{n, poly}", "m_\infty", "m_{\infty, poly}");

figure; hold on;
plot((vs+shift)/scale, minf_eval)
plot((vs+shift)/scale, minf_poly)
legend("minf", "minf poly")

legend("minf_{reg}", "minf_{orig}")

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