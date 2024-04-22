% INPUT:
%       - msh: msh object from GeoPDEs
% OUTPUT:
%       - V: volume assuming msh describes part of a cross section of an axisymmetric object

function [V] = computeV_cyl_ptc (msh)
    V = 0;
    for iel=1:msh.nel_dir(1)
        msh_col = msh_evaluate_col (msh, iel);
        w       = msh_col.quad_weights .* msh_col.jacdet;
        r       = msh_col.geo_map;
        r       = squeeze(r(2,:,:));

        V_col = sum(r .* w);
        V     = V + V_col;
    end
    V = 2*pi*sum(V);
end
