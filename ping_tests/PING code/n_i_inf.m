function n_i_inf=n_i_inf(v, pert_a, pert_b);
alpha_n=-0.01*(v+34)./(exp(-0.1*(v+34))-1) + pert_a;
beta_n=0.125*exp(-(v+44)/80) + pert_b;
n_i_inf=alpha_n./(alpha_n+beta_n);
