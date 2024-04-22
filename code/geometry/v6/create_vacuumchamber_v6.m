function [vacuumchamber] = create_vacuumchamber_v6 (electrode, anode_ring, inner_insulator, outer_insulator)
    % bottom front vertical
    p1 = [447e-3 0];
    p2 = nrbeval(anode_ring(1), 0);
    p2 = [p1(1) p2(2)];
    vacuumchamber(1) = nrbline(p1, p2);

    p1 = nrbeval(anode_ring(1), 1);
    p2 = [447e-3 128e-3];
    vacuumchamber(2) = nrbline(p1, p2);

    p1 = nrbeval(anode_ring(2), 0);
    p2 = nrbeval(vacuumchamber(2), 1);
    p1 = [p1(1) 128e-3];
    vacuumchamber(3) = nrbline(p1, p2);

    p1 = nrbeval(anode_ring(3), 0);
    p2 = nrbeval(vacuumchamber(3), 0);
    p1 = [p1(1) 128e-3];
    vacuumchamber(4) = nrbline(p1, p2);

    p1 = nrbeval(anode_ring(4), 0);
    p2 = nrbeval(vacuumchamber(4), 0);
    p1 = [p1(1) 128e-3];
    vacuumchamber(5) = nrbline(p1, p2);

    p1 = nrbeval(electrode(7), 0);
    p2 = nrbeval(vacuumchamber(5), 0);
    p1 = [p1(1) 128e-3];
    vacuumchamber(6) = nrbline(p1, p2);

    p1 = nrbeval(electrode(8), 0);
    p2 = nrbeval(vacuumchamber(6), 0);
    p1 = [p1(1) 128e-3];
    vacuumchamber(7) = nrbline(p1, p2);

    p1 = nrbeval(outer_insulator(4), 1);
    p2 = nrbeval(vacuumchamber(7), 0);
    p1 = [p1(1) p2(2)];
    vacuumchamber(8) = nrbline(p1, p2);

    p1 = [0 128e-3];
    p2 = nrbeval(vacuumchamber(8), 0);
    vacuumchamber(9) = nrbline(p1, p2);

    p1 = [0 85e-3];
    p2 = nrbeval(vacuumchamber(9), 0);
    vacuumchamber(10) = nrbline(p1, p2);

    p1 = nrbeval(outer_insulator(5), 1);
    p2 = nrbeval(vacuumchamber(10), 0);
    vacuumchamber(11) = nrbline(p1, p2);

    p1 = nrbeval(inner_insulator(6), 1);
    p2 = nrbeval(outer_insulator(5), 0);
    vacuumchamber(12) = nrbline(p1, p2);

    p1 = nrbeval(electrode(1), 0);
    p2 = nrbeval(anode_ring(8), 1);
    p2 = [p2(1) 0];
    vacuumchamber(13) = nrbline(p1, p2);

    p1 = nrbeval(vacuumchamber(13), 1);
    p2 = nrbeval(anode_ring(9), 1);
    p2 = [p2(1) 0];
    vacuumchamber(14) = nrbline(p1, p2);

    p1 = nrbeval(vacuumchamber(14), 1);
    p2 = nrbeval(anode_ring(10), 1);
    p2 = [p2(1) 0];
    vacuumchamber(15) = nrbline(p1, p2);

    p1 = nrbeval(vacuumchamber(15), 1);
    p2 = nrbeval(anode_ring(11), 1);
    p2 = [p2(1) 0];
    vacuumchamber(16) = nrbline(p1, p2);

    p1 = nrbeval(vacuumchamber(16), 1);
    p2 = nrbeval(vacuumchamber(1), 0);
    vacuumchamber(17) = nrbline(p1, p2);
end
