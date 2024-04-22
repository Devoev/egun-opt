% INPUT:
%       - geometry: nurbs geometry
%       - msh:      GeoPDEs mesh
%       - space:    GeoPDEs space
%       - phi:      GeoPDEs solution vector

function [] = write_ins_pot (geometry, msh, space, phi)
    iptcs = [23 24];
    zp = linspace(0, 1, 1000);
    for ip=iptcs
        z = geo_nurbs(geometry(ip).nurbs, geometry(ip).dnurbs, geometry(ip).dnurbs2, {1, zp}, 0, geometry(ip).rdim);

        U = sp_eval(phi(space.gnum{ip}), space.sp_patch{ip}, geometry(ip), {1, zp});

        E = sp_eval (phi(space.gnum{ip}), space.sp_patch{ip}, geometry(ip), {1, zp}, 'gradient');
        E = squeeze(sqrt(E(1,:,:).^2 + E(2,:,:).^2));

        write_dat1D (['insulator_potential_ip=' num2str(ip) '.dat'], z(1,:), U);
        write_dat1D (['insulator_gradient_ip=' num2str(ip) '.dat'], z(1,:), E);
    end
end
