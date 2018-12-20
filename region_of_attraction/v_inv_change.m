function inv_change = v_inv_change()
    vr = vvar();
    ub = 60;
    lb = -90;
    shift = (ub - lb)/2 - ub;
    scale = (ub - lb)/2;
    inv_change = (vr * scale ) - shift;
end