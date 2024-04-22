% INPUT:
%       - geometry: geometry from GeoPDEs
%       - msh: msh from GeoPDEs
%       - space: space from GeoPDEs
%       - phi: DOFs of the GeoPDEs solution
% OUTPUT:
%       - E_tp: absolute electric field strength

function [E_tp] = computeE_triplepoint (geometry, msh, space, phi)
    % iptc = 18;
    % E = sp_eval(phi(space.gnum{iptc}), space.sp_patch{iptc}, geometry(iptc), {0, 0}, 'gradient');
    % E18 = sqrt(E(1,:,:).^2 + E(2,:,:).^2);
    %
    % iptc = 21;
    % E = sp_eval(phi(space.gnum{iptc}), space.sp_patch{iptc}, geometry(iptc), {0, 1}, 'gradient');
    % E21 = sqrt(E(1,:,:).^2 + E(2,:,:).^2);
    %
    % iptc = 23;
    % E = sp_eval(phi(space.gnum{iptc}), space.sp_patch{iptc}, geometry(iptc), {1, 1}, 'gradient');
    % E23 = sqrt(E(1,:,:).^2 + E(2,:,:).^2);
    %
    % (E18 + E21 + E23)/3;

    % average over small circular region in patches 18, 21 and 23
    r = 1e-3;
    N = 100;
    c = nrbeval(geometry(18).nurbs, [0 0]);
    theta = linspace(0, 3*pi/2, N);
    E_tp = 0;
    for i=1:N
        x_phy = c + r*[cos(theta(i)); sin(theta(i)); 0];
        [x_par, iptc] = phy2par_tp (x_phy, geometry);
        E = sp_eval(phi(space.gnum{iptc}), space.sp_patch{iptc}, geometry(iptc), {x_par(1), x_par(2)}, 'gradient');
        E_tp = E_tp + sqrt(E(1,:,:).^2 + E(2,:,:).^2);
    end
    E_tp = E_tp/N;
end
