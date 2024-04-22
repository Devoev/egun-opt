% Compute the bounds on the control points.
order = continuity = 8;
continuity = 8;
if (continuity < order)
    filename = ['v6_opt_order=' num2str(order) '_continuity=' num2str(continuity)];
else
    filename = ['v6_opt_order=' num2str(order)];
end

if (order >= 8)
    N_ctrl = order-3;
    if (continuity == order-1)
        N_ctrl = N_ctrl + 1;
    elseif (continuity == order-2)
        N_ctrl = N_ctrl + 3;
    elseif (continuity == order-3)
        N_ctrl = N_ctrl + 6;
    end
end
x = zeros(2*N_ctrl,1);

[lb, ub] = compute_bounds (x, order, 2*N_ctrl, continuity);
plot_bounds(lb, ub, order, x, continuity);
