% INPUT:
%       - spu:     object representing the space of trial functions (see sp_scalar)
%       - spv:     object representing the space of test functions (see sp_scalar)
%       - msh:     object defining the domain partition and the quadrature rule (see msh_cartesian)
%       - epsilon: electric permittivity
% OUTPUT:
%       - mat:    assembled stiffness matrix
%       - rows:   row indices of the nonzero entries
%       - cols:   column indices of the nonzero entries
%       - values: values of the nonzero entries

function varargout = op_es_axi2d (spu, spv, msh, epsilon)
    gradu = reshape(spu.shape_function_gradients, spu.ncomp, [], msh.nqn, spu.nsh_max, msh.nel);
    gradv = reshape(spv.shape_function_gradients, spv.ncomp, [], msh.nqn, spv.nsh_max, msh.nel);

    ndir = size(gradu, 2);
    rows   = zeros(msh.nel * spu.nsh_max * spv.nsh_max, 1);
    cols   = zeros(msh.nel * spu.nsh_max * spv.nsh_max, 1);
    values = zeros(msh.nel * spu.nsh_max * spv.nsh_max, 1);


    r = msh.geo_map;
    r = squeeze(r(2,:,:));
    jacdet = epsilon .* r .* msh.quad_weights .* msh.jacdet;

    ncounter = 0;
    for iel=1:msh.nel
        if (all (msh.jacdet(:, iel)))
            gradu_iel = reshape(gradu(:,:,:,1:spu.nsh(iel),iel), spu.ncomp*ndir, msh.nqn, 1, spu.nsh(iel));
            gradv_iel = reshape(gradv(:,:,:,1:spv.nsh(iel),iel), spv.ncomp*ndir, msh.nqn, spv.nsh(iel), 1);

            jacdet_iel = reshape(jacdet(:,iel), [1,msh.nqn,1,1]);

            tmp = bsxfun (@times, jacdet_iel, gradu_iel);
            % scalar product
            tmp = sum(bsxfun (@times, tmp, gradv_iel), 1);
            values(ncounter+(1:spu.nsh(iel)*spv.nsh(iel))) = reshape(sum(tmp, 2), spv.nsh(iel), spu.nsh(iel));

            [rows_loc, cols_loc] = ndgrid (spv.connectivity(:,iel), spu.connectivity(:,iel));
            rows(ncounter+(1:spu.nsh(iel)*spv.nsh(iel))) = rows_loc;
            cols(ncounter+(1:spu.nsh(iel)*spv.nsh(iel))) = cols_loc;
            ncounter = ncounter + spu.nsh(iel)*spv.nsh(iel);
        else
            warning ('geopdes:jacdet_zero_at_quad_node', 'op_es_axi2d: singular map in element number %d', iel)
        end
    end

    if (nargout == 1 || nargout == 0)
        varargout{1} = sparse(rows(1:ncounter), cols(1:ncounter), values(1:ncounter), spv.ndof, spu.ndof);
    elseif (nargout == 3)
        varargout{1} = rows(1:ncounter);
        varargout{2} = cols(1:ncounter);
        varargout{3} = values(1:ncounter);
    else
        error ('op_es_axi2d: wrong number of output arguments')
    end
end
