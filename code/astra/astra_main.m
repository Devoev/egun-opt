pkg load statistics;

geometry_file = 'v6_opt_order=8_run6';
% geometry_file = 'geometry_v6_orig';

[geometry] = mp_geo_load ([geometry_file '.txt']);
[problem_data, method_data] = setup_problem (geometry_file);
% tic;
% [geometry, msh, space, phi] = mp_solve_electrostatics_axi2d (problem_data, method_data);
% fprintf('\n field solution: %d min \n', toc/60);

% fieldtable
% Nz = 2^9;
% tic;
% [E, z] = create_fieldtable (geometry, space, phi, Nz);
% fprintf('\n fieldtable creation: %d min \n', toc/60);

% number of particles (11 [9:12])
Ipart = 2^11;

% total charge in [nC] (100 fC => 100e-6 or 77 pC => 77e-3)
Q_total = 100e-6;

% sigma bunch length in [ns]
% 30 ps for 5e-3 (5 ps for 1e-3 (shows sc effect for individual trajectories))
sig_clock = 5e-3;

% generatorname = ['I=' num2str(Ipart) '_Q=' num2str(Q_total) '_sc=' num2str(sig_clock) '.in'];
generatorname = ['laser_I=' num2str(Ipart) '_Q=' num2str(Q_total) '_sc=' num2str(sig_clock) '.in'];
if (exist(generatorname, 'file') ~= 2)
   % create_laserinput(Ipart, sig_clock, Q_total, generatorname);
   % write_generatorinput (generatorname, Ipart, Q_total, sig_clock, geometry);
   % [status, output] = system(['./generator generator_' generatorname]);
   % plot_generator (generatorname);
end

% time step in [ns] (-12 [-13:-8])
H = 2^(-12);

% number of transverse grid points (3 convergence study) (4 simulation) ([3:6])
nx = ny = 2^4;
% number of longitudinal grid points (8 [4:9])
nz = 2^8;

fieldmapname = ['DC-3D-p=' num2str(method_data.degree(1)) '_nsub=' num2str(method_data.nsub(1)) '_nx=ny=' num2str(nx) '_nz=' num2str(nz)];
if (exist([fieldmapname '.ex']) ~= 2)
   create_fieldmap (fieldmapname, nx, ny, nz, geometry, space, phi);
end

% space charge
sc       = 1;
% number of radial cells (6 [4:6])
Nrad     = 2^6;
% size factor between innermost and outermost radial cell (1 [-1:2])
Cell_var = 2^(1);
% number of longitudinal cells (6 [4:6])
Nlong_in = 2^6;

% filename = ['photogun_H=' num2str(iH)];
% filename = ['photogun_nx=ny=' num2str(nx) '_nz=' num2str(nz)];
% filename = ['photogun_I=' num2str(Ipart) '_Nr=' num2str(Nrad) '_Cv=' num2str(Cell_var) '_Nl=' num2str(Nlong_in)];
filename = ['photogun'];
if (exist(filename, 'file') ~= 2)
   write_astrainput ([filename '.in'], generatorname, fieldmapname, H, sc, Nrad, Cell_var, Nlong_in, geometry);
end

tic;
[status, output] = system(['./Astra ' filename '.in']);
fprintf('\n tracking %d min \n', toc/60);
delete('NORRAN');
% delete([filename '.Log.001']);
% delete([filename '.track.001']);
delete('win_config.dat');

% signal that the program is finished
t = linspace(1, 20, 8000);
Y = sin(2*pi*440*t);
sound(Y);
return

plot_astra (filename);
[status, output] = system(['./lineplot ' filename]);
[status, output] = system(['./fieldplot ' filename]);
