The code contains several sections devoted to the different experiments that were done in this project. 

##2d_HH_poly

`SOS_neuron.m/SOS_neuron_2.m/SOS_neuron_3.m/SOS_neuron4.m/`: These files are meant to attempt to approximate m_inf^3 using a polynomial that is less than 10th degree. None of them were particularly successful.

`f_for_i.m`: Calculates firing frequency of a neuron model for a constant applied current.
`fi_curve.m`: Calculates the F-I curves for polynomial and non-polynomial 3-d models.
`fi_plots_2d.m`: plots the F-I curves for the 2d models. 
`fi_plots.m`: generates F-I curve plots for the 3d models.
`gen_poly_HH_2d`: creates a function which describes state space dynamics for the 2d HH reduction from mat files that describe the gating functions.
`gen_poly_HH` creates a function which describes the dynamics for 3d HH reduction from mat files that describe the gating functions.

`HH_orig` function that describes the original HH reductions that can be used with ode15

`naive_polyfit_2d` Does the polynomial regression for the 2 dimensional models

`naive_polyfit` Does the polynomial regression for the 3 dimensional models
`odefun_poly_2d` creates a function that can be passed to ode15 so the 2d polynomial model can be simulated.
`odefun_poly` creates a function that can be passed to ode15 so the 3d polynomial model can be simulated.
`plot_minfs` generates figure in the paper
`plot_onset` examines the behaviour of the model around the onset of firing to make sure that the neuron models behave sensibly.
`plots_3d` generates spiketrace plots for the 3d model in the paper
`setup.m` adds mosek and spotless to the MATLAB path so the code can run.
`sim_model` simulates a model for a specified period of time.
`spiketrace` function which plots spike traces using consistent formatting so I don't have to keep copy-pasting.

##spotless_utils
utilities that help me write cleaner spotless code.

##find_problems
`HH_ring_show` simulate the model with given initial conditions and plot result.
`HH_ring` simulate simple 1-D network from paper.
`obj_func` Used some optimization to help me find a perturbation that broke the network.
`plot_frickery` used to visualize the alpha and beta functions


##ping_tests
`burst_measure` calculates golomb bursting measure
`crcorr_network` calculates cross correlation for a neural network
`gen_plot_for_paper` generates raster plots for paper.
`meta_opt` run optimization for different values of p_{e \to i}
`mpc_network` calculates Mean Phase Coherence for a network
`obj_fun_sync` calculates amount that synchrony is disturbed for a network perturbation.
`obj_fun` calculates the disturbance in average exitatory frequency for a network perturbation.
`optimize_sync` run particle swarm optimization trying to maximally disturb synchrony
`optimize` run particle swarm optimization trying to maximally disturb exitatory frequency
`params` generate mat file with PING network parameters for a given p_{e \to i} value
`sim_gamma` function which runs the PING network for a given disturbance and reports the synchrony and average frequency values.
`spiketraces` generates spiketraces using gaussian convolution from a sequence of spike times.

##region_of_attraction

`compare_dynamics` samples the state space of a dynamical system and calculates the mean l2 distance between the samples.
`gen_msspoly_HH' creates a function that defines a 3d polynomial HH model using msspoly (spotless utility). 
`gen_poly_HH` same as `2d_HH_poly`
`iapp_var`, `mvar`, `vvar`, `nvar`: helper functions which return an msspoly representing one of the state variables (or the variable representing applied current)
`mss_from_polyval` converts vector that's used with MATLAB's polyval into an msspoly.
`plots_for_paper_small_roa` last ditch attempt to get an actual picture of the ROA for the paper.
`plots_for_paper` plot the ROA that seems to have actually worked for the paper.
`scaled_dynamics` apply the change-of-variables described in the paper.
`setup` Adds spotless and mosek to the path
`sim_model` Simulate the scaled model so I can make sure that my numbers match up when I'm calculating X_T
`SOS_main_smaller_roa` runs the SOS program to calculate the ROA of the equilibrium when the neuron is bistable.
`SOS_main` runs the SOS program to calculate the ROA of the equilibrium when there is no current applied to the neuron.
`SOS_vdp` test that we can calculate the region of the attraction of the Van-der-pol oscillator, like in the original paper that the program came from.
`test_sim.m` Run simulations to find a suitable ellipsoid and box around the equilibrium.
`test_vdp` plot result of SOS_vdp to make sure that its sane.
`v_coord_change` msspoly representation of the change of variables represented in the paper
`v_inv_change` inverse coordinate change, for scaling w so that it represents the original region of attraction, in unscaled dynamics

