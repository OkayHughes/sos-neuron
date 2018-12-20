function [msspol] = mss_from_polyval(polyvec, var)
    degree = size(polyvec, 2) - 1;
    mons = monomials(var, 0:degree);
    msspol = fliplr(polyvec)*mons;
end