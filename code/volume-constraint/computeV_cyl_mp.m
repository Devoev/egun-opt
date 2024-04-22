% INPUT:
%       - msh: msh object from GeoPDEs
% OUTPUT:
%       - V: volume assuming msh describes part of a cross section of an axisymmetric object

function [V] = computeV_cyl_mp (msh)
    V = 0;
    for iptc=1:msh.npatch
        V = V + computeV_cyl_ptc(msh.msh_patch{iptc});
    end
end
