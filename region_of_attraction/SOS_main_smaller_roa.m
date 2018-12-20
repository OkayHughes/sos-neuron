
function SOS_main()
diary log.txt
dim = 3;

xvars = [vvar; nvar; mvar];
svars = [tvar; vvar; nvar; mvar];
degree = 7;
degree_dynamics = 7;
X_bounds = [-1, 1; 0, 1; 0, 1];
S_bounds = [0, 1; -1, 1; 0, 1; 0, 1];

initcs = [ -0.6711597703; 0.3904224355; 0.0884744082];

[dvdt, dndt, dmdt] = scaled_dynamics(8);
f = [dvdt*15; dndt*15; dmdt*15];

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
hXT = -((vvar - initcs(1))^2/0.0005^2 + (nvar - initcs(2))^2/0.0005^2 + (mvar - initcs(3))^2/0.0005^2);

dl=boxMoments(xvars, X_bounds(:, 1), X_bounds(:, 2));
prog = spotsosprog;
prog = prog.withIndeterminate(svars);
wmonom = monomials(xvars, 0:degree);
vmonom = monomials(svars, 0:degree);

[prog, w, wcoeff] = prog.newFreePoly(wmonom);
[prog, v, vcoeff] = prog.newFreePoly(vmonom);


% prog = sosOnK(prog, constpoly - w + s1, variables, hS1, dim) ;
% prog = sosOnK(prog, w - constpoly + s1, variables, hS1, dim) ;

% prog = sosOnK(prog, constpoly - w + s2, variables, hS2, dim) ;
% prog = sosOnK(prog, w - constpoly + s2, variables, hS2, dim) ;
% prog = sosOnK(prog, constpoly - w + s3, variables, hS3, dim) ;
% prog = sosOnK(prog, w - constpoly + s3, variables, hS3, dim) ;
% prog = sosOnK(prog, diff(w, variables), variables, hS, degree);
% prog = sosOnK(prog, w, variables, hS, degree);
% prog = sosOnK(prog, 1-w, variables, hS, degree);
liouville = diff(v, tvar) + diff(v, xvars) * f;
prog = sosOnK(prog, -liouville, svars, hS,degree + degree_dynamics);
v0 = subs(v, tvar, 0);
prog = sosOnK(prog, w - v0 - 1, xvars, hX,degree + degree_dynamics);
vT = subs(v, tvar, 1);
prog = sosOnK(prog, vT, xvars, [-hXT; hX], degree + degree_dynamics);
prog = sosOnK(prog, v, svars, hS_bound, degree + degree_dynamics);
prog = sosOnK(prog, w, xvars, hX, degree + degree_dynamics);
obj = dl(wmonom)' * wcoeff ;

options = spot_sdp_default_options();
options.verbose = 1;
sol = prog.minimize(obj, @spot_mosek, options);

fspotless = sol.eval(w) ;

save("poly.mat", "fspotless")

close all

diary off;

end
