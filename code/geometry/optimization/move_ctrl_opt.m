% [nrb_opt] = move_ctrl_opt (nrb_opt, x)
%
% INPUT:
%       - nrb_opt: curve to be optimized
%       - x: vector of DOFs
% OUTPUT:
%       - nrb_opt: curve to be optimized

function [nrb_opt] = move_ctrl_opt (nrb_opt, x)
    N_ctrl = length(x)/2;
    for ictrl=2:(N_ctrl+1)
        ix = 2*ictrl-3;
        nrb_opt = nrbmodp(nrb_opt, [x(ix) x(ix+1) 0], ictrl);
    end
end
