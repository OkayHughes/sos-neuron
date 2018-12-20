function meta_opt()
    pies = [0.001, 0.5, 1];
    
    parfor i=1:3
        pie = pies(i);
        res = optimize_sync(pie);
        fprintf("pie=%1.2f: %1.4f\n", pie, res)
    end
end