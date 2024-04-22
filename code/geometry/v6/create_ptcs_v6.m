function [ptcs_vac, ptcs_el] = create_ptcs_v6 (electrode, anode_ring, inner_insulator, outer_insulator, vacuumchamber, domain_vac, domain_el)
    % anode ring
    ptcs_vac(1) = nrbcoons(domain_vac(1), vacuumchamber(1), vacuumchamber(17), anode_ring(12));
    ptcs_vac(2) = nrbcoons(domain_vac(2), domain_vac(1), vacuumchamber(16), nrbdegelev(anode_ring(11), 1));
    ptcs_vac(3) = nrbcoons(domain_vac(3), domain_vac(2), vacuumchamber(15), nrbdegelev(anode_ring(10), 1));
    ptcs_vac(4) = nrbcoons(domain_vac(4), domain_vac(3), vacuumchamber(14), anode_ring(9));
    ptcs_vac(5) = nrbcoons(anode_ring(14), anode_ring(13), nrbdegelev(anode_ring(11), 1), nrbdegelev(anode_ring(3), 1));

    % beam
    ptcs_vac(6) = nrbcoons(electrode(1), domain_vac(4), vacuumchamber(13), domain_vac(5));
    ptcs_vac(7) = nrbcoons(electrode(2), nrbreverse(anode_ring(8)), domain_vac(5), domain_vac(6));
    ptcs_vac(8) = nrbcoons(electrode(3), nrbdegelev(anode_ring(7), 1), domain_vac(6), domain_vac(7));
    ptcs_vac(9) = nrbcoons(electrode(4), nrbdegelev(anode_ring(6), 1), domain_vac(7), domain_vac(8));
    ptcs_vac(10) = nrbcoons(electrode(5), anode_ring(5), domain_vac(8), domain_vac(9));

    % front corner
    ptcs_vac(11) = nrbcoons(nrbdegelev(domain_vac(10), 1), vacuumchamber(2), anode_ring(2), vacuumchamber(3));
    ptcs_vac(12) = nrbcoons(nrbdegelev(domain_vac(11), 1), domain_vac(10), nrbdegelev(anode_ring(3), 1), vacuumchamber(4));
    ptcs_vac(13) = nrbcoons(nrbdegelev(domain_vac(12), 1), domain_vac(11), nrbdegelev(anode_ring(4), 1), vacuumchamber(5));
    ptcs_vac(14) = nrbcoons(electrode(6), domain_vac(12), domain_vac(9), domain_vac(13));

    % electrode
    ptcs_vac(15) = nrbcoons(domain_vac(14), domain_vac(13), electrode(7), vacuumchamber(6));
    ptcs_vac(16) = nrbcoons(domain_vac(15), domain_vac(14), nrbdegelev(electrode(8), 1), vacuumchamber(7));
    ptcs_vac(17) = nrbcoons(domain_vac(16), electrode(9), domain_vac(17), nrbreverse(domain_vac(15)));
    ptcs_vac(18) = nrbcoons(domain_vac(18), electrode(10), outer_insulator(2), domain_vac(17));

    % back corner
    ptcs_vac(19) = nrbcoons(domain_vac(20), nrbdegelev(domain_vac(16), 1), domain_vac(19), vacuumchamber(8));
    ptcs_vac(20) = nrbcoons(vacuumchamber(10), nrbdegelev(domain_vac(20), 1), domain_vac(21), vacuumchamber(9));
    ptcs_vac(21) = nrbcoons(domain_vac(22), nrbdegelev(domain_vac(18), 1), outer_insulator(3), domain_vac(19));
    ptcs_vac(22) = nrbcoons(vacuumchamber(11), nrbdegelev(domain_vac(22), 1), outer_insulator(4), domain_vac(21));

    % outer insulator
    ptcs_vac(23) = nrbcoons(outer_insulator(10), outer_insulator(9), outer_insulator(7), outer_insulator(3));
    ptcs_vac(24) = nrbcoons(outer_insulator(5), outer_insulator(10), outer_insulator(6), outer_insulator(4));

    % lift
    ptcs_vac(25) = nrbcoons(vacuumchamber(12), domain_vac(23), inner_insulator(5), outer_insulator(6));
    ptcs_vac(26) = nrbcoons(domain_vac(23), domain_vac(24), inner_insulator(4), outer_insulator(7));
    ptcs_vac(27) = nrbcoons(domain_vac(24), domain_vac(25), inner_insulator(3), outer_insulator(8));
    ptcs_vac(28) = nrbcoons(outer_insulator(1), electrode(13), domain_vac(26), electrode(12));
    ptcs_vac(29) = nrbcoons(domain_vac(25), electrode(14), domain_vac(27), domain_vac(26));
    ptcs_vac(30) = nrbcoons(nrbreverse(inner_insulator(2)), electrode(15), inner_insulator(1), domain_vac(27));

    % inner insulator
    ptcs_vac(31) = nrbcoons(inner_insulator(12), inner_insulator(11), inner_insulator(10), inner_insulator(2));
    ptcs_vac(32) = nrbcoons(inner_insulator(13), inner_insulator(12), inner_insulator(9), inner_insulator(3));
    ptcs_vac(33) = nrbcoons(inner_insulator(14), inner_insulator(13), inner_insulator(8), inner_insulator(4));
    ptcs_vac(34) = nrbcoons(inner_insulator(6), inner_insulator(14), inner_insulator(7), inner_insulator(5));

    % electrode
    ptcs_el(1) = nrbcoons(electrode(14), electrode(5), nrbdegelev(domain_el(3), 1), domain_el(4));
    ptcs_el(2) = nrbcoons(electrode(13), electrode(6), nrbdegelev(domain_el(4), 1), domain_el(5));
    ptcs_el(3) = nrbcoons(domain_el(9), nrbdegelev(domain_el(5), 1), electrode(12), domain_el(6));
    ptcs_el(4) = nrbcoons(domain_el(7), nrbreverse(electrode(7)), domain_el(6), domain_el(2));
    ptcs_el(5) = nrbcoons(electrode(9), domain_el(7), domain_el(8), domain_el(1));
    ptcs_el(6) = nrbcoons(electrode(10), domain_el(9), electrode(11), domain_el(8));
end
