
function SOS_neuron()

dim = 20;

variables = msspoly('x');
degree = 15;
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
% assert False

%run spotless problem
hS = -(variables-S_bounds(:, 1)).*(variables-S_bounds(:, 2));
dl=boxMoments(variables, S_bounds(:, 1), S_bounds(:, 2));
prog = spotsosprog;
prog = prog.withIndeterminate(variables);
wmonom = monomials(variables, 0:degree);
[prog, w, wcoeff] = prog.newFreePoly(wmonom);
prog = sosOnK(prog, constpoly-w , variables, hS, dim) ;
prog = sosOnK(prog, w+0.005, variables, hS, degree);
prog = sosOnK(prog, diff(w, variables), variables, hS, degree);
obj = -dl(wmonom)' * wcoeff ;

options = spot_sdp_default_options();
options.verbose = 1;
sol = prog.minimize(obj, @spot_mosek, options);

fspotless = sol.eval(w) ;

close all
figure ; cla ; hold on ;

tvec = linspace(-1,1,500) ;


test = dmsubs(fspotless, variables, tvec);
const = dmsubs(constpoly, variables, tvec);

% figure(); hold on;
% plot(tvec, test)
% plot(tvec, const)
% 
% assert false


ub = 60;
lb = -90;
shift = (ub-lb)/2 - ub;
scale = (ub-lb)/2;
test2 = subs(fspotless, variables, (variables+ shift)/scale);
const2 = subs(constpoly, variables, (variables+shift)/scale);


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
