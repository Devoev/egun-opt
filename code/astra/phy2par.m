% INPUT:
%       - x_phy:    physical coordinates
%       - geometry: nurbs geometry
% OUTPUT:
%       - x_par: parametric coordinates
%       - iptc:  patch index

function [x_par, iptc] = phy2par (x_phy, geometry)
    % transform physical to parametric coordinates for patches {6,4,3,2,1}
    z_min4 = nrbeval(geometry(4).nurbs, [0 0]);
    z_min3 = nrbeval(geometry(3).nurbs, [0 0]);
    z_min2 = nrbeval(geometry(2).nurbs, [0 0]);
    z_min1 = nrbeval(geometry(1).nurbs, [0 0]);

    if (x_phy(1) < z_min4(1))
        x_par = nrbinverse_mod(geometry(6).nurbs, x_phy);
        iptc  = 6;
    elseif (x_phy(1) < z_min3(1))
        x_par = nrbinverse_mod(geometry(4).nurbs, x_phy);
        iptc  = 4;
    elseif (x_phy(1) < z_min2(1))
        x_par = nrbinverse_mod(geometry(3).nurbs, x_phy);
        iptc  = 3;
    elseif (x_phy(1) < z_min1(1))
        x_par = nrbinverse_mod(geometry(2).nurbs, x_phy);
        iptc  = 2;
    else
        x_par = nrbinverse_mod(geometry(1).nurbs, x_phy);
        iptc  = 1;
    end
end
