function [freq, vend] = f_for_i(model, i, initc)
    odefun = @(t, v) model(v', i);
    [~, vs, te] = sim_model(0, 1000, odefun, initc);
    filt = (te > 500) & (te < 1000);
    tetemp = te(filt);
    if (numel(te) == 0)
        freq = 0;
    else
        spike_time = mean(tetemp(2:end) - tetemp(1:end-1));
        freq = 1/spike_time * 1000;
    end
    vend = vs(end, :);

end