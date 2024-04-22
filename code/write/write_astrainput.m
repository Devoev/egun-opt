% INPUT:
%       - filename:      output filename
%       - generatorname: filename of generator output
%       - fieldmapname:  filename of fieldmaps
%       - H:             timestep
%       - sc:            flag indicating space charge computation
%       - Nrad:          number of radial grid cells
%       - Cell_var:      size ratio between outermost and innermost cells
%       - Nlong_in:      number of longitudinal grid cells
%       - geometry:      nurbs geometry

function [] = write_astrainput (filename, generatorname, fieldmapname, H, sc, Nrad, Cell_var, Nlong_in, geometry)
    z_min = nrbeval(geometry(6).nurbs, [1 0]);
    z_min = z_min(1);
    z_max = nrbeval(geometry(1).nurbs, [0 1]);
    % including beam pipe
    z_max = z_max(1) + z_max(1)/3;
    % z_max = z_max(1);

    fid = fopen (filename, 'w');

    % newrun
    fprintf(fid, '&NEWRUN\n');
    fprintf(fid, '  Distribution = ''%s''\n', generatorname);
    fprintf(fid, '  Zoff = %d\n', z_min);
    fprintf(fid, '  Z_min = %d\n', z_min);
    fprintf(fid, '  Z_Cathode = %d\n', z_min);
    fprintf(fid, '  H_max = %d\n', H);
    fprintf(fid, '  H_min = %d\n', H);
    fprintf(fid, '/\n');

    % output
    fprintf(fid, '\n&OUTPUT\n');
    fprintf(fid, '  ZSTART = %d\n', z_min);
    fprintf(fid, '  ZSTOP = %d\n', z_max);
    % ~ 1 per mm
    fprintf(fid, '  Zemit = 300\n');
    fprintf(fid, '  EmitS = True\n');
    fprintf(fid, '  TrackS = False\n');
    fprintf(fid, '  RefS = False\n');
    fprintf(fid, '/\n');

    % space charge
    if (sc)
        fprintf(fid, '\n&CHARGE\n');
        fprintf(fid, '  LSPCH = True\n');
        % cylindrical grid
        fprintf(fid, '  Nrad = %d\n', Nrad);
        fprintf(fid, '  Cell_var = %d\n', Cell_var);
        fprintf(fid, '  Nlong_in = %d\n', Nlong_in);
        fprintf(fid, '/\n');
    end

    % E-field
    fprintf(fid, '\n&CAVITY\n');
    fprintf(fid, '  LEField = True\n');
    fprintf(fid, '  File_Efield(1) = ''%s''\n', fieldmapname);
    % electric field in MV/m
    fprintf(fid, '  C_noscale(1) = True\n');
    % all field components are given on the same grid
    fprintf(fid, '  Com_grid(1) = ''E''\n');
    fprintf(fid, '  C_higher_order(1) = True\n');
    fprintf(fid, '  Nue(1) = 0\n');
    fprintf(fid, '/\n');

    fclose (fid);
end
