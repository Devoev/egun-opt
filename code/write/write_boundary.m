% INPUT:
%       - geometry: nurbs geometry

function [] = write_boundary (geometry)
    nsub = 100;
    % write to .dat file
    for iptc=1:length(geometry)
        for ibdry=1:length(geometry(iptc).boundary)
            hold on;
            filename = ['boundary' num2str(iptc) num2str(ibdry) '.dat'];
            nrbplot_dat(geometry(iptc).boundary(ibdry).nurbs, nsub, filename);
            hold off;
        end
    end
end
