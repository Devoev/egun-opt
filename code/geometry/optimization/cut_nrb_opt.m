% [crv] = cut_nrb_opt (nrb_opt, order, knts, ptcs_vac, continuity)
%
% INPUT:
%       - nrb_opt: curve to be optimized
%       - order: order of curve to be optimized
%       - knts: knots of curve to be optimized
%       - ptcs_vac: patches describing the vacuum chamber
%       - continuity: continuity of curve to be optimized
% OUTPUT:
%       - crv: array containing individual parts of the curve (per intersecting patch)

function [crv] = cut_nrb_opt (nrb_opt, order, knts, ptcs_vac, continuity)
    if (order >= 8)
        % possibly specify different starting intervals
        bnds    = nrbextract(ptcs_vac(18));
        crv(18) = bnds(2);
        pt(18)  = compute_intersectionu(nrb_opt, crv(18), [0 0.25]);

        bnds    = nrbextract(ptcs_vac(17));
        crv(17) = bnds(2);
        pt(17)  = compute_intersectionv(nrb_opt, crv(17), [0.1 0.5]);

        bnds    = nrbextract(ptcs_vac(16));
        crv(16) = bnds(4);
        pt(16)  = compute_intersectionv(nrb_opt, crv(16), [0.5 0.75]);

        bnds    = nrbextract(ptcs_vac(15));
        crv(15) = bnds(4);
        pt(15)  = compute_intersectionv(nrb_opt, crv(15), [0.5 0.85]);

        bnds    = nrbextract(ptcs_vac(14));
        crv(14) = bnds(1);
        % orientation of curve is reversed
        pt(14)  = compute_intersectionu(nrb_opt, crv(14), [1 0.65]);

        knts = [pt(18) pt(17) pt(16) pt(15) pt(14)];
        for ii=1:order
            nrb_opt = nrbkntins(nrb_opt, knts);
        end
    end

    % cut the individual NURBS
    if (continuity == order-1)
        il = max(find(knts < 1/2));
        ih = min(find(knts > 1/2));
        knot = (1/2 - knts(il)) / (knts(ih) - knts(il));

        knts = [zeros(1,order) ones(1,order)];
        ctrl18  = nrb_opt.coefs(:,1:order);
        crv(18) = nrbmak(ctrl18, knts);

        ctrl17  = nrb_opt.coefs(:,order+1:2*order);
        crv(17) = nrbmak(ctrl17, knts);

        ctrl16  = nrb_opt.coefs(:,2*order+1:3*order+1);
        crv(16) = nrbmak(ctrl16, [zeros(1,order) knot ones(1,order)]);

        ctrl15  = nrb_opt.coefs(:,3*order+2:4*order+1);
        crv(15) = nrbmak(ctrl15, knts);

        ctrl14  = nrb_opt.coefs(:,4*order+2:5*order+1);
        crv(14) = nrbmak(ctrl14, knts);

        ctrl10  = nrb_opt.coefs(:,5*order+2:6*order+1);
        crv(10) = nrbmak(ctrl10, knts);
    elseif (continuity == order-2)
        knts = sort([0 knts 1]);

        il = max(find(knts < 1/4));
        ih(1) = min(find(knts > 1/4));
        knots = (1/4 - knts(il)) / (knts(ih(1)) - knts(il));
        if (ih(1) ~= 4)
            error('knot has shifted');
        end

        il = max(find(knts < 1/2));
        ih(2) = min(find(knts > 1/2));
        knots = [knots (1/2 - knts(il)) / (knts(ih(2)) - knts(il))];
        if (ih(2) ~= 4)
            error('knot has shifted');
        end

        il = max(find(knts < 3/4));
        ih(3) = min(find(knts > 3/4));
        knots = [knots (3/4 - knts(il)) / (knts(ih(3)) - knts(il))];
        if (ih(3) ~= 6)
            error('knot has shifted');
        end

        knts = [zeros(1,order) ones(1,order)];
        ctrl18  = nrb_opt.coefs(:,1:order);
        crv(18) = nrbmak(ctrl18, knts);

        ctrl17  = nrb_opt.coefs(:,order+1:2*order);
        crv(17) = nrbmak(ctrl17, knts);

        ctrl16  = nrb_opt.coefs(:,2*order+1:3*order+2);
        crv(16) = nrbmak(ctrl16, [zeros(1,order) knots(1:2) ones(1,order)]);

        ctrl15  = nrb_opt.coefs(:,3*order+3:4*order+2);
        crv(15) = nrbmak(ctrl15, knts);

        ctrl14  = nrb_opt.coefs(:,4*order+3:5*order+3);
        crv(14) = nrbmak(ctrl14, [zeros(1,order) knots(3) ones(1,order)]);

        ctrl10  = nrb_opt.coefs(:,5*order+4:6*order+3);
        crv(10) = nrbmak(ctrl10, knts);
    elseif (continuity == order-3)
        knts = sort([0 knts 1]);

        % 18/17
        il = max(find(knts < 1/8));
        ih(1) = min(find(knts > 1/8));
        knots = (1/8 - knts(il)) / (knts(ih(1)) - knts(il));
        if ((ih(1) ~= 2) && (ih(1) ~= 3) && (ih(1) ~= 4))
            error('knot has shifted');
        end

        % 16
        il = max(find(knts < 1/4));
        ih(2) = min(find(knts > 1/4));
        knots = [knots (1/4 - knts(il)) / (knts(ih(2)) - knts(il))];
        if (ih(2) ~= 4)
            error('knot has shifted');
        end

        il = max(find(knts < 3/8));
        ih(3) = min(find(knts > 3/8));
        knots = [knots (3/8 - knts(il)) / (knts(ih(3)) - knts(il))];
        if (ih(3) ~= 4)
            error('knot has shifted');
        end

        il = max(find(knts < 1/2));
        ih(4) = min(find(knts > 1/2));
        knots = [knots (1/2 - knts(il)) / (knts(ih(4)) - knts(il))];
        if (ih(4) ~= 4)
            error('knot has shifted');
        end

        % 16/15
        il = max(find(knts < 5/8));
        ih(5) = min(find(knts > 5/8));
        knots = [knots (5/8 - knts(il)) / (knts(ih(5)) - knts(il))];
        if ((ih(5) ~= 4) && (ih(5) ~= 5) && (ih(5) ~= 6))
            ih
            error('knot has shifted');
        end

        % 14
        il = max(find(knts < 3/4));
        ih(6) = min(find(knts > 3/4));
        knots = [knots (3/4 - knts(il)) / (knts(ih(6)) - knts(il))];
        if (ih(6) ~= 6)
            error('knot has shifted');
        end

        % 10
        il = max(find(knts < 7/8));
        ih(7) = min(find(knts > 7/8));
        knots = [knots (7/8 - knts(il)) / (knts(ih(7)) - knts(il))];
        if (ih(7) ~= 7)
            ih
            error('knot has shifted');
        end

        knts = [zeros(1,order) ones(1,order)];
        if (ih(1) == 2)
            ctrl18  = nrb_opt.coefs(:,1:order+1);
            crv(18) = nrbmak(ctrl18, [zeros(1,order) knots(1) ones(1,order)]);

            ctrl17  = nrb_opt.coefs(:,order+2:2*order+1);
            crv(17) = nrbmak(ctrl17, knts);
        elseif (ih(1) == 3)
            ctrl18  = nrb_opt.coefs(:,1:order);
            crv(18) = nrbmak(ctrl18, knts);

            ctrl17  = nrb_opt.coefs(:,order+1:2*order+1);
            crv(17) = nrbmak(ctrl17, [zeros(1,order) knots(1) ones(1,order)]);
        elseif (ih(1) == 4)
            ctrl18  = nrb_opt.coefs(:,1:order);
            crv(18) = nrbmak(ctrl18, knts);

            ctrl17  = nrb_opt.coefs(:,order+1:2*order);
            crv(17) = nrbmak(ctrl17, knts);
        end

        if (ih(5) == 4)
            if (ih(1) < 4)
                ctrl16  = nrb_opt.coefs(:,2*order+2:3*order+5);
                crv(16) = nrbmak(ctrl16, [zeros(1,order) knots(2:5) ones(1,order)]);

                ctrl15  = nrb_opt.coefs(:,3*order+6:4*order+5);
                crv(15) = nrbmak(ctrl15, knts);
            else
                ctrl16  = nrb_opt.coefs(:,2*order+1:3*order+5);
                crv(16) = nrbmak(ctrl16, [zeros(1,order) knots(1:5) ones(1,order)]);

                ctrl15  = nrb_opt.coefs(:,3*order+6:4*order+5);
                crv(15) = nrbmak(ctrl15, knts);
            end
        elseif (ih(5) == 5)
            if (ih(1) < 4)
                ctrl16  = nrb_opt.coefs(:,2*order+2:3*order+4);
                crv(16) = nrbmak(ctrl16, [zeros(1,order) knots(2:4) ones(1,order)]);

                ctrl15  = nrb_opt.coefs(:,3*order+5:4*order+5);
                crv(15) = nrbmak(ctrl15, [zeros(1,order) knots(5) ones(1,order)]);
            else
                ctrl16  = nrb_opt.coefs(:,2*order+1:3*order+4);
                crv(16) = nrbmak(ctrl16, [zeros(1,order) knots(1:4) ones(1,order)]);

                ctrl15  = nrb_opt.coefs(:,3*order+5:4*order+5);
                crv(15) = nrbmak(ctrl15, [zeros(1,order) knots(5) ones(1,order)]);
            end
        elseif (ih(5) == 6)
            if (ih(1) < 4)
                ctrl16  = nrb_opt.coefs(:,2*order+2:3*order+4);
                crv(16) = nrbmak(ctrl16, [zeros(1,order) knots(2:4) ones(1,order)]);

                ctrl15  = nrb_opt.coefs(:,3*order+5:4*order+4);
                crv(15) = nrbmak(ctrl15, knts);
            else
                ctrl16  = nrb_opt.coefs(:,2*order+1:3*order+4);
                crv(16) = nrbmak(ctrl16, [zeros(1,order) knots(1:4) ones(1,order)]);

                ctrl15  = nrb_opt.coefs(:,3*order+5:4*order+4);
                crv(15) = nrbmak(ctrl15, knts);
            end
        end

        if (ih(5) == 6)
            ctrl14  = nrb_opt.coefs(:,4*order+5:5*order+6);
            crv(14) = nrbmak(ctrl14, [zeros(1,order) knots(5:6) ones(1,order)]);
        else
            ctrl14  = nrb_opt.coefs(:,4*order+6:5*order+6);
            crv(14) = nrbmak(ctrl14, [zeros(1,order) knots(6) ones(1,order)]);
        end

        ctrl10  = nrb_opt.coefs(:,5*order+7:6*order+7);
        crv(10) = nrbmak(ctrl10, [zeros(1,order) knots(7) ones(1,order)]);
    else
        knts = [zeros(1,order) ones(1,order)];
        ctrl18  = nrb_opt.coefs(:,1:order);
        crv(18) = nrbmak(ctrl18, knts);

        ctrl17  = nrb_opt.coefs(:,order+1:2*order);
        crv(17) = nrbmak(ctrl17, knts);

        ctrl16  = nrb_opt.coefs(:,2*order+1:3*order);
        crv(16) = nrbmak(ctrl16, knts);

        ctrl15  = nrb_opt.coefs(:,3*order+1:4*order);
        crv(15) = nrbmak(ctrl15, knts);

        ctrl14  = nrb_opt.coefs(:,4*order+1:5*order);
        crv(14) = nrbmak(ctrl14, knts);

        ctrl10  = nrb_opt.coefs(:,5*order+1:6*order);
        crv(10) = nrbmak(ctrl10, knts);
    end
end
