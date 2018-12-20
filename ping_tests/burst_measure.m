function b = burst_measure(n, ts)
    assert(size(ts, 1) == n)
    T = size(ts, 2);
    mus = (1/(T-1) * sum(ts, 2)).^2;
    Sis = (1/sum(T-1)) * sum(ts.^2, 2) - mus;
    Vt = sum(ts)/n;
    muall = (1/(T-1) * sum(Vt, 2)).^2;
    S = (1/sum(T-1)) * sum(Vt.^2, 2) - muall;
    b = S/mean(Sis);
end