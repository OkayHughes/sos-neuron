
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
hS = -(variables-S_bounds(:, 1)).*(variables-S_bounds(:, 2));
dl=boxMoments(variables, S_bounds(:, 1), S_bounds(:, 2));
prog = spotsosprog;
prog = prog.withIndeterminate(variables);
wmonom = monomials(variables, 0:degree);
smonom = monomials(variables, 0:0);
[prog, w, wcoeff] = prog.newFreePoly(wmonom);
[prog, s, scoeff] = prog.newFreePoly(smonom);
prog = sosOnK(prog, constpoly - w + s, variables, hS, dim) ;
prog = sosOnK(prog, w - constpoly + s, variables, hS, dim) ;
prog = sosOnK(prog, diff(w, variables), variables, hS, degree);
obj = dl(smonom)' * scoeff ;

options = spot_sdp_default_options();
options.verbose = 1;
sol = prog.minimize(obj, @spot_mosek, options);

fspotless = sol.eval(w) ;
s = sol.eval(s)

close all
figure ; cla ; hold on ;

tvec = linspace(-1,1,500) ;

test = dmsubs(fspotless, variables, tvec);
const = dmsubs(constpoly, variables, tvec);



ub = 100;
lb = -100;
shift = (ub - lb)/2 - ub;
scale = (ub-lb)/2;
test2 = subs(fspotless, variables, (variables/scale) - shift);
const2 = subs(constpoly, variables, (variables/scale) - shift);

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
