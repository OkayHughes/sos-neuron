function res = optimize()
    ub = [0.041, .083, 0.0011, 0.005, 0.0044, 0.0005];
    lb = -1 * ub;
    opts = optimoptions('particleswarm', 'Display', 'iter', 'HybridFcn',@fmincon, "MaxIterations", 200, 'SwarmSize', 50);
    params = particleswarm(@obj_func,6,lb,ub, opts);
    save("res.mat", "params")

end