%% Plots the geometry and computes the field solution.
addpath(genpath('.'))
pkg load nurbs
pkg load geopdes

%% Parse geometry
geometry_file = 'geometry_v6_orig';
% geometry_file = 'nlopt_fit';
% geometry_file = 'electrode_v6';
% geometry_file = 'v6_opt_order=8_continuity=6_run6';
% geometry_file = 'v6_opt_order=8_run6_tp';

[geometry, boundaries] = mp_geo_load ([geometry_file '.txt']);

% write .dat files
% write_boundary (geometry);
% write_geometry (geometry);

plot_geometry (geometry, boundaries);
return
% solve electrostatic problem
[problem_data, method_data] = setup_problem (geometry_file);
tic;
[geometry, msh, space, phi] = mp_solve_electrostatics_axi2d (problem_data, method_data);
save(['phi_degree=' num2str(method_data.degree(1)) '_nsub=' num2str(method_data.nsub(1)) '.mat'], 'phi');
fprintf('\nmp_solve_electrostatics_axi2d: %d min\n', toc/60);

% plot magnitude of electric field and write .dat files
npts = 8;
vtk_pts = {linspace(0, 1, npts), linspace(0, 1, npts)};
plot_es_mp (phi, space, geometry, vtk_pts, ['E_degree=' num2str(method_data.degree(1)) '_nsub=' num2str(method_data.nsub(1)) '_npts=' num2str(npts)]);
view(2);
return
% write .vtk files
sp_to_vtk (phi, space, geometry, method_data.nsub, ['E_degree=' num2str(method_data.degree(1)) ...
           '_nsub=' num2str(method_data.nsub(1))], 'E', 'gradient');

% signal that the program is finished
x = linspace(1, 20, 8000);
Y = sin(2*pi*440*x);
sound(Y);
