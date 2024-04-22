function [outer_insulator] = create_outerinsulator_v6 ()
    % connection to electrode
    p1 = [252.5e-3 35e-3];
    p2 = [p1(1) 45e-3];
    outer_insulator(1) = nrbline(p1, p2);

    p1 = [222.5e-3 45e-3];
    p2 = [230e-3 45e-3];
    outer_insulator(2) = nrbline(p1, p2);

    p1 = [12.5e-3 62e-3];
    p2 = nrbeval(outer_insulator(2), 0);
    outer_insulator(3) = nrbline(p1, p2);

    p1 = [0 62e-3];
    p2 = nrbeval(outer_insulator(3), 0);
    outer_insulator(4) = nrbline(p1, p2);

    p1 = [0 52e-3];
    p2 = nrbeval(outer_insulator(4), 0);
    outer_insulator(5) = nrbline(p1, p2);

    p1 = nrbeval(outer_insulator(5), 0);
    p2 = [12.5e-3 52e-3];
    outer_insulator(6) = nrbline(p1, p2);

    p1 = nrbeval(outer_insulator(6), 1);
    p2 = [222.5e-3 35e-3];
    outer_insulator(7) = nrbline(p1, p2);

    p1 = nrbeval(outer_insulator(7), 1);
    p2 = [252.5e-3 35e-3];
    outer_insulator(8) = nrbline(p1, p2);

    p1 = nrbeval(outer_insulator(8), 0);
    p2 = nrbeval(outer_insulator(2), 0);
    outer_insulator(9) = nrbline(p1, p2);

    p1 = nrbeval(outer_insulator(7), 0);
    p2 = nrbeval(outer_insulator(3), 0);
    outer_insulator(10) = nrbline(p1, p2);
end
