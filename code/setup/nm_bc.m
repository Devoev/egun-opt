% [g] = nm_bc (ib, x, y)
%
% INPUT:
%       - ib: index of the boundary
%       - x,y: coordinates of point on boundary
% OUTPUT:
%       - g: function value for Neumann boundary

function [g] = nm_bc (ib, x, y)
    switch (ib)
        % symmetry axis
        case {4}
            g = zeros(size(x));
        otherwise
            error('unknown boundary');
    end%switch
end
