function [electrode] = create_electrode_v6 ()
    % photocathode
    p1 = [307e-3 0];
    p2 = [p1(1) 5e-3];
    electrode(1) = nrbline(p1, p2);

    p1 = nrbeval(electrode(1), 1);
    p2 = [307.5e-3 9.9e-3];
    electrode(2) = nrbline(p1, p2);

    p1 = nrbeval(electrode(2), 1);
    p2 = [311.5e-3 20e-3];
    electrode(3) = nrbline(p1, p2);

    % lift cutout
    p1 = nrbeval(electrode(3), 0);
    p2 = nrbeval(electrode(3), 1);
    a = (p2(2)-p1(2))/(p2(1)-p1(1));
    b = p2(2) - a*p2(1);

    p1 = [(17.5e-3-b)/a 17.5e-3];
    p2 = nrbeval(electrode(3), 1);
    electrode(4) = nrbline(p1, p2);

    p1 = nrbeval(electrode(3), 0);
    p2 = nrbeval(electrode(4), 0);
    electrode(3) = nrbline(p1, p2);

    % front top curve
    % lower point and slope
    r_l = [318.8e-3 37.8e-3];
    phi_l = 67.5*pi/180;
    s_l = -tan(pi - phi_l);
    % upper point and slope
    r_u = [305e-3 59.9e-3];
    s_u = (59.9-65)/(305-230.1);

    [radius, x_0, y_0, phi_l, phi_u] = compute_circle (r_l, r_u, s_l, s_u);
    center = [x_0 y_0];
    sang = phi_l;
    eang = (phi_u+phi_l)/2;
    electrode(6) = nrbcirc(radius, center, sang, eang);

    sang = (phi_u+phi_l)/2;
    eang = phi_u;
    electrode(7) = nrbcirc(radius, center, sang, eang);
    electrode(7) = nrbreverse(electrode(7));

    % front connection with photocathode
    p1 = nrbeval(electrode(4), 1);
    p2 = nrbeval(electrode(6), 0);
    electrode(5) = nrbline(p1, p2);

    % back curve
    radius = 10e-3;
    center = [230e-3 55e-3];
    sang = pi/2;
    eang = pi;
    electrode(9) = nrbcirc(radius, center, sang, eang);
    electrode(9) = nrbreverse(electrode(9));

    sang = pi;
    eang = 3*pi/2;
    electrode(10) = nrbcirc(radius, center, sang, eang);
    electrode(10) = nrbreverse(electrode(10));

    p1 = nrbeval(electrode(9), 1);
    p2 = nrbeval(electrode(7), 0);
    electrode(8) = nrbline(p1, p2);

    % insulator connection
    p1 = nrbeval(electrode(10), 0);
    p2 = [252.5e-3 45e-3];
    electrode(11) = nrbline(p1, p2);

    % lift connection
    p1 = nrbeval(electrode(11), 1);
    p2 = [302e-3 45e-3];
    electrode(12) = nrbline(p1, p2);

    p1 = nrbeval(electrode(5), 1);
    p2 = nrbeval(electrode(12), 1);
    p1 = [p2(1) p1(2)];
    electrode(13) = nrbline(p1, p2);

    % cut here to evaluate volume constraint, discretize inside
    p1 = [302e-3 20.4e-3];
    p2 = nrbeval(electrode(13), 0);
    electrode(14) = nrbline(p1, p2);

    p1 = [302e-3 17.5e-3];
    p2 = nrbeval(electrode(14), 0);
    electrode(15) = nrbline(p1, p2);
end
