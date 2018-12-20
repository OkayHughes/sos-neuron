
function SOS_vdp()

xvars = [vvar; nvar];
svars = [tvar; vvar; nvar];
degree = 18;
degree_dynamics = 3;
X_bounds = [-1.1, 1.1; -1.1, 1.1];
S_bounds = [0, 1; -1.1, 1.1; -1.1, 1.1];

f = [-2*nvar; 0.8*vvar + 10 * (vvar^2 - 0.21)*nvar];

% evl = linspace(-1, 1, 100);
% ys = dmsubs(constpoly, variables, evl);
% min(ys)
% 
% figure;
% plot(evl, ys);

%run spotless problem
hS = -(svars-S_bounds(:, 1)).*(svars-S_bounds(:, 2));
hX = -(xvars-X_bounds(:, 1)).*(xvars-X_bounds(:, 2));
hS_bound = [ hS; -hS(2:end)];
hXT = -((vvar)^2/0.25^2 + (nvar)^2/0.25^2);

dl=boxMoments(xvars, X_bounds(:, 1), X_bounds(:, 2));
prog = spotsosprog;
prog = prog.withIndeterminate(svars);
wmonom = monomials(xvars, 0:degree);
vmonom = monomials(svars, 0:degree);

[prog, w, wcoeff] = prog.newFreePoly(wmonom);
[prog, v, vcoeff] = prog.newFreePoly(vmonom);


liouville = diff(v, tvar) + diff(v, xvars) * f;
prog = sosOnK(prog, -liouville, svars, hS, degree + degree_dynamics);
v0 = subs(v, tvar, 0);
prog = sosOnK(prog, w - v0 - 1, xvars, hX,degree + degree_dynamics);
vT = subs(v, tvar, 1);
prog = sosOnK(prog, vT, xvars, [-hXT; hX], degree + degree_dynamics);
prog = sosOnK(prog, v, svars, hS_bound, degree + degree_dynamics);
prog = sosOnK(prog, w, xvars, hX, degree + degree_dynamics);
obj = dl(wmonom)' * wcoeff ;

assert False;

options = spot_sdp_default_options();
options.verbose = 1;
sol = prog.minimize(obj, @spot_mosek, options);

fspotless = sol.eval(w) ;

save("poly.mat", "fspotless")

close all

diary off;

end
