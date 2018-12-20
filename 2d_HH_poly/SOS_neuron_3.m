
function SOS_neuron()

dim = 15;

variables = msspoly('x');
degree = 10;
S_bounds = [-1, 1];

mons = monomials(variables, 0:dim);
vec = load("matfiles/polyvecs/minf_reg_scaled.mat");
vec = fliplr(vec.minf);
size(vec)
constpoly = vec*mons;

% evl = linspace(-1, 1, 100);
% ys = dmsubs(constpoly, variables, evl);
% min(ys)
% 
% figure;
% plot(evl, ys);

%run spotless problem
hS = -(variables-(-1)).*(variables-(1));
hS1 = -(variables-(-1)).*(variables-(-0.6));
hS2 = -(variables-(-0.6)).*(variables-(0));
hS3 = -(variables-(0)).*(variables-(1));
dl=boxMoments(variables, S_bounds(:, 1), S_bounds(:, 2));
prog = spotsosprog;
prog = prog.withIndeterminate(variables);
wmonom = monomials(variables, 0:degree);
s1monom = monomials(variables, 0:0);
s2monom = monomials(variables, 0:0);
s3monom = monomials(variables, 0:0);
[prog, w, wcoeff] = prog.newFreePoly(wmonom);
[prog, s1, s1coeff] = prog.newFreePoly(s1monom);
[prog, s2, s2coeff] = prog.newFreePoly(s2monom);
[prog, s3, s3coeff] = prog.newFreePoly(s3monom);
prog = sosOnK(prog, constpoly - w + s1, variables, hS1, dim) ;
prog = sosOnK(prog, w - constpoly + s1, variables, hS1, dim) ;
prog = sosOnK(prog, constpoly - w + s2, variables, hS2, dim) ;
prog = sosOnK(prog, w - constpoly + s2, variables, hS2, dim) ;
prog = sosOnK(prog, constpoly - w + s3, variables, hS3, dim) ;
prog = sosOnK(prog, w - constpoly + s3, variables, hS3, dim) ;
prog = sosOnK(prog, diff(w, variables), variables, hS, degree);
prog = sosOnK(prog, w, variables, hS, degree);
prog = sosOnK(prog, 1-w, variables, hS, degree);
obj = 2*s1coeff + 1*s2coeff + s3coeff;

options = spot_sdp_default_options();
options.verbose = 1;
sol = prog.minimize(obj, @spot_mosek, options);

fspotless = sol.eval(w) ;
s1 = sol.eval(s1)
s2 = sol.eval(s2)
s3 = sol.eval(s3)

close all
figure ; cla ; hold on ;

tvec = linspace(-1,1,500) ;

test = dmsubs(fspotless, variables, tvec);
const = dmsubs(constpoly, variables, tvec);



ub = 60;
lb = -90;
shift = (ub - lb)/2 - ub;
scale = (ub-lb)/2;
test2 = subs(fspotless, variables, (variables+ shift)/scale);
const2 = subs(constpoly, variables, (variables+ shift)/scale);

tvec = linspace(lb,ub,1000);
test2 = (test2 + 0.005) * 0.992;
vals = dmsubs(test2, variables, tvec);
vals2 = dmsubs(const2, variables, tvec);

plot(tvec, vals);
plot(tvec, vals2);
min(vals)
max(vals)

minf = test2;
save("matfiles/msspolys/minf_sos.mat", "minf");

[~, ~, minf_sos] = decomp(minf);
minf = full(fliplr(minf_sos));
save("matfiles/polyvecs/minf_sos.mat", "minf");


minf = const2;
save("matfiles/msspolys/minf_reg.mat", "minf");

[~, ~, minf_sos] = decomp(minf);
minf = full(fliplr(minf_sos));
save("matfiles/polyvecs/minf_reg.mat", "minf");

legend("Result", "Approximand")


end
