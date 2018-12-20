function plotting_experiments(I_app)
    odefun = odefun_poly(I_app);
    [t, v] = sim_model(1, 100, odefun, [-70.0410    0.3170    0.0527]);
    spiketrace(t, v, "oof");
    v(end, :)

end