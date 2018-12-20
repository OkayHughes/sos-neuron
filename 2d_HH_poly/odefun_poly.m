function fun = odefun_poly(I_app)
        odefun = gen_poly_HH('matfiles/polyvecs/an.mat', 'matfiles/polyvecs/bn.mat', "matfiles/polyvecs/am.mat", "matfiles/polyvecs/bm.mat");
    fun = @(t, v) odefun(v', I_app);
end