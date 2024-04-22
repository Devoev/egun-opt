% INPUT:
%       - geometry:   nurbs geometry
%       - boundaries: nurbs boundaries of the geometry

function [] = plot_boundary (geometry, boundaries)
    width = 4;
    nsub  = 100;
    for ib=1:length(boundaries)
        switch(ib)
            % electrode
            case{1}
                for ip=1:length(boundaries(ib).patches)
                    nrbplot_color('b', width, geometry(boundaries(ib).patches(ip)).boundary(boundaries(ib).faces(ip)).nurbs, nsub);
                end
            % anode ring
            case{2}
                for ip=1:length(boundaries(ib).patches)
                    nrbplot_color('r', width, geometry(boundaries(ib).patches(ip)).boundary(boundaries(ib).faces(ip)).nurbs, nsub);
                end
            % vacuum chamber
            case{3}
                for ip=1:length(boundaries(ib).patches)
                    nrbplot_color('k', width, geometry(boundaries(ib).patches(ip)).boundary(boundaries(ib).faces(ip)).nurbs, nsub);
                end
            % symmetry
            case{4}
                for ip=1:length(boundaries(ib).patches)
                    nrbplot_color('g', width, geometry(boundaries(ib).patches(ip)).boundary(boundaries(ib).faces(ip)).nurbs, nsub);
                end
        end
    end%for
end
