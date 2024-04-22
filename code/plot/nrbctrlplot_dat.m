% INPUT:
%       - nurbs:    1D nurbs to plot
%       - nsub:     number of subdivision for plotting
%       - filename: output filename

function nrbctrlplot_dat (nurbs, nsub, filename)
    nsub = nsub+1;

    nrbplot_dat (nurbs, nsub, [filename '.dat']);

    % control polygon
    coefs   = nurbs.coefs(1:3,:);
    weights = nurbs.coefs(4,:);
    write_dat1D([filename '_coefs.dat'], coefs(1,:)./weights, coefs(2,:)./weights);
    write_dat1D([filename '_net.dat'], coefs(1,:)./weights, coefs(2,:)./weights);
    plot3(coefs(1,:)./weights, coefs(2,:)./weights, coefs(3,:)./weights, 'k--');
    plot3(coefs(1,:)./weights, coefs(2,:)./weights, coefs(3,:)./weights, 'r.', 'MarkerSize', 20);
end
