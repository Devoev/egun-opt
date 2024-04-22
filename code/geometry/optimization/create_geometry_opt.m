% create_geometry_opt (filename, x, order, continuity)
%
% INPUT:
%       - filename: filename of the geometry
%       - x: vector of DOFs
%       - order: order of curve to be optimized
%       - continuity: continuity of curve to be optimized

function [] = create_geometry_opt (filename, x, order, continuity)
    [nrb_opt, knts, ptcs_vac, ptcs_el] = create_nrb_opt_electrode (order);

    if (order > 8)
        % [x_opt]
        load('result_nlopt_order=8_run6.mat');
        nrb_opt = move_ctrl_opt (nrb_opt, x_opt);
        nrb_opt = nrbdegelev(nrb_opt, 1);
    end

    if (order > 9)
        % [x_opt]
        load('result_nlopt_order=9_run6.mat');
        nrb_opt = move_ctrl_opt (nrb_opt, x_opt);
        nrb_opt = nrbdegelev(nrb_opt, 1);
    end

    if (order > 10)
        % [x_opt]
        load('result_nlopt_order=10_run6.mat');
        nrb_opt = move_ctrl_opt (nrb_opt, x_opt);
        nrb_opt = nrbdegelev(nrb_opt, order-10);
    end

    if (continuity <= order-1)
        % [x_opt]
        load('result_nlopt_order=8_run6.mat');
        nrb_opt = move_ctrl_opt (nrb_opt, x_opt);
        nrb_opt = nrbkntins(nrb_opt, [1/2]);
    end

    if (continuity <= order-2)
        % [x_opt]
        load('result_nlopt_order=8_continuity=7_run6.mat');
        nrb_opt = move_ctrl_opt (nrb_opt, x_opt);
        nrb_opt = nrbkntins(nrb_opt, [1/4 3/4]);
    end

    if (continuity == order-3)
        % [x_opt]
        load('result_nlopt_order=8_continuity=6_run6.mat');
        nrb_opt = move_ctrl_opt (nrb_opt, x_opt);
        nrb_opt = nrbkntins(nrb_opt, [1/8 3/8 5/8 7/8]);
    end

    nrb_opt = move_ctrl_opt (nrb_opt, x);

    crv = cut_nrb_opt (nrb_opt, order, knts, ptcs_vac, continuity);

    [ptcs_vac, ptcs_el] = create_ptcs_opt (ptcs_vac, ptcs_el, order, crv, continuity);

    write_geometryfile_opt (ptcs_vac, ptcs_el, filename);
end
