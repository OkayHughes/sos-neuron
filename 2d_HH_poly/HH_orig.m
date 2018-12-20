function [xdot, nterm, vterm, I_na] = HH_orig(x, I_app)
    C = 1;
    g_na = 120;
    g_k = 36;
    g_l = 0.3;
    E_na = 45;
    E_k = -82;
    E_l = -59;
    v = x(:, 1);
    n = x(:, 2);
    m = x(:, 3);
    nterm = (0.83-n);
    vterm = (E_na - v);
    
    I_na = g_na * m.^3.*(0.83-n).*(E_na - v);
    I_k = g_k .* n.^4 .* (E_k - v);
    I_l = g_l * (E_l - v);
    
    dvdt = (I_na + I_k + I_l + I_app)/C;
    
    dndt = alpha_n(v).*(1-n) - beta_n(v) .* n;
    dmdt = alpha_m(v).*(1-m) - beta_m(v) .* m;
    
    xdot = [dvdt'; dndt'; dmdt'];
    
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
