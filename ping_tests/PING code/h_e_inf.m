function h_e_inf=h_e_inf(v, pert_a, pert_b);
alpha_h=0.128*exp(-(v+50)/18) + pert_a;
beta_h=4./(1+exp(-(v+27)/5)) + pert_b;
h_e_inf=alpha_h./(alpha_h+beta_h);