% INPUT:
%      - filename: filename of the input distribution (.in)

function [] = plot_generator (filename)
    generator = dlmread(filename);
    x = generator(:,1:3);

    % write_dat1D([filename '_probe.dat'], x(1:7,1)*1e3, x(1:7,2)*1e3);
    % write_dat1D([filename '_gen.dat'], x(7:end,1)*1e3, x(7:end,2)*1e3);

    hold on;
    scatter(x(1:7,1)*1e3, x(1:7,2)*1e3, 'r', 'filled', 'marker', 'o');
    scatter(x(7:end,1)*1e3, x(7:end,2)*1e3, 'b', 'marker', 'x');
    hold off;
    xlabel('x in mm');
    ylabel('y in mm');

    dt = 1.5e-3;
    t  = -15e-3:dt:15e-3;
    I  = zeros(length(t),1);
    for it=1:length(t)
        ix    = t(it)-dt < generator(:,7) & generator(:,7) < t(it)+dt;
        I(it) = sum(ix);
    end

    % write_dat1D([filename '_tmp.dat'], t*1e3, I);

    figure;
    plot(t*1e3,I);
    xlabel('t in ps');
    ylabel('N_{part}');
end
