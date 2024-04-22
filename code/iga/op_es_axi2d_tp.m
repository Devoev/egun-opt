% INPUT:
%       - spu:     object representing the space of trial functions (see sp_scalar)
%       - spv:     object representing the space of test functions (see sp_scalar)
%       - msh:     object defining the domain partition and the quadrature rule (see msh_cartesian)
%       - epsilon: electric permittivity
%       - iptc:    patch index
% OUTPUT:
%       - mat:    assembled stiffness matrix
%       - rows:   row indices of the nonzero entries
%       - cols:   column indices of the nonzero entries
%       - values: values of the nonzero entries

function varargout = op_es_axi2d_tp (spu, spv, msh, epsilon, iptc)
    mat = spalloc (spv.ndof, spu.ndof, 3*spu.ndof);

    for iel=1:msh.nel_dir(1)
        msh_col = msh_evaluate_col (msh, iel);
        spu_col = sp_evaluate_col (spu, msh_col, 'value', false, 'gradient', true);
        spv_col = sp_evaluate_col (spv, msh_col, 'value', false, 'gradient', true);

        for idim=1:msh.rdim
            x{idim} = reshape(msh_col.geo_map(idim,:,:), msh_col.nqn, msh_col.nel);
        end
        epsilon_col = epsilon(x{:}, iptc);

        mat = mat + op_es_axi2d (spu_col, spv_col, msh_col, epsilon_col);
    end

    if (nargout == 1)
        varargout{1} = mat;
    elseif (nargout == 3)
        [rows, cols, vals] = find(mat);
        varargout{1} = rows;
        varargout{2} = cols;
        varargout{3} = vals;
    end
end
