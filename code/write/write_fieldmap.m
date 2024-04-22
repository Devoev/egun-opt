% INPUT:
%       - filename: output filename
%       - Nx: number of grid points in x-direction
%       - x:  x-coordinates
%       - Ny: number of grid points in y-direction
%       - y:  y-coordinates
%       - Nz: number of grid points in z-direction
%       - z:  z-coordinates
%       - E:  electric field values

function [] = write_fieldmap (filename, Nx, x, Ny, y, Nz, z, E)
    fid = fopen([filename '.ex'], 'w');
    dlmwrite(fid, [Nx x], ' ');
    dlmwrite(fid, [Ny y], ' ', 'append', 'on');
    dlmwrite(fid, [Nz z], ' ', 'append', 'on');
    for iz=1:Nz
        for iy=1:Ny
            dlmwrite(fid, reshape(E(:,iy,iz,1), 1, Nx), ' ', 'append', 'on');
        end
    end
    fclose(fid);

    fid = fopen([filename '.ey'], 'w');
    dlmwrite(fid, [Nx x], ' ');
    dlmwrite(fid, [Ny y], ' ', 'append', 'on');
    dlmwrite(fid, [Nz z], ' ', 'append', 'on');
    for iz=1:Nz
        for iy=1:Ny
            dlmwrite(fid, reshape(E(:,iy,iz,2), 1, Nx), ' ', 'append', 'on');
        end
    end
    fclose(fid);

    fid = fopen([filename '.ez'], 'w');
    dlmwrite(fid, [Nx x], ' ');
    dlmwrite(fid, [Ny y], ' ', 'append', 'on');
    dlmwrite(fid, [Nz z], ' ', 'append', 'on');
    for iz=1:Nz
        for iy=1:Ny
            dlmwrite(fid, reshape(E(:,iy,iz,3), 1, Nx), ' ', 'append', 'on');
        end
    end
    fclose(fid);
end
