% write_geometryfile_opt (ptcs_vac, ptcs_el, filename)
%
% INPUT:
%       - ptcs_vac: patches describing the vacuum chamber
%       - ptcs_el: patches describing the electrode
%       - filename: filename of the geometry file

function [] = write_geometryfile_opt (ptcs_vac, ptcs_el, filename)
    [interfaces, boundaries] = nrbmultipatch (ptcs_vac);
    boundaries = [];

    % electrode
    boundaries(1).patches = [6 7 8 9 10 14 15 16 17 18 18 23 27 28 28 28 29 30 30 31];
    boundaries(1).faces   = [3 3 3 3  3  3  3  3  4  4  1  4  2  3  2  4  4  4  1  4];

    % anode ring
    boundaries(2).patches = [5 13 10 9 8 7 4 3];
    boundaries(2).faces   = [3  1  4 4 4 4 2 2];

    % vacuumchamber
    boundaries(3).patches = [1 1 5 11 11 11 12 13 15 16 19 20 20 22 24 25 34];
    boundaries(3).faces   = [4 2 4  1  4  2  2  2  4  4  2  2  3  3  3  3  3];

    % Neumann
    boundaries(4).patches = [1 2 3 4 6 31 32 33 34];
    boundaries(4).faces   = [1 1 1 1 1  1  1  1  1];

    for ibnd=1:length(boundaries)
        boundaries(ibnd).nsides = length(boundaries(ibnd).patches);
    end

    nrbexport (ptcs_vac, interfaces, boundaries, [filename '.txt']);

    [interfaces, boundaries] = nrbmultipatch (ptcs_el);
    boundaries = [];

    boundaries(1).patches = [1 2 4 4 5 5 6 6 3 2 1 1];
    boundaries(1).faces   = [4 4 4 2 2 3 3 1 1 3 3 1];

    for ibnd=1:length(boundaries)
        boundaries(ibnd).nsides = length(boundaries(ibnd).patches);
    end

    nrbexport (ptcs_el, interfaces, boundaries, 'electrode_v6.txt');
end
