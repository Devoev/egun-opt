% INPUT:
%       - spu:        object representing the space of trial functions (see sp_scalar)
%       - spv:        object representing the space of test functions (see sp_scalar)
%       - msh:        object defining the domain partition and the quadrature rule (see msh_cartesian)
%       - epsilon:    electric permittivity
%       - patch_list: array of indices indicating the relevant patches
% OUTPUT:
%       - mat: assembled stiffness matrix

function mat = op_es_axi2d_mp (spu, spv, msh, epsilon, patch_list)
    if (nargin < 5)
        patch_list = 1:msh.npatch;
    end

    if ((spu.npatch ~= spv.npatch) || (spu.npatch ~= msh.npatch))
        error('op_es_axi2d_mp: the number of patches does not coincide')
    end

    ncounter = 0;
    for iptc=patch_list
        [rs, cs, vs] = op_es_axi2d_tp (spu.sp_patch{iptc}, spv.sp_patch{iptc}, msh.msh_patch{iptc}, epsilon, iptc);
        rows(ncounter+(1:numel(rs))) = spv.gnum{iptc}(rs);
        cols(ncounter+(1:numel(rs))) = spu.gnum{iptc}(cs);

        if (~isempty (spv.dofs_ornt))
            vs = spv.dofs_ornt{iptc}(rs)' .* vs;
        end
        if (~isempty (spu.dofs_ornt))
            vs = vs .* spu.dofs_ornt{iptc}(cs)';
       end

        vals(ncounter+(1:numel(rs))) = vs;
        ncounter = ncounter + numel(rs);
    end

    mat = sparse (rows, cols, vals, spv.ndof, spu.ndof);
    clear rows cols vals rs cs vs
end
