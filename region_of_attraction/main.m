function [dvdt, dndt, dmdt] = scaled_dynamics(I_app)
[dvdt, dndt, dmdt] = gen_msspoly_HH("matfiles/polyvecs/an.mat", "matfiles/polyvecs/bn.mat", "matfiles/polyvecs/am.mat", "matfiles/polyvecs/bm.mat");
dvdt = subs(dvdt, iapp_var(), I_app);
dvdt = subs(dvdt, vvar(), v_inv_change());
dndt = subs(dndt, vvar(), v_inv_change());
dmdt = subs(dmdt, vvar(), v_inv_change());


end



