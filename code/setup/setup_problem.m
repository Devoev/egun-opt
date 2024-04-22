% [problem_data, method_data] = setup_problem (geometry_file)
%
% INPUT:
%       - geometry_file: file containing the geometry
% OUTPUT:
%       - problem_data: struct containing problem specific data
%       - method_data: struct containing data about the solution method

function [problem_data, method_data] = setup_problem (geometry_file)
    problem_data.geo_name     = [geometry_file '.txt'];
    problem_data.drchlt_sides = [1 2 3];
    problem_data.nmnn_sides   = [4];

    epsilon_r = 9.4;
    problem_data.epsilon = @(x,y,ip) epsilon(ip, x, y, epsilon_r, geometry_file);

    v_el = -300e3;
    v_ar = 1e3;
    problem_data.f = @(x,y) zeros(size(x));
    problem_data.h = @(x,y,ib) drl_bc (ib, x, y, v_el, v_ar);
    problem_data.g = @(x,y,ib) nm_bc (ib, x, y);

    method_data.degree     = [3 3];
    method_data.regularity = method_data.degree - 1;
    method_data.nsub       = [2^4 2^4];
    method_data.nquad      = method_data.degree + 1;
end
