% Perform a least squares fit for the initial geometry employing the NLopt library.
order = 8;

if (order >= 8)
    N_ctrl = order-3;
end
x_init = zeros(2*N_ctrl,1);

[lb, ub] = compute_bounds (x_init, order, 2*N_ctrl);

% test points
v = linspace(0,1,100);
cst_func = @(x) cost_function_fit(x, order, v);

% local: {COBYLA}
opt.algorithm     = NLOPT_LN_COBYLA;
opt.min_objective = cst_func;
opt.lower_bounds  = lb;
opt.upper_bounds  = ub;
opt.verbose       = 1;
opt.ftol_rel      = 1e-3;
opt.maxtime       = 24*60*60;

tic;
[x_opt, obj_opt, retcode] = nlopt_optimize (opt, x_init);
fprintf('\nnlopt_optimize: %d min\n', toc/60);

save('result_nlopt_fit.mat', 'x_opt', 'obj_opt');

% signal that the program is finished
x = linspace(1, 20, 8000);
Y = sin(2*pi*440*x);
sound(Y);
