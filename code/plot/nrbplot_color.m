% INPUT:
%       - color: color of the line plot
%       - width: width of the line plot
%       - nurbs: 1D nurbs to plot
%       - nsub:  number of subdivisions

function nrbplot_color (color, width, nurbs, nsub)
    nsub  = nsub+1;
    order = nurbs.order;
    pts   = nrbeval (nurbs, linspace(nurbs.knots(order), nurbs.knots(end-order+1), nsub));
    plot (pts(1,:), pts(2,:), 'color', color, 'linewidth', width);
    axis equal;
end
