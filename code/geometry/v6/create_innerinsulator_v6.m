function [inner_insulator] = create_innerinsulator_v6 ()
    % connection to electrode (new high voltage adapter not properly included)
    % p1 = [264e-3 21e-3];
    p1 = [264e-3 17.5e-3];
    p2 = [302e-3 17.5e-3];
    inner_insulator(1) = nrbline(p1, p2);

    p1 = [253e-3 27e-3];
    p2 = nrbeval(inner_insulator(1), 0);
    inner_insulator(2) = nrbline(p1, p2);

    p1 = [236e-3 27e-3];
    p2 = nrbeval(inner_insulator(2), 0);
    inner_insulator(3) = nrbline(p1, p2);

    p1 = [46e-3 27e-3];
    p2 = nrbeval(inner_insulator(3), 0);
    inner_insulator(4) = nrbline(p1, p2);

    p1 = [0 27e-3];
    p2 = nrbeval(inner_insulator(4), 0);
    inner_insulator(5) = nrbline(p1, p2);

    p1 = [0 0];
    p2 = nrbeval(inner_insulator(5), 0);
    inner_insulator(6) = nrbline(p1, p2);

    p1 = nrbeval(inner_insulator(6), 0);
    p2 = [46e-3 0];
    inner_insulator(7) = nrbline(p1, p2);

    p1 = nrbeval(inner_insulator(7), 1);
    p2 = [236e-3 0];
    inner_insulator(8) = nrbline(p1, p2);

    p1 = nrbeval(inner_insulator(8), 1);
    p2 = [253e-3 0];
    inner_insulator(9) = nrbline(p1, p2);

    p1 = nrbeval(inner_insulator(9), 1);
    p2 = [264e-3 0];
    inner_insulator(10) = nrbline(p1, p2);

    p1 = nrbeval(inner_insulator(10), 1);
    p2 = nrbeval(inner_insulator(2), 1);
    inner_insulator(11) = nrbline(p1, p2);

    p1 = nrbeval(inner_insulator(9), 1);
    p2 = nrbeval(inner_insulator(3), 1);
    inner_insulator(12) = nrbline(p1, p2);

    p1 = nrbeval(inner_insulator(8), 1);
    p2 = nrbeval(inner_insulator(4), 1);
    inner_insulator(13) = nrbline(p1, p2);

    p1 = nrbeval(inner_insulator(7), 1);
    p2 = nrbeval(inner_insulator(5), 1);
    inner_insulator(14) = nrbline(p1, p2);
end
