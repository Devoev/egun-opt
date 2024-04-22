% INPUT:
%       - phi: DOFs of the GeoPDEs solution
%       - msh: msh from GeoPDEs
%       - space: space from GeoPDEs
%       - geometry: geometry from GeoPDEs
% OUTPUT:
%       - E_max: maximum absolute electric field strength

function [E_max] = computeE_max (phi, msh, space, geometry)
    E_max = 0;
    N_el  = msh.nel_dir(1);
    for iel=1:N_el
        msh_col = msh_evaluate_col (msh, iel);

        E_col = sp_eval(phi, space, geometry, msh_col.qn, 'gradient');
        E_col = sqrt(E_col(1,:,:).^2 + E_col(2,:,:).^2);

        E_max_col = max(max(E_col));
        E_max     = max([E_max E_max_col]);
    end
end
