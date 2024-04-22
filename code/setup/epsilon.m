% [epsilon_ptc] = epsilon (ip, x, y, epsilon_r, geometry_file)
%
% INPUT:
%       - ip: index of the patch
%       - x,y: coordinates of point on patch
%       - epsilon_r: relative permittivity of patch material
%       - geometry_file: file containing the geometry
% OUTPUT:
%       - epsilon_ptc: permittivity value

function [epsilon_ptc] = epsilon (ip, x, y, epsilon_r, geometry_file)
    if (strcmp(geometry_file, 'geometry_v6_orig'))
        switch (ip)
            case {5, 23, 24, 31, 32, 33, 34}
                epsilon_ptc = epsilon_r * 8.854e-12*ones(size(x));
            otherwise
                epsilon_ptc = 8.854e-12*ones(size(x));
        end
    else
        % optimization
        switch (ip)
            case {5, 23, 24, 31, 32, 33, 34}
                epsilon_ptc = epsilon_r * 8.854e-12*ones(size(x));
            otherwise
                epsilon_ptc = 8.854e-12*ones(size(x));
        end
    end%if
end
