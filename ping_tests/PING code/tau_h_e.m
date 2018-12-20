function tau_h_e=tau_h_e(v, pert_a, pert_b);
alpha_h=0.128*exp(-(v+50)/18) + pert_a;
beta_h=4./(1+exp(-(v+27)/5)) + pert_b;
tau_h_e=1./(alpha_h+beta_h);
