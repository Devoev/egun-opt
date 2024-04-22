function [domain] = discretize_vacuumchamber_v6 (electrode, anode_ring, inner_insulator, outer_insulator, vacuumchamber)
    p1 = nrbeval(vacuumchamber(16),1);
    p2 = nrbeval(anode_ring(12), 0);
    domain(1) = nrbline(p1, p2);

    p1 = nrbeval(vacuumchamber(15), 1);
    p2 = nrbeval(anode_ring(11), 0);
    domain(2) = nrbline(p1, p2);

    p1 = nrbeval(vacuumchamber(14), 1);
    p2 = nrbeval(anode_ring(10), 0);
    domain(3) = nrbline(p1, p2);

    p1 = nrbeval(vacuumchamber(13), 1);
    p2 = nrbeval(anode_ring(9), 0);
    domain(4) = nrbline(p1, p2);

    p1 = nrbeval(electrode(1), 1);
    p2 = nrbeval(anode_ring(8), 1);
    domain(5) = nrbline(p1, p2);

    p1 = nrbeval(electrode(2), 1);
    p2 = nrbeval(anode_ring(8), 0);
    domain(6) = nrbline(p1, p2);

    p1 = nrbeval(electrode(3), 1);
    p2 = nrbeval(anode_ring(7), 1);
    domain(7) = nrbline(p1, p2);

    p1 = nrbeval(electrode(4), 1);
    p2 = nrbeval(anode_ring(6), 1);
    domain(8) = nrbline(p1, p2);

    p1 = nrbeval(electrode(5), 1);
    p2 = nrbeval(anode_ring(5), 1);
    domain(9) = nrbline(p1, p2);

    p1 = nrbeval(anode_ring(2), 0);
    p2 = nrbeval(vacuumchamber(3), 0);
    domain(10) = nrbline(p1, p2);

    p1 = nrbeval(anode_ring(3), 0);
    p2 = nrbeval(vacuumchamber(4), 0);
    domain(11) = nrbline(p1, p2);

    p1 = nrbeval(anode_ring(4), 0);
    p2 = nrbeval(vacuumchamber(5), 0);
    domain(12) = nrbline(p1, p2);

    p1 = nrbeval(electrode(6), 1);
    p2 = nrbeval(vacuumchamber(6), 1);
    domain(13) = nrbline(p1, p2);

    p1 = nrbeval(electrode(7), 0);
    p2 = nrbeval(vacuumchamber(6), 0);
    domain(14) = nrbline(p1, p2);

    p1 = nrbeval(electrode(8), 0);
    p2 = nrbeval(vacuumchamber(7), 0);
    domain(15) = nrbline(p1, p2);

    p1 = [185e-3 65e-3];
    p2 = nrbeval(vacuumchamber(7), 0);
    domain(16) = nrbline(p1, p2);

    p1 = nrbeval(domain(16), 0);
    p2 = nrbeval(electrode(9), 0);
    domain(17) = nrbline(p1, p2);

    p1 = nrbeval(outer_insulator(2), 0);
    p2 = nrbeval(domain(16), 0);
    domain(18) = nrbline(p1, p2);

    p1 = nrbeval(outer_insulator(4), 1);
    p2 = nrbeval(domain(16), 0);
    p1 = [p1(1) 85e-3];
    domain(19) = nrbline(p1, p2);

    p1 = nrbeval(domain(19), 0);
    p2 = nrbeval(vacuumchamber(8), 0);
    domain(20) = nrbline(p1, p2);

    p1 = nrbeval(vacuumchamber(10), 0);
    p2 = nrbeval(domain(19), 0);
    domain(21) = nrbline(p1, p2);

    p1 = nrbeval(outer_insulator(4), 1);
    p2 = nrbeval(domain(19), 0);
    domain(22) = nrbline(p1, p2);

    p1 = nrbeval(inner_insulator(5), 1);
    p2 = nrbeval(outer_insulator(6), 1);
    domain(23) = nrbline(p1, p2);

    p1 = nrbeval(inner_insulator(4), 1);
    p2 = nrbeval(outer_insulator(7), 1);
    domain(24) = nrbline(p1, p2);

    p1 = nrbeval(inner_insulator(3), 1);
    p2 = nrbeval(outer_insulator(8), 1);
    domain(25) = nrbline(p1, p2);

    p1 = nrbeval(outer_insulator(1), 0);
    p2 = nrbeval(electrode(13), 0);
    domain(26) = nrbline(p1, p2);

    p1 = nrbeval(inner_insulator(2), 0);
    p2 = nrbeval(electrode(14), 0);
    domain(27) = nrbline(p1, p2);
end
