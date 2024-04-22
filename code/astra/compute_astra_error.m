% OUTPUT:
%       - err_linf: error in maximum norm
%       - err_z:    error of longitudinal quantities

function [err_linf, err_z] = compute_astra_error ()
    % [sim/ref, x/y, xrms/emit]
    err_linf = NaN(2,2,2);

    % [sim/ref, z, xrms/emit]
    err_z = NaN(2,2);

    astra     = dlmread(['results/astra/sim/ref/ref/' 'photogun.Xemit.001']);
    x_ref_ref = [astra(:,1), astra(:,4), astra(:,6)*pi];
    astra = dlmread(['results/astra/sim/ref/' 'photogun.Xemit.001']);
    x_ref = [astra(:,1), astra(:,4), astra(:,6)*pi];
    astra = dlmread(['results/astra/sim/' 'photogun.Xemit.001']);
    x     = [astra(:,1), astra(:,4), astra(:,6)*pi];

    astra     = dlmread(['results/astra/sim/ref/ref/' 'photogun.Yemit.001']);
    y_ref_ref = [astra(:,1), astra(:,4), astra(:,6)*pi];
    astra = dlmread(['results/astra/sim/ref/' 'photogun.Yemit.001']);
    y_ref = [astra(:,1), astra(:,4), astra(:,6)*pi];
    astra = dlmread(['results/astra/sim/' 'photogun.Yemit.001']);
    y     = [astra(:,1), astra(:,4), astra(:,6)*pi];

    astra     = dlmread(['results/astra/sim/ref/ref/' 'photogun.Zemit.001']);
    z_ref_ref = [astra(:,1), astra(:,4), astra(:,6)*pi];
    astra = dlmread(['results/astra/sim/ref/' 'photogun.Zemit.001']);
    z_ref = [astra(:,1), astra(:,4), astra(:,6)*pi];
    astra = dlmread(['results/astra/sim/' 'photogun.Zemit.001']);
    z     = [astra(:,1), astra(:,4), astra(:,6)*pi];

    figure(1);
    hold on;
    plot(x_ref_ref(:,1), x_ref_ref(:,2), x_ref(:,1), x_ref(:,2), x(:,1), x(:,2));
    plot(y_ref_ref(:,1), y_ref_ref(:,2), y_ref(:,1), y_ref(:,2), y(:,1), y(:,2));
    plot(z_ref_ref(:,1), z_ref_ref(:,2), z_ref(:,1), z_ref(:,2), z(:,1), z(:,2));
    xlabel('z in m');
    ylabel('x_{rms} in mm');
    hold off;

    figure(2);
    hold on;
    plot(x_ref_ref(:,1), x_ref_ref(:,3), x_ref(:,1), x_ref(:,3), x(:,1), x(:,3));
    plot(y_ref_ref(:,1), y_ref_ref(:,3), y_ref(:,1), y_ref(:,3), y(:,1), y(:,3));
    plot(z_ref_ref(:,1), z_ref_ref(:,3), z_ref(:,1), z_ref(:,3), z(:,1), z(:,3));
    xlabel('z in m');
    ylabel('\epsilon in mrad mm');
    hold off;

    err_x = (interp1(x(:,1), x(:,2:3), x_ref_ref(:,1)) - x_ref_ref(:,2:3)) ./ x_ref_ref(:,2:3);
    ix    = ~isnan(err_x(:,1)) & ~isnan(err_x(:,2));
    err_x = err_x(ix,:);
    err_x_ref = (interp1(x_ref(:,1), x_ref(:,2:3), x_ref_ref(:,1)) - x_ref_ref(:,2:3)) ./ x_ref_ref(:,2:3);
    ix        = ~isnan(err_x_ref(:,1)) & ~isnan(err_x_ref(:,2));
    err_x_ref = err_x_ref(ix,:);

    err_y = (interp1(y(:,1), y(:,2:3), y_ref_ref(:,1)) - y_ref_ref(:,2:3)) ./ y_ref_ref(:,2:3);
    iy    = ~isnan(err_y(:,1)) & ~isnan(err_y(:,2));
    err_y = err_y(iy,:);
    err_y_ref = (interp1(y_ref(:,1), y_ref(:,2:3), y_ref_ref(:,1)) - y_ref_ref(:,2:3)) ./ y_ref_ref(:,2:3);
    iy        = ~isnan(err_y_ref(:,1)) & ~isnan(err_y_ref(:,2));
    err_y_ref = err_y_ref(iy,:);

    e_z = (interp1(z(:,1), z(:,2:3), z_ref_ref(:,1)) - z_ref_ref(:,2:3)) ./ z_ref_ref(:,2:3);
    iz  = ~isnan(e_z(:,1)) & ~isnan(e_z(:,2));
    e_z = e_z(iz,:);
    e_z_ref = (interp1(z_ref(:,1), z_ref(:,2:3), z_ref_ref(:,1)) - z_ref_ref(:,2:3)) ./ z_ref_ref(:,2:3);
    iz      = ~isnan(e_z_ref(:,1)) & ~isnan(e_z_ref(:,2));
    e_z_ref = e_z_ref(iz,:);

    err_linf(1,1,1) = norm(err_x(:,1), Inf);
    err_linf(1,1,2) = norm(err_x(:,2), Inf);
    err_linf(2,1,1) = norm(err_x_ref(:,1), Inf);
    err_linf(2,1,2) = norm(err_x_ref(:,2), Inf);

    err_linf(1,2,1) = norm(err_y(:,1), Inf);
    err_linf(1,2,2) = norm(err_y(:,2), Inf);
    err_linf(2,2,1) = norm(err_y_ref(:,1), Inf);
    err_linf(2,2,2) = norm(err_y_ref(:,2), Inf);

    err_z(1,1) = norm(e_z(:,1), Inf);
    err_z(1,2) = norm(e_z(:,2), Inf);
    err_z(2,1) = norm(e_z_ref(:,1), Inf);
    err_z(2,2) = norm(e_z_ref(:,2), Inf);
end
