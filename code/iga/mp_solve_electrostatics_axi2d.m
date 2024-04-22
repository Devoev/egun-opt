% [geometry, msh, space, phi] = mp_solve_electrostatics_axi2d (problem_data, method_data)
%
% INPUT:
%       - problem_data: a structure with data of the problem. It contains the fields:
%           - geo_name:     name of the file containing the geometry
%           - nmnn_sides:   sides with Neumann boundary condition
%           - drchlt_sides: sides with Dirichlet boundary condition
%           - epsilon:      electric permittivity
%           - f:            source term (space charge density)
%           - g:            function for Neumann condition
%           - h:            function for Dirichlet boundary condition
%       - method_data: a structure with discretization data. Its fields are:
%           - degree:     degree of the spline functions.
%           - regularity: continuity of the spline functions.
%           - nsub:       number of subelements with respect to the geometry mesh (nsub=1 leaves the mesh unchanged)
%           - nquad:      number of points for Gaussian quadrature rule
% OUTPUT:
%       - geometry: array of geometry structures (see geo_load)
%       - msh:      multipatch mesh, consisting of several Cartesian meshes (see msh_multipatch)
%       - space:    multipatch space, formed by several tensor product spaces plus the connectivity (see sp_multipatch)
%       - phi:      the computed degrees of freedom

function [geometry, msh, space, phi] = mp_solve_electrostatics_axi2d (problem_data, method_data)
    data_names = fieldnames (problem_data);
    for iopt=1:numel(data_names)
        eval([data_names{iopt} '= problem_data.(data_names{iopt});']);
    end
    data_names = fieldnames (method_data);
    for iopt=1:numel(data_names)
        eval([data_names{iopt} '= method_data.(data_names{iopt});']);
    end

    [geometry, boundaries, interfaces, ~, boundary_interfaces] = mp_geo_load (geo_name);
    npatch = numel(geometry);

    msh = cell(1,npatch);
    sp  = cell(1,npatch);
    for iptc=1:npatch
        [knots{iptc}, zeta{iptc}] = kntrefine (geometry(iptc).nurbs.knots, nsub-1, degree, regularity);

        rule      = msh_gauss_nodes (nquad);
        [qn, qw]  = msh_set_quad_nodes (zeta{iptc}, rule);
        msh{iptc} = msh_cartesian (zeta{iptc}, qn, qw, geometry(iptc));

        sp{iptc} = sp_bspline (knots{iptc}, degree, msh{iptc});
    end

    msh   = msh_multipatch (msh, boundaries);
    space = sp_multipatch (sp, msh, interfaces, boundary_interfaces);
    clear sp

    % assembly
    mat = op_es_axi2d_mp (space, space, msh, epsilon);
    rhs = op_f_v_axi2d_mp (space, msh, f);

    % boundary conditions
    Nbnd = cumsum ([0, boundaries.nsides]);
    for iref=nmnn_sides
       iref_patch_list = Nbnd(iref)+1:Nbnd(iref+1);
       gref = @(varargin) g(varargin{:},iref);
       rhs_nmnn = op_f_v_mp (space.boundary, msh.boundary, gref, iref_patch_list);
       rhs(space.boundary.dofs) = rhs(space.boundary.dofs) + rhs_nmnn;
    end

    phi = zeros(space.ndof,1);
    [phi_drchlt, drchlt_dofs] = sp_drchlt_l2_proj_mod (space, msh, h, drchlt_sides);
    phi(drchlt_dofs) = phi_drchlt;

    int_dofs = setdiff(1:space.ndof, drchlt_dofs);
    rhs(int_dofs) = rhs(int_dofs) - mat(int_dofs, drchlt_dofs)*phi_drchlt;

    phi(int_dofs) = mat(int_dofs, int_dofs) \ rhs(int_dofs);
end
