% INPUT:
%       - nrb: nurbs
%       - x:   initial guess
% OUTPUT:
%       - u: knot value or NaN if not converged

function u = nrbinverse_mod (nrb, x, varargin)
    ndim = numel (nrb.number);

    % Default options
    options = struct ('u0', .5*ones (ndim, 1), 'MaxIter', 10, 'Display', false, 'TolX', 1e-8, 'TolFun', 1e-8);

    % Read the acceptable names
    optionNames = fieldnames (options);

    % Count arguments
    nargin = length (varargin);
    if (round (nargin/2) ~= nargin/2)
        error ('NRBINVERSE needs propertyName/propertyValue pairs');
    end

    % Check options passed
    for pair = reshape (varargin, 2, [])
        if any (strcmp (pair{1}, optionNames))
            options.(pair{1}) = pair{2};
        else
            error('%s is not a recognized parameter name', pair{1});
        end
    end

    % x as column vector
    x = x(:);

    % Define functions for Newton iteration
    f = @(U) nrbeval (nrb, num2cell (U)) - x;
    jac = @(U) nrbjacobian (nrb, num2cell (U));

    % Newton cycle
    u_old = options.u0(:);

    if (iscell (nrb.knots))
        first_knot = reshape (cellfun (@(x) x(1),nrb.knots), size(u_old));
        last_knot = reshape (cellfun (@(x) x(end),nrb.knots), size(u_old));
    else
        first_knot = nrb.knots(1);
        last_knot = nrb.knots(end);
    end
    convergence = false;

    for iter = 1:options.MaxIter
        u_new = u_old - jac (u_old) \ f (u_old);

        % Check if the point is outside the parametric domain
        u_new = max (u_new, first_knot);
        u_new = min (u_new, last_knot);

        % Error control
        if (norm (u_new - u_old) < options.TolX && norm (f (u_new)) < options.TolFun)
            if (options.Display)
                fprintf ('Newton scheme converged in %i iteration.\n', iter);
            end
            convergence = true;
            break;
        end

        u_old = u_new;
    end

    if (~convergence)
        fprintf ('Newton scheme reached the maximum number of iterations (%i) without converging.\n', options.MaxIter);
    end
    u = u_new;
end

function jac = nrbjacobian (nrb, u)
    ders = nrbderiv (nrb);
    [~, jac] = nrbdeval (nrb, ders, u);
    jac = [jac{:}];
end
