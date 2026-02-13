%% Performs a convergence study of the Poisson problem for a axisymmetric cylindrical capacitor geometry.

addpath(genpath('.'))
pkg load nurbs
pkg load geopdes

% Define geometry (x = z, y = rho)
R0 = 0.3;  % inner radius
nurbs = nrbsquare([0, R0], 1.0, 1.0 - R0, 1);
geo = geo_load (nurbs);
% nrbplot(geo.nurbs, [5, 5]);


% Setup problem
problem_data.geo_name     = nurbs;
problem_data.drchlt_sides = [3 4];
problem_data.nmnn_sides   = [1 2];
problem_data.epsilon = @(x,y,ip) ones(size(x));


% Define boundary conditions
function v = voltage(x,y,ib)
    if (ib == 3)
        v = zeros(size(x));
    elseif (ib == 4)
        v = ones(size(x));
    end
end

problem_data.f = @(x,y) zeros(size(x));
problem_data.h = @(x,y,ib) voltage(x,y,ib);
problem_data.g = @(x,y,ib) zeros(size(x));

% Define discretization parameters
method_data.degree     = [3 3];
method_data.regularity = method_data.degree - 1;
method_data.nquad      = method_data.degree + 1;


% Refinement
ndofs = [];
errs_l2 = [];
num_refine = 5;
for n=1:num_refine
    % Set number of subdivisions
    method_data.nsub = [2^n 2^n];

    % Solve
    [geo, msh, space, uh] = mp_solve_electrostatics_axi2d(problem_data, method_data);
    % sp_plot_solution(uh, space, geo, [20 20]);

    % Compute L2 error
    u = @(x,y) log(y/R0) / log(1.0/R0);
    err_l2 = sp_l2_error(space, msh, uh, u); % todo: rho factor is probably missing
    % fprintf('L2 error: %e\n', err_l2);

    % Store results
    ndofs(n) = space.ndof;
    errs_l2(n) = err_l2;
end


% Calculate convergence
ns = sqrt(ndofs);
p = -(log(errs_l2(end)) - log(errs_l2(end-1))) / (log(ns(end)) - log(ns(end-1)));
fprintf('Estimated convergence rate: %f\n', p);

figure;
hold on
loglog(sqrt(ndofs), errs_l2, 'o-');
loglog(sqrt(ndofs), sqrt(ndofs).^(-4), 'k--');
xlabel('sqrt(ndofs)');
ylabel('L2 error');
title('Convergence of Poisson problem for axisymmetric cylindrical capacitor');
grid on;