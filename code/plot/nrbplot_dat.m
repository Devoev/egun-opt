% INPUT:
%       - nurbs:    nurbs to plot
%       - nsub:     number of subdivisions
%       - filename: output filename

function nrbplot_dat (nurbs, nsub, filename)
    % nsub -> npts
    nsub = nsub+1;

    if (iscell(nurbs.knots))
        % surface
        if (size(nurbs.knots,2) == 2)
            knt   = nurbs.knots;
            order = nurbs.order;
            pts   = nrbeval(nurbs, {linspace(knt{1}(order(1)), knt{1}(end-order(1)+1), nsub(1)) linspace(knt{2}(order(2)), knt{2}(end-order(2)+1), nsub(2))});
            X = squeeze(pts(1,:,:));
            Y = squeeze(pts(2,:,:));
            write_dat2D(filename, X, Y);

            surf(squeeze(pts(1,:,:)), squeeze(pts(2,:,:)), squeeze(pts(3,:,:)));
            shading faceted;
        end
    % curve
    else
        order = nurbs.order;
        pts   = nrbeval(nurbs, linspace(nurbs.knots(order), nurbs.knots(end-order+1), nsub));

        write_dat1D(filename, pts(1,:), pts(2,:));

        plot(pts(1,:), pts(2,:));
    end
    axis equal;
end
