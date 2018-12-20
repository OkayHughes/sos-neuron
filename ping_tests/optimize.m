function res = optimize()
    ub = [0.005, .005, 0.005, 0.005, 0.005, 0.005];
    lb = -1 * ub;
    opts = optimoptions('particleswarm', 'Display', 'iter', 'HybridFcn',@fmincon, "MaxIterations", 200, 'SwarmSize', 50);
    params = particleswarm(@obj_fun,6,lb,ub, opts);
    save("res.mat", "params")

end