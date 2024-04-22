% INPUT:
%       - filename: output filename
%       - z:        cathode offset

function [] = plot_astra (filename, z)
    astra = dlmread([filename '.Xemit.001']);
    x  = [astra(:,1), astra(:,4), astra(:,6)*pi];
    ix = find(x(:,1) <= z);
    x  = x(1:ix(end), :);

    write_dat1D([filename '_xrms.dat'], x(:,1), x(:,2));
    write_dat1D([filename '_xeps.dat'], x(:,1), x(:,3));

    astra = dlmread([filename '.Yemit.001']);
    y  = [astra(:,1), astra(:,4), astra(:,6)*pi];
    iy = find(y(:,1) <= z);
    y  = y(1:iy(end), :);

    write_dat1D([filename '_yrms.dat'], y(:,1), y(:,2));
    write_dat1D([filename '_yeps.dat'], y(:,1), y(:,3));

    hold on;
    subplot(2,1,1);
    plot(x(:,1), x(:,2), y(:,1), y(:,2));
    plot(x(:,1), x(:,3), y(:,1), y(:,3));
    hold off;
    legend('x_{rms}', '\epsilon');
    xlabel('z in m');
    hold off;

    astra = dlmread([filename '.Zemit.001']);
    Z  = [astra(:,1), astra(:,4), astra(:,6)*pi];
    iZ = find(Z(:,1) <= z);
    Z  = Z(1:iZ(end), :);

    hold on;
    subplot(2,1,2);
    plot(Z(:,1), Z(:,2), Z(:,1), Z(:,3));
    hold off;
    legend('z_{rms}', '\epsilon');
    xlabel('z in m');
    hold off;

    write_dat1D([filename '_zrms.dat'], Z(:,1), Z(:,2));
    write_dat1D([filename '_zeps.dat'], Z(:,1), Z(:,3));
end
