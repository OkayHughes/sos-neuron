function res = obj_func(x)
    [~,~, te, ie] = HH_ring(6.2, x);
    x
    res = numel(te(ie~=1))
    if(res == 0)
        vec = load("best.mat");
        if(max(abs(vec.x)) > max(abs(x)))
            save("best.mat", "x")
        end
        
    end
end