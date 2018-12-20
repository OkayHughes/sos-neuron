function fun = odefun_poly_2d(fname, I_app)
    odefun = gen_poly_HH(fullfile('matfiles/polyvecs/', fname, "matfiles/polyvecs/a.mat", "matfiles/polyvecs/b.mat");
    fun = @(t, v) odefun(v', I_app);
end