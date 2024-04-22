function [domain] = discretize_electrode_v6 (electrode)
    electrode(8) = nrbkntins(electrode(8), [0.5 0.5]);
    ctrl = electrode(8).coefs;
    knts = [zeros(1,2) ones(1,2)];
    domain(1) = nrbmak(ctrl(:,1:2), knts);
    domain(2) = nrbmak(ctrl(:,3:4), knts);

    p1 = nrbeval(electrode(15), 1);
    p2 = nrbeval(electrode(4), 1);
    domain(3) = nrbline(p1, p2);

    p1 = nrbeval(electrode(14), 1);
    p2 = nrbeval(electrode(5), 1);
    domain(4) = nrbline(p1, p2);

    p1 = nrbeval(electrode(13), 1);
    p2 = nrbeval(electrode(6), 1);
    domain(5) = nrbline(p1, p2);

    p1 = nrbeval(domain(1), 1);
    p2 = nrbeval(electrode(7), 1);
    p1 = [p1(1) p2(2)];
    domain(6) = nrbline(p1, p2);

    p1 = nrbeval(domain(6), 0);
    p2 = nrbeval(domain(1), 1);
    domain(7) = nrbline(p1, p2);

    p1 = nrbeval(electrode(10), 1);
    p2 = nrbeval(domain(7), 0);
    domain(8) = nrbline(p1, p2);

    p1 = nrbeval(electrode(11), 1);
    p2 = nrbeval(domain(7), 0);
    domain(9) = nrbline(p1, p2);
end
