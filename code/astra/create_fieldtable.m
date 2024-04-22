% INPUT:
%       - geometry: nurbs geometry
%       - space:    GeoPDEs space
%       - phi:      GeoPDEs solution vector
%       - Nz:       number of point in z-direction
% OUTPUT:
%       - E: electric field values

function [E, z] = create_fieldtable (geometry, space, phi, Nz)
    z_min = nrbeval(geometry(6).nurbs, [1 0]);
    z_min = z_min(1);
    z_max = nrbeval(geometry(1).nurbs, [0 1]);
    z_max = z_max(1);

    z = linspace(z_min, z_max, Nz);
    E = zeros(1,Nz);
    for iz=1:Nz
        [x_par, iptc] = phy2par([z(iz) 0 0], geometry);
        E_2d = -sp_eval (phi(space.gnum{iptc}), space.sp_patch{iptc}, geometry(iptc), {x_par(1), x_par(2)}, 'gradient');
        E(iz) = E_2d(1);
    end

    % write to file
    dlmwrite(['DC-p=3_nsub=16_Nz=' num2str(Nz) '.dat'], [z' (E')*1e-6], ' ');
end
