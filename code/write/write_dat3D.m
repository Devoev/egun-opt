% INPUT:
%       - filename: output filename
%       - X:        x-coordinates
%       - Y:        y-coordinates
%       - c:        color values

function [] = write_dat3D (filename, X, Y, c)
    % write to .dat file
    fprintf(['\nwrite_dat3D: ' filename '\n']);
    fid = fopen(filename, 'w');
    fprintf(fid, 'x y c\n');
    for icol=1:size(X,2)
        dlmwrite(fid, [X(:,icol) Y(:,icol) c(:,icol)], 'delimiter', '  ', 'append', 'on');
        fprintf(fid, '\n');
    end
    fclose(fid);
end
