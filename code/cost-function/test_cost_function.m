% Computes the cost function for the optimization.
order = continuity = 8;
% continuity = 7;

if (order >= 8)
    N_ctrl = order-3;
    if (continuity < order)
        N_ctrl = N_ctrl + order-continuity;
    end
end
x = zeros(2*N_ctrl,1);

cst_func = @(x) cost_function_tp(x, order, continuity);
[obj] = cst_func(x)
