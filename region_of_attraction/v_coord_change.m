function coord_change = v_coord_change()
    vr = vvar();
    ub = 60;
    lb = -90;
    shift = (ub - lb)/2 - ub;
    scale = (ub - lb)/2;
    coord_change = (vr + shift) / scale;
end