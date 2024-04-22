% INPUT:
%       - phi:      vector of DOF weights
%       - space:    object defining the discrete space (sp_scalar)
%       - geometry: geometry structure (geo_load)
%       - vtk_pts:  cell array with coordinates of points along each parametric direction
%       - filename: output filename
%       - iptc: patch index

function plot_es_dat (phi, space, geometry, vtk_pts, filename, iptc)
    [E, F] = sp_eval (phi, space, geometry, vtk_pts, 'gradient');
    E = squeeze(sqrt(E(1,:,:).^2 + E(2,:,:).^2));

    ndim = numel (space.knots);
    rdim = size (F, 1);
    if (ndim == 2)
        if (rdim == 2)
            [X, Y] = deal(squeeze(F(1,:,:)), squeeze(F(2,:,:)));
            surf(X, Y, E);
            write_dat3D([filename '_' num2str(iptc) '.dat'], X, Y, E);
        elseif (rdim == 3)
            [X, Y, Z] = deal(squeeze(F(1,:,:)), squeeze(F(2,:,:)), squeeze(F(3,:,:)));
            surf(X, Y, Z, E);
        end
    end
end
