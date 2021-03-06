function test_sim()
[dvdt, dndt, dmdt] = scaled_dynamics(8);
odefun = @(t, v) [dmsubs(dvdt, [vvar; nvar; mvar], v)*15; dmsubs(dndt, [vvar; nvar; mvar], v)*15; dmsubs(dmdt, [vvar; nvar; mvar], v)*15];
initcs = [ -0.6711597703; 0.3904224355; 0.0884744082];
[t, vs] = ode15s(odefun, [0, 1], initcs);
fprintf("%3.10f", vs(end, 3))
assert False;

spacing = 8;
theta_sp = linspace(-pi, pi, spacing);
ring_x = sin(theta_sp);
ring_y = cos(theta_sp);
vs_sp = [linspace(-1, -0.9, spacing/4)'; linspace(-0.9, 0.9, spacing)'; linspace(0.9, 1, spacing/4)']
vs = ones(1.5*spacing^2, 1);
ns = ones(1.5*spacing^2, 1);
ms = ones(1.5*spacing^2, 1);
for i=1:1.5*spacing
    vs((i-1)*spacing + 1:i*spacing) = vs_sp(i) * ones(spacing, 1);
    rad = sqrt(1-vs_sp(i)^2)
    ms((i-1)*spacing + 1:i*spacing) = rad * ring_y;
    ns((i-1)*spacing + 1:i*spacing) = rad * ring_x;
end
figure
scatter3(vs, ms, ns)

vs = ((vs/2) * 0.02 + initcs(1)) ;
ns = ((ns/2) * 0.005 + initcs(2 )) ;
ms = ((ms/2) * 0.01 + initcs(3)) ;

hXT = -((vvar - initcs(1))^2/0.0005^2 + (nvar - initcs(2))^2/0.0005^2 + (mvar - initcs(3))^2/0.0005^2);
mean(dmsubs(hXT, [vvar;nvar;mvar], [vs';ns'; ms']))
dmsubs(hXT, [vvar;nvar;mvar], initcs)
assert False;

% vs = linspace(initcs(1) - 0.01, initcs(1) + 0.01, 4)';
% ns = linspace(initcs(2) - 0.002, initcs(2) + 0.002, 4);
% ms = linspace(initcs(3) - 0.002, initcs(3) + 0.002, 4);
% [X, Y, Z] = meshgrid(vs, ns, ms);
% vs = reshape(X, [numel(X), 1]);
% ns = reshape(Y, [numel(Y), 1]);
% ms = reshape(Z, [numel(Z), 1]);
pts = [vs, ns, ms];
size(pts)
figure; hold on;
for i=1:size(pts, 1)
    i
    [ts, vs, te, ve, ie] = sim_model(0, 1, odefun, pts(i, :));
    plot(ts, vs(:, 1))
    if(numel(te) > 0)
        break
    end
end

end