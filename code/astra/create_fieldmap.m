% INPUT:
%       - filename: output filename
%       - nx:       number of points in x-direction
%       - ny:       number of points in y-direction
%       - nz:       number of points in z-direction
%       - geometry: nurbs geometry
%       - space:    GeoPDEs space
%       - phi:      GeoPDEs solution vector

function [] = create_fieldmap (filename, nx, ny, nz, geometry, space, phi)
    % (1.5 for Gaussian, 2.5 for laser)
    rho   = 2.5e-3;
    z_min = nrbeval(geometry(6).nurbs, [1 0]);
    z_min = z_min(1);
    z_max = nrbeval(geometry(1).nurbs, [0 1]);
    z_max = z_max(1);

    x = linspace(0, rho, nx);
    y = linspace(0, rho, ny);
    z = linspace(z_min, z_max, nz);

    tic;
    [E, Nx, Ny, Nz] = compute_fieldmap (geometry, space, phi, x, y, z);
    fprintf('\ncreate_fieldmap: %d min\n', toc/60)

    % axisymmetry
    x = [-flip(x(2:end)) x];
    y = [-flip(y(2:end)) y];
    Nx = 2*Nx-1;
    Ny = 2*Ny-1;

    % E-field in MV/m for Astra
    tic;
    write_fieldmap (filename, Nx, x, Ny, y, Nz, z, E*1e-6);
    fprintf('\nwrite_fieldmap: %d min\n', toc/60);
end
