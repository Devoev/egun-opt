% Run the optimization employing the NLopt library.

order = continuity = 8;
% continuity = 5;

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
x_init = zeros(2*N_ctrl,1);

% compute bounds based on LS fit (only for order = 8)
% use previous result as starting shape (automatic for order > 8)
% [x_opt]
load('result_nlopt_fit.mat');
% load('result_nlopt_order=8_run5.mat');
x_init = x_opt;
[lb, ub] = compute_bounds (x_init, order, 2*N_ctrl, continuity);

cst_func  = @(x) cost_function_tp(x, order, continuity);
vol_cstr  = @(x) volume_constraint(x, order, continuity);

% local: {COBYLA} global: {AGS, ISRES}
opt.algorithm     = NLOPT_LN_COBYLA;
% opt.algorithm     = NLOPT_GN_ISRES;
% opt.population    = 1*length(x_init);
opt.min_objective = cst_func;
opt.lower_bounds  = lb;
opt.upper_bounds  = ub;
opt.fc            = {vol_cstr};
opt.verbose       = 1;
% (1e-4 and 1e2 for COBYLA | 1e-3 and 1e3 for ISRES)
opt.ftol_rel      = 1e-3;
opt.ftol_abs      = 1e3;
opt.maxtime       = 7*24*60*60;

tic;
[x_opt, obj_opt, retcode] = nlopt_optimize (opt, x_init);
fprintf('\nnlopt_optimize: %d min\n', toc/60);

save(['result_nlopt_order=' num2str(order) '.mat'], 'x_opt', 'obj_opt');

% signal that the program is finished
x = linspace(1, 20, 8000);
Y = sin(2*pi*440*x);
sound(Y);
