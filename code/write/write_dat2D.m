% INPUT:
%       - filename: output filename
%       - X:        x-coordinates
%       - Y:        y-coordinates

function [] = write_dat2D (filename, X, Y)
    % write to .dat file
    fprintf(['\nwrite_dat2D: ' filename '\n']);
    fid = fopen(filename, 'w');
    fprintf(fid, 'x y c\n');
    for icol=1:size(X,2)
        dlmwrite(fid, [X(:,icol) Y(:,icol) ones(size(X,1))], 'delimiter', '  ', 'append', 'on');
        fprintf(fid, '\n');
    end
    fclose(fid);
end
