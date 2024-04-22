function [anode_ring] = create_anodering_v6 ()
    % connection to vacuumchamber
    p1 = [447e-3 20e-3];
    p2 = [p1(1) 30e-3];
    anode_ring(1) = nrbline(p1, p2);

    p1 = [416e-3 30e-3];
    p2 = nrbeval(anode_ring(1), 1);
    anode_ring(2) = nrbline(p1, p2);

    p1 = [406e-3 30e-3];
    p2 = nrbeval(anode_ring(2), 0);
    anode_ring(3) = nrbline(p1, p2);

    p1 = [398e-3 30e-3];
    p2 = nrbeval(anode_ring(3), 0);
    anode_ring(4) = nrbline(p1, p2);

    % top curve
    radius = 5e-3;
    center = [398e-3 25e-3];
    sang   = pi/2;
    eang   = pi;
    anode_ring(5) = nrbcirc(radius, center, sang, eang);
    anode_ring(5) = nrbreverse(anode_ring(5));

    p1 = [393e-3 22e-3];
    p2 = nrbeval(anode_ring(5), 0);
    anode_ring(6) = nrbline(p1, p2);

    % bottom curve
    x1  = [391e-3 13.5e-3];
    dx1 = (22-13.5)/(393-391);
    x2  = [397e-3 11e-3];
    dx2 = (20-11)/(406-397);
    [radius, center, phi1, phi2] = compute_circle_mod (x1, x2, dx1, dx2);
    sang = phi1;
    eang = (phi2+phi1)/2;
    anode_ring(8) = nrbcirc(radius, center, sang, eang);

    sang = (phi2+phi1)/2;
    eang = phi2;
    anode_ring(9) = nrbcirc(radius, center, sang, eang);

    p1 = nrbeval(anode_ring(8), 0);
    p2 = nrbeval(anode_ring(6), 0);
    anode_ring(7) = nrbline(p1, p2);

    p1 = [397e-3 11e-3];
    p2 = [406e-3 20e-3];
    anode_ring(10) = nrbline(p1, p2);

    p1 = nrbeval(anode_ring(10), 1);
    p2 = [416e-3 20e-3];
    anode_ring(11) = nrbline(p1, p2);

    p1 = nrbeval(anode_ring(11), 1);
    p2 = [447e-3 20e-3];
    anode_ring(12) = nrbline(p1, p2);

    p1 = nrbeval(anode_ring(11), 1);
    p2 = nrbeval(anode_ring(3), 1);
    anode_ring(13) = nrbline(p1, p2);

    p1 = nrbeval(anode_ring(11), 0);
    p2 = nrbeval(anode_ring(3), 0);
    anode_ring(14) = nrbline(p1, p2);
end
