% [ptcs_vac, ptcs_el] = create_ptcs_opt (ptcs_vac, ptcs_el, order, crv, continuity)
%
% INPUT:
%       - ptcs_vac: patches describing the vacuum chamber
%       - ptcs_el: patches describing the electrode
%       - order: order of curve to be optimized
%       - crv: curve to be optimized
%       - continuity: continuity of curve to be optimized
% OUTPUT:
%       - ptcs_vac: patches describing the vacuum chamber
%       - ptcs_el: patches describing the electrode

function [ptcs_vac, ptcs_el] = create_ptcs_opt (ptcs_vac, ptcs_el, order, crv, continuity)
    bnds = nrbextract(ptcs_vac(18));
    ptcs_vac(18) = nrbruled(bnds(3), crv(18));
    % elevate degree of adjacent patches
    if (continuity == order-3 && crv(18).knots(order+1) > 0 && crv(18).knots(order+1) < 1)
        bnds = nrbextract(ptcs_vac(18));
        bnds3 = bnds(3);
        bnds = nrbextract(ptcs_vac(21));
        ptcs_vac(21) = nrbcoons(bnds(3), nrbkntins(nrbdegelev(bnds(4), order-3), bnds3.knots(order+1)), bnds(1), bnds(2));
        bnds = nrbextract(ptcs_vac(22));
        ptcs_vac(22) = nrbcoons(bnds(3), nrbkntins(nrbdegelev(bnds(4), order-3), bnds3.knots(order+1)), bnds(1), bnds(2));
    else
        bnds = nrbextract(ptcs_vac(21));
        ptcs_vac(21) = nrbcoons(bnds(3), nrbdegelev(bnds(4), order-3), bnds(1), bnds(2));
        bnds = nrbextract(ptcs_vac(22));
        ptcs_vac(22) = nrbcoons(bnds(3), nrbdegelev(bnds(4), order-3), bnds(1), bnds(2));
    end

    bnds = nrbextract(ptcs_vac(17));
    ptcs_vac(17) = nrbruled(bnds(3), crv(17));
    % elevate degree of adjacent patches
    if (continuity == order-3 && crv(17).knots(order+1) > 0 && crv(17).knots(order+1) < 1)
        bnds  = nrbextract(ptcs_vac(17));
        bnds3 = bnds(3);
        bnds = nrbextract(ptcs_vac(19));
        ptcs_vac(19) = nrbcoons(bnds(3), nrbkntins(nrbdegelev(bnds(4), order-3), bnds3.knots(order+1)), bnds(1), bnds(2));
        bnds = nrbextract(ptcs_vac(20));
        ptcs_vac(20) = nrbcoons(bnds(3), nrbkntins(nrbdegelev(bnds(4), order-3), bnds3.knots(order+1)), bnds(1), bnds(2));
    else
        bnds = nrbextract(ptcs_vac(19));
        ptcs_vac(19) = nrbcoons(bnds(3), nrbdegelev(bnds(4), order-3), bnds(1), bnds(2));
        bnds = nrbextract(ptcs_vac(20));
        ptcs_vac(20) = nrbcoons(bnds(3), nrbdegelev(bnds(4), order-3), bnds(1), bnds(2));
    end

    bnds = nrbextract(ptcs_vac(16));
    ptcs_vac(16) = nrbruled(crv(16), bnds(2));

    bnds = nrbextract(ptcs_vac(15));
    ptcs_vac(15) = nrbruled(crv(15), bnds(2));

    bnds = nrbextract(ptcs_vac(14));
    ptcs_vac(14) = nrbruled(nrbreverse(crv(14)), bnds(4));
    % elevate degree of adjacent patches
    if (continuity == order-2 || continuity == order-3)
        bnds = nrbextract(ptcs_vac(14));
        bnds4 = bnds(4);
        if (bnds4.knots(order+2) > 0 && bnds4.knots(order+2) < 1)
            bnds = nrbextract(ptcs_vac(13));
            ptcs_vac(13) = nrbcoons(nrbkntins(nrbdegelev(bnds(3), order-3), bnds4.knots(order+1:order+2)), bnds(4), bnds(1), bnds(2));
            bnds = nrbextract(ptcs_vac(12));
            ptcs_vac(12) = nrbcoons(nrbkntins(nrbdegelev(bnds(3), order-3), bnds4.knots(order+1:order+2)), bnds(4), bnds(1), bnds(2));
            bnds = nrbextract(ptcs_vac(11));
            ptcs_vac(11) = nrbcoons(nrbkntins(nrbdegelev(bnds(3), order-3), bnds4.knots(order+1:order+2)), bnds(4), bnds(1), bnds(2));
        else
            bnds = nrbextract(ptcs_vac(13));
            ptcs_vac(13) = nrbcoons(nrbkntins(nrbdegelev(bnds(3), order-3), bnds4.knots(order+1)), bnds(4), bnds(1), bnds(2));
            bnds = nrbextract(ptcs_vac(12));
            ptcs_vac(12) = nrbcoons(nrbkntins(nrbdegelev(bnds(3), order-3), bnds4.knots(order+1)), bnds(4), bnds(1), bnds(2));
            bnds = nrbextract(ptcs_vac(11));
            ptcs_vac(11) = nrbcoons(nrbkntins(nrbdegelev(bnds(3), order-3), bnds4.knots(order+1)), bnds(4), bnds(1), bnds(2));
        end
    else
        bnds = nrbextract(ptcs_vac(13));
        ptcs_vac(13) = nrbcoons(nrbdegelev(bnds(3), order-3), bnds(4), bnds(1), bnds(2));
        bnds = nrbextract(ptcs_vac(12));
        ptcs_vac(12) = nrbcoons(nrbdegelev(bnds(3), order-3), bnds(4), bnds(1), bnds(2));
        bnds = nrbextract(ptcs_vac(11));
        ptcs_vac(11) = nrbcoons(nrbdegelev(bnds(3), order-3), bnds(4), bnds(1), bnds(2));
    end

    bnds = nrbextract(ptcs_vac(10));
    ptcs_vac(10) = nrbruled(nrbreverse(crv(10)), bnds(4));

    % electrode
    if (continuity == order-1)
        crv(16) = nrbkntins(crv(16), 0.5*ones(order,1));
        ctrl = crv(16).coefs;
        knts = [zeros(1,order) ones(1,order)];

        il = max(find(crv(16).knots < 1/2));
        ih = min(find(crv(16).knots > 1/2));
        if (crv(16).knots(il) > 0)
            knot = crv(16).knots(il) / (1/2);
            electrode(1) = nrbmak(ctrl(:,1:order+1), [zeros(1,order) knot ones(1,order)]);
            electrode(2) = nrbmak(ctrl(:,order+2:2*order+1), knts);
        elseif (crv(16).knots(ih) < 1)
            knot = (crv(16).knots(ih) - 1/2) / (1/2);
            electrode(1) = nrbmak(ctrl(:,1:order), knts);
            electrode(2) = nrbmak(ctrl(:,order+1:2*order+1), [zeros(1,order) knot ones(1,order)]);
        end
    elseif (continuity == order-2)
        crv(16) = nrbkntins(crv(16), 0.5*ones(order,1));
        ctrl = crv(16).coefs;
        knts = [zeros(1,order) ones(1,order)];

        il = max(find(crv(16).knots < 1/2));
        ih = min(find(crv(16).knots > 1/2));
        knot = crv(16).knots(il) / (1/2);
        knot = [knot ((crv(16).knots(ih) - 1/2) / (1/2))];
        electrode(1) = nrbmak(ctrl(:,1:order+1), [zeros(1,order) knot(1) ones(1,order)]);
        electrode(2) = nrbmak(ctrl(:,order+2:2*order+2), [zeros(1,order) knot(2) ones(1,order)]);
    elseif (continuity == order-3)
        crv(16) = nrbkntins(crv(16), unique(crv(16).knots)(3)*ones(1,order-1));
        ctrl = crv(16).coefs;
        knts = [zeros(1,order) ones(1,order)];

        if (length(unique(crv(16).knots)) == 6)
            knot = unique(crv(16).knots)(2:3) ./ unique(crv(16).knots)(3);
            knot = [knot ((unique(crv(16).knots)(4:5) - unique(crv(16).knots)(3)) ./ (1 - unique(crv(16).knots)(3)))];
            electrode(1) = nrbmak(ctrl(:,1:order+1), [zeros(1,order) knot(1) ones(1,order)]);
            electrode(2) = nrbmak(ctrl(:,order+2:2*order+3), [zeros(1,order) knot(3:4) ones(1,order)]);
        elseif (length(unique(crv(16).knots)) == 5)
            knot = unique(crv(16).knots)(2:3) ./ unique(crv(16).knots)(3);
            knot = [knot ((unique(crv(16).knots)(4) - unique(crv(16).knots)(3)) ./ (1 - unique(crv(16).knots)(3)))];
            electrode(1) = nrbmak(ctrl(:,1:order+1), [zeros(1,order) knot(1) ones(1,order)]);
            electrode(2) = nrbmak(ctrl(:,order+2:2*order+2), [zeros(1,order) knot(3) ones(1,order)]);
        elseif (length(unique(crv(16).knots)) == 7)
            knot = unique(crv(16).knots)(2:3) ./ unique(crv(16).knots)(3);
            knot = [knot ((unique(crv(16).knots)(4:6) - unique(crv(16).knots)(3)) ./ (1 - unique(crv(16).knots)(3)))];
            electrode(1) = nrbmak(ctrl(:,1:order+1), [zeros(1,order) knot(1) ones(1,order)]);
            electrode(2) = nrbmak(ctrl(:,order+2:2*order+4), [zeros(1,order) knot(3:5) ones(1,order)]);
        end
    else
        crv(16) = nrbkntins(crv(16), 0.5*ones(order,1));
        ctrl = crv(16).coefs;
        knts = [zeros(1,order) ones(1,order)];

        electrode(1) = nrbmak(ctrl(:,1:order), knts);
        electrode(2) = nrbmak(ctrl(:,order+1:2*order), knts);
    end

    bnds    = nrbextract(ptcs_el(5));
    bnds(1) = nrbline(nrbeval(crv(17), 0), nrbeval(bnds(1), 1));
    bnds(4) = nrbline(nrbeval(bnds(4), 0), nrbeval(electrode(1), 1));
    ptcs_el(5) = nrbcoons(crv(17), bnds(4), bnds(1), electrode(1));

    bnds5   = nrbextract(ptcs_el(5));
    bnds    = nrbextract(ptcs_el(6));
    bnds(1) = nrbline(nrbeval(crv(18), 0), nrbeval(bnds(1), 1));
    ptcs_el(6) = nrbcoons(crv(18), bnds(4), bnds(1), bnds5(1));

    if (continuity == order-3)
        bnds5   = nrbextract(ptcs_el(5));
        bnds    = nrbextract(ptcs_el(4));
        bnds(1) = nrbline(nrbeval(bnds(1), 0), nrbeval(crv(15), 1));
        bnds(3) = nrbline(nrbeval(bnds(3), 0), nrbeval(electrode(2), 0));
        ptcs_el(4) = nrbcoons(bnds5(4), nrbreverse(crv(15)), bnds(1), electrode(2));

        bnds4 = nrbextract(ptcs_el(4));
        bnds  = nrbextract(ptcs_el(5));
        ptcs_el(5) = nrbcoons(bnds(3), bnds4(3), bnds(1), bnds(2));
    else
        bnds    = nrbextract(ptcs_el(4));
        bnds(1) = nrbline(nrbeval(bnds(1), 0), nrbeval(crv(15), 1));
        bnds(3) = nrbline(nrbeval(bnds(3), 0), nrbeval(electrode(2), 0));
        ptcs_el(4) = nrbcoons(bnds(3), nrbreverse(crv(15)), bnds(1), electrode(2));
    end

    bnds    = nrbextract(ptcs_el(3));
    bnds(2) = nrbline(nrbeval(bnds(2), 0), nrbeval(crv(15), 1));
    bnds(4) = nrbline(nrbeval(bnds(4), 0), nrbeval(crv(15), 1));
    if (continuity == order-1 || continuity == order-2)
        bnds4 = nrbextract(ptcs_el(4));
        ptcs_el(3) = nrbcoons(nrbdegelev(bnds(3), order-3), bnds(4), bnds(1), bnds4(1));
    elseif (continuity == order-3)
        bnds4 = nrbextract(ptcs_el(4));
        bnds6 = nrbextract(ptcs_el(6));
        ptcs_el(3) = nrbcoons(bnds6(4), bnds(4), bnds(1), bnds4(1));
    else
        ptcs_el(3) = nrbcoons(nrbdegelev(bnds(3), order-3), bnds(4), bnds(1), nrbdegelev(bnds(2), order-2));
    end

    bnds3   = nrbextract(ptcs_el(3));
    bnds    = nrbextract(ptcs_el(2));
    bnds(1) = nrbline(nrbeval(bnds(1), 0), nrbeval(crv(14), 1));
    bnds(2) = nrbline(nrbeval(bnds(2), 0), nrbeval(crv(14), 0));
    ptcs_el(2) = nrbcoons(bnds(3), nrbreverse(crv(14)), bnds(1), bnds3(4));

    bnds2   = nrbextract(ptcs_el(2));
    bnds    = nrbextract(ptcs_el(1));
    bnds(1) = nrbline(nrbeval(bnds(1), 0), nrbeval(crv(10), 1));
    bnds(2) = nrbline(nrbeval(bnds(2), 0), nrbeval(crv(10), 0));
    ptcs_el(1) = nrbcoons(bnds(3), nrbreverse(crv(10)), bnds(1), bnds2(1));
end
