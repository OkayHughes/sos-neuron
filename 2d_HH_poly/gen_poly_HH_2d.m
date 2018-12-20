function fun = gen_poly_HH_2d(minf_fname, a_fname, b_fname)
    r = load(minf_fname);
    m_inf_poly = full(r.minf);
    an_poly = load(a_fname);
    an_poly = full(an_poly.a);
    bn_poly = load(b_fname);
    bn_poly = full(bn_poly.b);
    fun = @(x, I_app) dxdt(m_inf_poly, an_poly, bn_poly, x, I_app);
end

function [xdot, minfres, nterm, vterm, I_na] = dxdt(m_inf_poly, an_poly, bn_poly, x, I_app)
    C = 1;
    g_na = 120;
    g_k = 36;
    g_l = 0.3;
    E_na = 45;
    E_k = -82;
    E_l = -59;
    v = x(:, 1);
    n = x(:, 2);
    
    minfres = polyval(m_inf_poly, v);
    nterm = (0.83-n);
    vterm = (E_na - v);
    
    I_na = g_na * polyval(m_inf_poly, v).*(0.83-n).*(E_na - v);
    I_k = g_k .* n.^4 .* (E_k - v);
    I_l = g_l * (E_l - v);
    
    dvdt = (I_na + I_k + I_l + I_app)/C;
    
    dndt = polyval(an_poly, v) .* (1-n) - polyval(bn_poly, v) .* n;
    
    xdot = [dvdt'; dndt';];
    
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