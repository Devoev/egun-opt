% [h] = drl_bc (ib, x, y, v_el, v_ar)
%
% INPUT:
%       - ib: index of the boundary
%       - x,y: coordinates of point on boundary
%       - v_el,v_ar: potential on electrode or anode ring
% OUTPUT:
%       - h: function value for Dirichlet boundary

function [h] = drl_bc (ib, x, y, v_el, v_ar)
    switch (ib)
        % electrode
        case {1}
            h = v_el*ones(size(x));
        % anode ring
        case {2}
            h = v_ar*ones(size(x));
        % vacuum chamber
        case {3}
            h = zeros(size(x));
        otherwise
            error('unknown boundary');
    end%switch
end
