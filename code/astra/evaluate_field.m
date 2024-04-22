% INPUT:
%       - geometry: nurbs geometry
%       - space:    GeoPDEs space
%       - phi:      GeoPDEs solution vector
%       - x:        x-coordinates
%       - y:        y-coordinates
%       - z:        z-coordinates
% OUTPUT:
%       - E:        electric field values

function [E] = compute_fieldmap (geometry, space, phi, x, y, z)
    % transform cartesian to polar coordinates
    [theta, rho] = cart2pol(x, y);
    % transform to cartesian (parametric) coordinates
    [x_par, iptc] = phy2par([z rho 0], geometry);
    E_2d = -sp_eval (phi(space.gnum{iptc}), space.sp_patch{iptc}, geometry(iptc), {x_par(1), x_par(2)}, 'gradient');

    E = [E_2d(2)*cos(theta) E_2d(2)*sin(theta) E_2d(1)];
end
