% variables from create_fieldmap() and geometry_v6_orig
rho = 1.5e-3;
dz  = 447e-3 - 307e-3;

[err_linf] = compute_astra_error ()

% integrator
% H_ref = -13;
% H_it  = [-8 -9 -10 -11 -12 -13];

% [err_linf] = compute_int_error (H_ref, H_it);

% fieldmap
% nx_ref = 6;
% nz_ref = 6;
% nx_it  = [3 4 5];
% nz_it  = [6];

% nx_ref = 3;
% nz_ref = 9;
% nx_it  = [3];
% nz_it  = [4 5 6 7 8];

% [err_linf] = compute_map_error (nx_ref, nz_ref, nx_it, nz_it, rho, dz);

% space charge
% nI_ref = 10;
% nr_ref = 6;
% nc_ref = 1;
% nl_ref = 6;
% nI_it  = [10];
% nr_it  = [4 5 6];
% nc_it  = [1];
% nl_it  = [4 5 6];

% nI_ref = 12;
% nr_ref = 6;
% nc_ref = 1;
% nl_ref = 6;
% nI_it  = [9 10 11];
% nr_it  = [6];
% nc_it  = [1];
% nl_it  = [6];

% nI_ref = 10;
% nr_ref = 6;
% nc_ref = 2;
% nl_ref = 6;
% nI_it  = [10];
% nr_it  = [6];
% nc_it  = [-1 0 1 2];
% nl_it  = [6];

% [err_linf] = compute_sc_error (nI_ref, nr_ref, nc_ref, nl_ref, nI_it, nr_it, nc_it, nl_it, rho, dz);
