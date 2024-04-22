% INPUT:
%       - x_phy:    physical coordinates
%       - geometry: nurbs geometry
% OUTPUT:
%       - x_par: parametric coordinates
%       - iptc:  patch index

function [x_par, iptc] = phy2par_tp (x_phy, geometry)
    % transform physical to parametric coordinates for patches {18,21,23}

    % [0 0] lower left, [1 0] upper left, [0 1] lower right, [1 1] upper right
    x_ll = nrbeval(geometry(18).nurbs, [0 0]);
    x_ul = nrbeval(geometry(18).nurbs, [1 0]);
    a = (x_ul(2) - x_ll(2)) / (x_ul(1) - x_ll(1));
    b = x_ul(2) - a*x_ul(1);
    y_min18 = @(x) a*x + b;

    x_ll = nrbeval(geometry(21).nurbs, [0 0]);
    x_lr = nrbeval(geometry(21).nurbs, [0 1]);
    a = (x_ll(2) - x_lr(2)) / (x_ll(1) - x_lr(1));
    b = x_ll(2) - a*x_ll(1);
    y_min21 = @(x) a*x + b;

    if (x_phy(2) > y_min18(x_phy(1)))
        x_par = nrbinverse_mod(geometry(18).nurbs, x_phy);
        iptc  = 18;
    elseif (x_phy(2) > y_min21(x_phy(1)))
        x_par = nrbinverse_mod(geometry(21).nurbs, x_phy);
        iptc  = 21;
    else
        x_par = nrbinverse_mod(geometry(23).nurbs, x_phy);
        iptc  = 23;
    end
end
