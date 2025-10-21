%% Plots the geometry and computes the field solution.
clear all
addpath(genpath('.'))
pkg load nurbs
pkg load geopdes

%% Parse geometry
geometry_file = 'geometry_v6_orig';
% geometry_file = 'nlopt_fit';
% geometry_file = 'electrode_v6';
% geometry_file = 'v6_opt_order=8_continuity=6_run6';
% geometry_file = 'v6_opt_order=8_run6_tp';

[geo, bnds] = mp_geo_load ([geometry_file '.txt']);

geo_bnds = [];
for bnd = bnds
    for i = 1:bnd.nsides
        nurbs = geo(bnd.patches(i));
        side = nurbs.boundary(bnd.faces(i));
        geo_bnds = [geo_bnds, side];
    end
end

%% Write to IGES
idx = 1:length(geo);
write_iges_2d("out/geometry_v6_orig", geo, idx);

idx = 1:length(geo_bnds);
write_iges_2d("out/geometry_bnd_v6_orig", geo_bnds, idx);
