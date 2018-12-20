function res = optimize_sync(pie)
    
    ub = [0.005, .005, 0.005, 0.005, 0.005, 0.005];
    lb = -1 * ub;
    hand = params(pie);
    [b, m, c] = sim_gamma(zeros(1, 6), hand);
    nom_vals = [b, m, c];
    ob_fun = @(x) obj_fun_sync(x, nom_vals, hand, pie);
    opts = optimoptions('particleswarm', 'Display', 'iter', 'HybridFcn',@fmincon, "MaxIterations", 3, 'SwarmSize', 100);
    [param, res] = particleswarm(ob_fun,6,lb,ub, opts);
    save("res.mat", "param")

end