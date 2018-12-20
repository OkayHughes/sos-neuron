function n_e_inf=n_e_inf(v, pert_a, pert_b);
alpha_n=0.032*(v+52)./(1-exp(-(v+52)/5)) + pert_a;
beta_n=0.5*exp(-(v+57)/40) + pert_b;
n_e_inf=alpha_n./(alpha_n+beta_n);
