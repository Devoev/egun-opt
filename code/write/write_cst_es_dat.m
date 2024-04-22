% INPUT:
%       - x:        x-coordinates
%       - y:        y-coordinates
%       - E:        electric field values
%       - filename: output filename
%       - npts:     number of points per coordinate direction
%       - nptc:     number of patches

function write_cst_es_dat (x, y, E, filename, npts, nptc)
    for iptc=1:nptc
        fid = fopen([filename '_npts=' num2str(npts) '_' num2str(iptc) '.dat'], 'w');
        fprintf(fid, 'x y c\n');

        ioff = (iptc-1)*npts^2;
        for ip=1:npts
            dlmwrite(fid, [x(ioff+(ip-1)*npts+1:ioff+ip*npts) y((ioff+(ip-1)*npts+1:ioff+ip*npts)) E(ioff+(ip-1)*npts+1:ioff+ip*npts)], 'delimiter', '  ', 'append', 'on');
            fprintf(fid, '\n');
        end
        fclose(fid);
    end
end
