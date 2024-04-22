% INPUT:
%       - filename: geometry filename
% OUTPUT:
%       - fc: value of the constraint

function [fc] = volume_constraint_orig(filename)
    [geometry, boundaries] = mp_geo_load ([filename '.txt']);

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
    % 625 cm^3 as maximal volume
    fc = V_el*1e6 - 625;
    fprintf('\nvolume_constraint: fc=%d\n', fc);
end
