% WRITE_IGES_2D Writes the 2 dimensional representation of the axial symmetric geometry to an IGES file.
%
% INPUT:
%       - file: output filename
%       - geo : nurbs geometry
%       - idx : indices of patches to write

function [] = write_iges_2d(filename, geometry, idx)
    display = false;

    for i=1:length(idx)
        nurbs = geometry(idx(i)).nurbs;
        if (display)
            hold on;
            nrbkntplot(nurbs);
            hold off;
            colormap('viridis');
        end
        nrb2iges(nurbs, [filename '_' num2str(idx(i)) num2str(i) '.igs']);
    end

    % additional vacuum chamber piece
    % nurbs = nrbline([447e-3 20e-3], [447e-3 30e-3]);
    % nurbs = nrbrevolve(nurbs, pnt, ext, 2*pi);
    % nrb2iges(nurbs, ['additional.igs']);
end
