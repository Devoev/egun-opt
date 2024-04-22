% INPUT:
%       - geometry: geometry from GeoPDEs
%       - msh: msh from GeoPDEs
%       - space: space from GeoPDEs
%       - phi: DOFs of the GeoPDEs solution
% OUTPUT:
%       - E_max: maximum absolute electric field strength

function [E_max] = computeE_max_anodering (geometry, msh, space, phi)
    zp = linspace(0, 1, 100);

    ip = 3;
    % z = geo_nurbs(geometry(ip).nurbs, geometry(ip).dnurbs, geometry(ip).dnurbs2, {1, zp}, 0, geometry(ip).rdim);
    E = sp_eval(phi(space.gnum{ip}), space.sp_patch{ip}, geometry(ip), {1, zp}, 'gradient');
    E = sqrt(E(1,:,:).^2 + E(2,:,:).^2);
    E_max = max(E);

    ip = 4;
    % z = geo_nurbs(geometry(ip).nurbs, geometry(ip).dnurbs, geometry(ip).dnurbs2, {1, zp}, 0, geometry(ip).rdim);
    E = sp_eval(phi(space.gnum{ip}), space.sp_patch{ip}, geometry(ip), {1, zp}, 'gradient');
    E = sqrt(E(1,:,:).^2 + E(2,:,:).^2);
    E = max(E);
    E_max = max([E E_max]);

    ip = 7;
    % z = geo_nurbs(geometry(ip).nurbs, geometry(ip).dnurbs, geometry(ip).dnurbs2, {zp, 1}, 0, geometry(ip).rdim);
    E = sp_eval(phi(space.gnum{ip}), space.sp_patch{ip}, geometry(ip), {zp, 1}, 'gradient');
    E = sqrt(E(1,:,:).^2 + E(2,:,:).^2);
    E = max(E);
    E_max = max([E E_max]);

    ip = 8;
    % z = geo_nurbs(geometry(ip).nurbs, geometry(ip).dnurbs, geometry(ip).dnurbs2, {zp, 1}, 0, geometry(ip).rdim);
    E = sp_eval(phi(space.gnum{ip}), space.sp_patch{ip}, geometry(ip), {zp, 1}, 'gradient');
    E = sqrt(E(1,:,:).^2 + E(2,:,:).^2);
    E = max(E);
    E_max = max([E E_max]);

    ip = 9;
    % z = geo_nurbs(geometry(ip).nurbs, geometry(ip).dnurbs, geometry(ip).dnurbs2, {zp, 1}, 0, geometry(ip).rdim);
    E = sp_eval(phi(space.gnum{ip}), space.sp_patch{ip}, geometry(ip), {zp, 1}, 'gradient');
    E = sqrt(E(1,:,:).^2 + E(2,:,:).^2);
    E = max(E);
    E_max = max([E E_max]);

    ip = 10;
    % z = geo_nurbs(geometry(ip).nurbs, geometry(ip).dnurbs, geometry(ip).dnurbs2, {zp, 1}, 0, geometry(ip).rdim);
    E = sp_eval(phi(space.gnum{ip}), space.sp_patch{ip}, geometry(ip), {zp, 1}, 'gradient');
    E = sqrt(E(1,:,:).^2 + E(2,:,:).^2);
    E = max(E);
    E_max = max([E E_max]);

    ip = 13;
    % z = geo_nurbs(geometry(ip).nurbs, geometry(ip).dnurbs, geometry(ip).dnurbs2, {0, zp}, 0, geometry(ip).rdim);
    E = sp_eval(phi(space.gnum{ip}), space.sp_patch{ip}, geometry(ip), {0, zp}, 'gradient');
    E = sqrt(E(1,:,:).^2 + E(2,:,:).^2);
    E = max(E);
    E_max = max([E E_max]);
end
