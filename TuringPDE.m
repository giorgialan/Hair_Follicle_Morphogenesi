function [space_x, concentration_u, concentration_v] = TuringPDE(total_time, show_plots)
    fprintf('Running Turing model for %1.1f time units\n', total_time);

    k = 2; 
    mu1 = 0.04;
    mu2 = 0.01; 
    lambda = 0.08;  
    rho1 = 3.37; 
    rho2 = 2; 
    nc = 6; 
    Dx = 1; 
    Dy = 0.04;

    initial_u = 2.3069;
    initial_v = 2;

    dx = 0.1; 
    L = 12; 
    dt = 0.05 * dx^2 / Dx; 
    noise_level = 0.01; 
    space_x = 0:dx:L; 
    num_points = length(space_x); 

    % Matrici delle concentrazioni iniziali con rumore
    concentration_u = initial_u * ones(num_points) + noise_level * rand(num_points, num_points);
    concentration_v = initial_v * ones(num_points) + noise_level * rand(num_points, num_points);

    current_time = 0; % Tempo iniziale
    iteration = 0; % Numero di iterazioni

    if show_plots
        % Inizializzazione della figura per la visualizzazione
        figure_handle = figure;
        figure_handle.Position = [200 300 1000 400];
    end

    while current_time < total_time
        % Calcolo delle derivate spaziali
        laplacian_u = 4 * del2(concentration_u, dx);
        laplacian_v = 4 * del2(concentration_v, dx);

        % Aggiornamento delle concentrazioni 
        delta_u = dt * (-k * concentration_u .* concentration_v - 2 * mu2 * concentration_u.^2 + lambda + rho1 * rho2 * nc * concentration_v ./ (rho2 + rho1 * concentration_v) + Dx * laplacian_u);
        delta_v = dt * (k * concentration_u .* concentration_v + 2 * mu2 * concentration_u.^2 - mu1 * concentration_v - rho1 * rho2 * nc * concentration_v ./ (rho2 + rho1 * concentration_v) + Dy * laplacian_v);

        % Aggiornamento delle matrici delle concentrazioni
        concentration_u = concentration_u + delta_u;
        concentration_v = concentration_v + delta_v;

        % Condizioni al contorno periodiche
        concentration_u(1, :) = concentration_u(2, :); 
        concentration_u(num_points, :) = concentration_u(num_points - 1, :); 
        concentration_u(:, 1) = concentration_u(:, 2); 
        concentration_u(:, num_points) = concentration_u(:, num_points - 1);

        concentration_v(1, :) = concentration_v(2, :); 
        concentration_v(num_points, :) = concentration_v(num_points - 1, :); 
        concentration_v(:, 1) = concentration_v(:, 2); 
        concentration_v(:, num_points) = concentration_v(:, num_points - 1);

        current_time = current_time + dt;
        iteration = iteration + 1;

        if show_plots
            if mod(iteration, 1000) == 0
                % Visualizzazione delle concentrazioni
                subplot(1, 2, 1);
                surf(space_x, space_x, concentration_u);
                set(gca, 'layer', 'top', 'tickdir', 'out');
                shading flat;
                grid off;
                view([0 90]);
                colorbar;
                title(sprintf('t = %1.3f', current_time));
                drawnow;
            end
        else
            if mod(iteration, 1000) == 0
                fprintf('.'); 
            end
        end
    end
end