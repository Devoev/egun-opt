% [obj] = cost_function_fit (x, order, v)
%
% INPUT:
%       - x: vector of DOFs
%       - order: order of the curve
%       - v: vector of test points in parametric space
% OUTPUT:
%       - obj: objective function value

function [obj] = cost_function_fit (x, order, v)
    tic;
    geometry_file = ['nlopt_fit'];
    create_geometry_opt (geometry_file, x, order, order);

    [nrb_opt, ~, ~, ~, nrb_orig] = create_nrb_opt_electrode (order);
    [nrb_opt] = move_ctrl_opt (nrb_opt, x);

    % approximate least squares (in parameter space)
    v_orig = nrbeval(nrb_orig, v);
    % scatter(v_orig(1,:), v_orig(2,:));
    % hold on;
    % nrbctrlplot(nrb_opt);

    % find corresponding points via bisection
    knts = NaN(size(v));
    for iv=1:length(v)
        if (v_orig(1,iv) <= nrbeval(nrb_opt, 0.25)(1))
            crv = nrbmak([0.15 0.35; v_orig(2,iv) v_orig(2,iv); 0 0; 1 1], [0 0 1 1]);
            knts(iv) = compute_intersectionu(nrb_opt, crv, [0 0.25]);
        elseif (v_orig(1,iv) >= nrbeval(nrb_opt, 0.7)(1))
            crv = nrbmak([0.15 0.35; v_orig(2,iv) v_orig(2,iv); 0 0; 1 1], [0 0 1 1]);
            knts(iv) = compute_intersectionu(nrb_opt, crv, [1 0.7]);
        else
            crv = nrbmak([v_orig(1,iv) v_orig(1,iv); 0 0.1; 0 0; 1 1], [0 0 1 1]);
            knts(iv) = compute_intersectionv(nrb_opt, crv, [0.25 0.7]);
        end
        % nrbkntplot(crv);
    end

    v_opt = nrbeval(nrb_opt, knts);
    % scatter(v_opt(1,:), v_opt(2,:));

    obj = norm((v_orig-v_opt), 2);
    fprintf('\ncost_function_fit: %d s\n', toc);
end
