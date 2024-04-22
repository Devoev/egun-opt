% INPUT:
%       - geometry: nurbs geometry
%       - space:    GeoPDEs space
%       - phi:      GeoPDEs solution vector
%       - x:        x-coordinates
%       - y:        y-coordinates
%       - z:        z-coordinates
% OUTPUT:
%       - E:  electric field values
%       - Nx: number of x-coordinates
%       - Ny: number of y-coordinates
%       - Nz: number of z-coordinates

function [E, Nx, Ny, Nz] = compute_fieldmap (geometry, space, phi, x, y, z)
    Nx = length(x);
    Ny = length(y);
    Nz = length(z);
    % parametric coordinates and patch index
    X = NaN(Nx,Ny,Nz,3);
    % center given by (Nx,Ny,iz)
    E = zeros(2*Nx-1, 2*Ny-1, Nz, 3);

    % compute parametric coordinates
    tic;
    for iz=1:Nz
        if (mod(iz,16) == 0)
            fprintf('\ncompute_fieldmap: nz=%i\n', iz);
        end

        for iy=1:Ny
            for ix=1:Nx
                % transform cartesian to polar coordinates
                [theta, rho]  = cart2pol(x(ix), y(iy));
                % transform to cartesian (parametric) coordinates
                [x_par, iptc] = phy2par([z(iz) rho 0], geometry);

                X(ix,iy,iz,:) = [x_par(1) x_par(2) iptc];
            end
        end
    end
    printf('\n compute parametric coordinates: %d min \n', toc/60);

    % evaluate electric field
    tic;
    for iz=1:Nz
        if (mod(iz,16) == 0)
            fprintf('\ncompute_fieldmap: nz=%i\n', iz);
        end
        for iy=1:Ny
            for ix=1:Nx
                % E_2d = -sp_eval (phi(space.gnum{iptc}), space.sp_patch{iptc}, geometry(iptc), {x_par(1), x_par(2)}, 'gradient');

                iptc = X(ix,iy,iz,3);
                E_2d = -sp_eval (phi(space.gnum{iptc}), space.sp_patch{iptc}, geometry(iptc), {X(ix,iy,iz,1), X(ix,iy,iz,2)}, 'gradient');

                % 1^st quadrant
                E(Nx-1+ix,Ny-1+iy,iz,:) = [E_2d(2)*cos(theta) E_2d(2)*sin(theta) E_2d(1)];
                % 2^nd quadrant
                E(Nx+1-ix,Ny-1+iy,iz,:) = [-E_2d(2)*cos(theta) E_2d(2)*sin(theta) E_2d(1)];
                % 3^rd quadrant
                E(Nx+1-ix,Ny+1-iy,iz,:) = [-E_2d(2)*cos(theta) -E_2d(2)*sin(theta) E_2d(1)];
                % 4^th quadrant
                E(Nx-1+ix,Ny+1-iy,iz,:) = [E_2d(2)*cos(theta) -E_2d(2)*sin(theta) E_2d(1)];
                if (x(ix) == 0)
                    % manually set on axis x-component to zero
                    E(Nx-1+ix,Ny-1+iy,iz,1) = 0;
                    E(Nx+1-ix,Ny-1+iy,iz,1) = 0;
                    E(Nx+1-ix,Ny+1-iy,iz,1) = 0;
                    E(Nx-1+ix,Ny-1+iy,iz,1) = 0;
                end
                if (y(iy) == 0)
                    % manually set on axis y-component to zero
                    E(Nx-1+ix,Ny-1+iy,iz,2) = 0;
                    E(Nx+1-ix,Ny-1+iy,iz,2) = 0;
                    E(Nx+1-ix,Ny+1-iy,iz,2) = 0;
                    E(Nx-1+ix,Ny-1+iy,iz,2) = 0;
                end%if
            end
        end
    end%for
    printf('\n evaluate electric field: %d min \n', toc/60);
end
