% [knt] = compute_intersectionv (nrb_opt, crv, I)
%
% INPUT:
%       - nrb_opt: NURBS curve to be optimized
%       - crv: patch boundary intersecting nrb_opt
%       - I: initial interval for the bisection method
% OUTPUT:
%       - knt: coordinates of the intersection in parameter space

function [knt] = compute_intersectionv (nrb_opt, crv, I)
    x0 = nrbeval(crv, 0);
    x1 = nrbeval(crv, 1);
    if (x1(1) == x0(1))
        ucrv = @(v) x0(1);
    else
        a = (x1(2)-x0(2))/(x1(1)-x0(1));
        b = x0(2) - a*x0(1);
        % function handle for curve
        ucrv = @(v) (v-b)/a;
    end

    % bisection method (interval I in parametric space of nrb_opt, compute where crv is in relation)
    y1 = nrbeval(nrb_opt, I(1));
    y2 = nrbeval(nrb_opt, I(2));
    for ii=1:2^6
        if (ucrv(y1(2)) > y1(1) && ucrv(y2(2)) < y2(1))
            knt = (I(1)+I(2))/2;
            ym = nrbeval(nrb_opt, knt);
            if (ucrv(ym(2)) > ym(1))
                I = [knt, I(2)];
                y1 = ym;
            elseif (ucrv(ym(2)) < ym(1))
                I = [I(1), knt];
                y2 = ym;
            end
        % crv left
        elseif (ucrv(y1(2)) <= y1(1))
            knt = I(1);
            break;
        % crv right
        elseif (ucrv(y2(2)) >= y2(1))
            knt = I(2);
            break;
        end
        % converged
        if (abs(diff(I)) < 1e-4)
            knt = (I(2)+I(1))/2;
            break;
        end
    end
end
