% [nrb_opt, knts, ptcs_vac, ptcs_el, nrb_orig] = create_nrb_opt_electrode (order)
%
% INPUT:
%       - order: order of curve to be optimized
% OUTPUT:
%       - nrb_opt: curve to be optimized
%       - knts: knots of curve to be optimized
%       - ptcs_vac: patches describing the vacuum chamber
%       - ptcs_el: patches describing the electrode
%       - nrb_orig: original curve

function [nrb_opt, knts, ptcs_vac, ptcs_el, nrb_orig] = create_nrb_opt_electrode (order)
    electrode       = create_electrode_v6();
    anode_ring      = create_anodering_v6();
    inner_insulator = create_innerinsulator_v6();
    outer_insulator = create_outerinsulator_v6();
    vacuumchamber   = create_vacuumchamber_v6 (electrode, anode_ring, inner_insulator, outer_insulator);
    domain_vac      = discretize_vacuumchamber_v6 (electrode, anode_ring, inner_insulator, outer_insulator, vacuumchamber);
    domain_el       = discretize_electrode_v6 (electrode);
    [ptcs_vac, ptcs_el] = create_ptcs_v6 (electrode, anode_ring, inner_insulator, outer_insulator, ...
                                          vacuumchamber, domain_vac, domain_el);

    bnds    = nrbextract(ptcs_vac(10));
    crv(10) = bnds(3);
    bnds    = nrbextract(ptcs_vac(14));
    crv(14) = bnds(3);
    bnds    = nrbextract(ptcs_vac(15));
    crv(15) = bnds(1);
    bnds    = nrbextract(ptcs_vac(16));
    crv(16) = bnds(1);
    bnds    = nrbextract(ptcs_vac(17));
    crv(17) = bnds(4);
    bnds    = nrbextract(ptcs_vac(18));
    crv(18) = bnds(4);

    % glue nurbs
    if (order >= 8)
        % B-spline
        ctrl = [crv(18).coefs(:,1:2)./crv(18).coefs(4,1:2) crv(17).coefs(:,2)./crv(17).coefs(4,2) ...
                crv(16).coefs(:,2)./crv(16).coefs(4,2) crv(15).coefs(:,2)./crv(15).coefs(4,2) ...
                flip(crv(14).coefs(:,2)./crv(14).coefs(4,2), 2) flip(crv(10).coefs(:,1:2)./crv(10).coefs(4,1:2), 2)];
        knts = [zeros(1,8) ones(1,8)];
        nrb_opt = nrbmak(ctrl, knts);

        if (nargout == 5)
            % glue crv
            nrb_orig = nrbglue(crv(18), crv(17));
            nrb_orig = nrbglue(nrb_orig, crv(16));
            nrb_orig = nrbglue(nrb_orig, crv(15));
            nrb_orig = nrbglue(nrb_orig, crv(14));
            nrb_orig = nrbglue(nrb_orig, crv(10));
            nrb_orig.knots = nrb_orig.knots/6;
        end
    else
        error('create_nrb_opt_electrode: order = %i not implemented', order);
    end
end
