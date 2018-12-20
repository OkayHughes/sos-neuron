function tau_n_i=tau_n_i(v, pert_a, pert_b);
alpha_n=-0.01*(v+34)./(exp(-0.1*(v+34))-1) + pert_a;
beta_n=0.125*exp(-(v+44)/80) + pert_b;
tau_n_i=1./(alpha_n+beta_n);
phi=5; tau_n_i=tau_n_i/phi;
