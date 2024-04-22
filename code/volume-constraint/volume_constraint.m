% [fc] = volume_constraint(x, order, continuity)
% INPUT:
%       - x:          vector of DOFs
%       - order:      order of the curve
%       - continuity: continuity of the curve
% OUTPUT:
%       - fc: value of the constraint

function [fc] = volume_constraint(x, order, continuity)
    if (continuity < order)
        geometry_file = ['v6_opt_order=' num2str(order) '_continuity=' num2str(continuity)];
    else
        geometry_file = ['v6_opt_order=' num2str(order)];
    end
    create_geometry_opt (geometry_file, x, order, continuity);
    [geometry, boundaries] = mp_geo_load ('electrode_v6.txt');

    degree = [2 2];
    nsub   = [2^2 2^2];
    regularity = degree-1;
    nquad      = degree+1;
    npatch     = numel(geometry);
    msh        = cell(1,npatch);

    for iptc=1:npatch
        [knots{iptc}, zeta{iptc}] = kntrefine (geometry(iptc).nurbs.knots, nsub-1, degree, regularity);

        rule      = msh_gauss_nodes (nquad);
        [qn, qw]  = msh_set_quad_nodes (zeta{iptc}, rule);
        msh{iptc} = msh_cartesian (zeta{iptc}, qn, qw, geometry(iptc));
    end
    msh = msh_multipatch (msh, boundaries);

    V_el = computeV_cyl_mp (msh);
    % 625 cm^3 as maximal volume (restricted to 624 cm^3 for optimization)
    fc = V_el*1e6 - 624;
    fprintf('\nvolume_constraint: fc=%d\n', fc);
end
