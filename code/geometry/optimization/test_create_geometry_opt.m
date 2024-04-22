% Create the geometry to be optimized (based on a continuous NURBS representation).
% <order = n_knts - n_ctrl> with <order = degree + 1> (p+1 knot spans support for degree=p)
% Curve is degree-n_mult (number of knot repetitions) times differentiable in any point.

% Perform knot insertion to achieve multiplicity equal to order for each knot. This does not change the shape of the curve, however it makes the NURBS only C^0 (interpolatory) in the knots which allows for the cutting into separate disjoint NURBS that each have the same order and maintain the same shape (and same continuity at the interfaces).

% Use a smooth NURBS (arbitrary order) to start. Then insert knots at predetermined positions to split into the individual curves.
% Increase the degree of the entire NURBS to investigate convergence.
% Insert knots, each knot adds a control point.

order = 8;
continuity = 5;
if (continuity < order)
    filename = ['v6_opt_order=' num2str(order) '_continuity=' num2str(continuity)];
else
    filename = ['v6_opt_order=' num2str(order)];
end

if (order >= 8)
    N_ctrl = order-3;
    if (continuity == order-1)
        N_ctrl = N_ctrl + 1;
    elseif (continuity == order-2)
        N_ctrl = N_ctrl + 3;
    elseif (continuity == order-3)
        N_ctrl = N_ctrl + 6;
    end
end
x = zeros(2*N_ctrl,1);
x = 1e-2*rand(2*N_ctrl,1);

tic;
create_geometry_opt (filename, x, order, continuity);
fprintf('\ncreate_geometry_opt: %d s\n', toc);
return
% figure;
% geometry = mp_geo_load ([filename '.txt']);
% for iptc=1:length(geometry)
%     hold on;
%     nrbkntplot(geometry(iptc).nurbs);
%     xt = nrbeval(geometry(iptc).nurbs, {0.5,0.5});
%     text(xt(1), xt(2), num2str(iptc));
%     hold off;
% end
% shading interp;

figure;
geometry = mp_geo_load ('electrode_v6.txt');
for iptc=1:length(geometry)
    hold on;
    nrbkntplot(geometry(iptc).nurbs);
    xt = nrbeval(geometry(iptc).nurbs, {0.5,0.5});
    text(xt(1), xt(2), num2str(iptc));
    hold off;
end
shading interp;
