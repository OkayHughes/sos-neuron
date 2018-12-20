function tau_n_e=tau_n_e(v, pert_a, pert_b);
alpha_n=0.032*(v+52)./(1-exp(-(v+52)/5)) + pert_a;
beta_n=0.5*exp(-(v+57)/40) + pert_b;
tau_n_e=1./(alpha_n+beta_n);
