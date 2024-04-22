% INPUT:
%       - geometry: nurbs geometry

function [] = write_geometry (geometry)
    nsub = 8;
    % write to .dat file
    for iptc=1:length(geometry)
        hold on;
        filename = ['geometry' num2str(iptc) '.dat'];
        nrbplot_dat(geometry(iptc).nurbs, [nsub nsub], filename);
        hold off;
    end
end
