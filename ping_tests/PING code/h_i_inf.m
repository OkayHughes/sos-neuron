function h_i_inf=h_i_inf(v, pert_a, pert_b);
alpha_h=0.07*exp(-(v+58)/20) + pert_a;
beta_h=1./(exp(-0.1*(v+28))+1) + pert_b;
h_i_inf=alpha_h./(alpha_h+beta_h);