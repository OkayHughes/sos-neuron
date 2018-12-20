function tau_h_i=tau_h_i(v, pert_a, pert_b);
alpha_h=0.07*exp(-(v+58)/20) + pert_a;
beta_h=1./(exp(-0.1*(v+28))+1) + pert_b;
tau_h_i=1./(alpha_h+beta_h); 
phi=5; tau_h_i=tau_h_i/phi;
