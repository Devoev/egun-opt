% Compute the volume constraint on the electrode.
order = continuity = 8;
% continuity = 7;

if (order >= 8)
    N_ctrl = order-3;
    if (continuity < order)
        N_ctrl = N_ctrl + order-continuity;
    end
end
x = zeros(2*N_ctrl,1);

tic;
vol_cstr = @(x) volume_constraint(x, order, continuity);
fc       = vol_cstr(x);
fprintf('\nvolume_constraint: %d min\n', toc/60);
