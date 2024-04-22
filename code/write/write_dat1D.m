% INPUT:
%       - filename: output filename
%       - x:        x-coordinates
%       - y:        y-coordinates

function [] = write_dat1D (filename, x, y)
    % write to .dat file
    fprintf(['\n creating ' filename '\n']);
    fid = fopen(filename, 'w');
    fprintf(fid, 'x y\n');
    for icol=1:length(x)
        dlmwrite(fid, [x(icol) y(icol)], 'delimiter', '  ', 'append', 'on');
    end
    fclose(fid);
end
