% create the 2D photogun geometry
filename = 'geometry_v6';

electrode = create_electrode_v6();

% hold on;
% for icrv=1:length(electrode)
%     nrbplot(electrode(icrv), 20);
%     x = nrbeval(electrode(icrv), 0.5);
%     text(x(1), x(2), num2str(icrv));
% end
% hold off;

anode_ring = create_anodering_v6();

% hold on;
% for icrv=1:length(anode_ring)
%     nrbplot(anode_ring(icrv), 20);
%     x = nrbeval(anode_ring(icrv), 0.5);
%     text(x(1), x(2), num2str(icrv));
% end
% hold off;

inner_insulator = create_innerinsulator_v6();

% hold on;
% for icrv=1:length(inner_insulator)
%     nrbplot(inner_insulator(icrv), 20);
%     x = nrbeval(inner_insulator(icrv), 0.5);
%     text(x(1), x(2), num2str(icrv));
% end
% hold off;

outer_insulator = create_outerinsulator_v6();

% hold on;
% for icrv=1:length(outer_insulator)
%     nrbplot(outer_insulator(icrv), 20);
%     x = nrbeval(outer_insulator(icrv), 0.5);
%     text(x(1), x(2), num2str(icrv));
% end
% hold off;

vacuumchamber = create_vacuumchamber_v6 (electrode, anode_ring, inner_insulator, outer_insulator);

% hold on;
% for icrv=1:length(vacuumchamber)
%     nrbplot(vacuumchamber(icrv), 20);
%     x = nrbeval(vacuumchamber(icrv), 0.5);
%     text(x(1), x(2), num2str(icrv));
% end
% hold off;

domain_vac = discretize_vacuumchamber_v6 (electrode, anode_ring, inner_insulator, outer_insulator, vacuumchamber);

% hold on;
% for icrv=1:length(domain_vac)
%     nrbplot(domain_vac(icrv), 20);
%     x = nrbeval(domain_vac(icrv), 0.5);
%     text(x(1), x(2), num2str(icrv));
% end
% hold off;

[domain_el] = discretize_electrode_v6 (electrode);

% hold on;
% for icrv=1:length(domain_el)
%     nrbplot(domain_el(icrv), 20);
%     x = nrbeval(domain_el(icrv), 0.5);
%     text(x(1), x(2), num2str(icrv));
% end
% hold off;

[ptcs_vac, ptcs_el] = create_ptcs_v6 (electrode, anode_ring, inner_insulator, outer_insulator, vacuumchamber, domain_vac, domain_el);

% figure(1);
% hold on;
% for iptc=1:length(ptcs_vac)
%     nrbkntplot(ptcs_vac(iptc));
%     x = nrbeval(ptcs_vac(iptc), {0.5,0.5});
%     text(x(1), x(2), num2str(iptc));
% end
% hold off;

% figure(2);
% hold on;
% for iptc=1:length(ptcs_el)
%     nrbkntplot(ptcs_el(iptc));
%     x = nrbeval(ptcs_el(iptc), {0.5,0.5});
%     text(x(1), x(2), num2str(iptc));
% end
% hold off;

write_geometryfile_v6 (ptcs_vac, ptcs_el, filename);
