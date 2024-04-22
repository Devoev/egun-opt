% INPUT:
%       - spv:   object representing the function space (see sp_scalar)
%       - msh:   object defining the domain partition and the quadrature rule (see msh_cartesian)
%       - coeff: function handle to compute the source function
% OUTPUT:
%       - rhs: assembled right-hand side

function rhs = op_f_v_axi2d (spv, msh, coeff)
    shpv  = reshape (spv.shape_functions, spv.ncomp, msh.nqn, spv.nsh_max, msh.nel);
    coeff = reshape (coeff, spv.ncomp, msh.nqn, msh.nel);

    rhs = zeros(spv.ndof,1);

    r = msh.geo_map;
    r = squeeze(r(2,:,:));

    for iel=1:msh.nel
        if (all (msh.jacdet(:,iel)))
            jacdet_weights = reshape (r(:,iel) .* msh.jacdet(:, iel) .* msh.quad_weights(:, iel), 1, msh.nqn);

            coeff_times_jw = bsxfun (@times, jacdet_weights, coeff(:,:,iel));

            shpv_iel = reshape (shpv(:,:,1:spv.nsh(iel),iel), spv.ncomp, msh.nqn, spv.nsh(iel));

            aux_val = bsxfun (@times, coeff_times_jw, shpv_iel);
            rhs_loc = sum (sum (aux_val, 1), 2);
            rhs(spv.connectivity(1:spv.nsh(iel), iel)) = rhs(spv.connectivity(1:spv.nsh(iel), iel)) + rhs_loc(:);
        else
            warning ('geopdes:jacdet_zero_at_quad_node', 'op_f_v_axi2d: singular map in element number %d', iel)
        end
    end
end
