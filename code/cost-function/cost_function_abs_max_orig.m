% INPUT:
%       - filename: geometry filename
% OUTPUT:
%       - obj: value of the objective function

function [obj] = cost_function_abs_max_orig (filename)
    tic;
    [problem_data, method_data] = setup_problem (filename);
    [geometry, msh, space, phi] = mp_solve_electrostatics_axi2d (problem_data, method_data);

    iptcs = [18 17 16 15 14];

    obj = 0;
    for ii=1:length(iptcs)
        obj_ptc = computeE_max (phi(space.gnum{iptcs(ii)}), msh.msh_patch{iptcs(ii)}, space.sp_patch{iptcs(ii)}, geometry(iptcs(ii)));
        obj = max([obj obj_ptc]);
    end
    fprintf('\ncost_function_abs_max: %d min\n', toc/60);
end
