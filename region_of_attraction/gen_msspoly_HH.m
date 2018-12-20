
function [dvdt, dndt, dmdt] = gen_msspoly_HH(an_fname, bn_fname, am_fname, bm_fname)
    voltvar = vvar();
    an_poly = load(an_fname);
    an_poly = mss_from_polyval(full(an_poly.a), voltvar);
    bn_poly = load(bn_fname);
    bn_poly = mss_from_polyval(full(bn_poly.b), voltvar);
    am_poly = load(am_fname);
    am_poly = mss_from_polyval(full(am_poly.a), voltvar);
    bm_poly = load(bm_fname);
    bm_poly = mss_from_polyval(full(bm_poly.b), voltvar);
    [dvdt, dndt, dmdt] = dxdt(am_poly, bm_poly, an_poly, bn_poly);
end

% ub = 60;
% lb = -90;

function [dvdt, dndt, dmdt] = dxdt(am_poly, bm_poly, an_poly, bn_poly)
    C = 1;
    g_na = 120;
    g_k = 36;
    g_l = 0.3;
    E_na = 45;
    E_k = -82;
    E_l = -59;
    
    v = vvar();
    n = nvar();
    m = mvar();
    iapp = iapp_var();
    
    I_na = g_na * m^3*(0.83-n)*(E_na - v);
    I_k = g_k * n^4 .* (E_k - v);
    I_l = g_l * (E_l - v);
    
    dvdt = (I_na + I_k + I_l + iapp)/C;
    
    dndt = an_poly * (1-n) - bn_poly * n;
    
    dmdt = am_poly * (1-m) - bm_poly * m;
    
end
