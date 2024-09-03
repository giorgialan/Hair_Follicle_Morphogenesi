function result = Bifurcation_Turing(k, lambda, mu, rho1, rho2, ks, Dx, Dy, qspace)

    % Punto fisso per la variabile u
    u_lambda = (1 / k) * ( (rho2 / lambda) * (rho2 * mu^2 / rho1) - 1 );

    % Punto fisso per la variabile v
    v_lambda = (rho2 * mu) / (rho1 * lambda * u_lambda);

    % Calcolo della matrice Jacobiana
    J11 = (2 * rho1 * u_lambda * v_lambda) / (1 + k * u_lambda^2)^2 - mu;
    J12 = (rho1 * u_lambda^2 / (1 + k * u_lambda^2));

    J21 = (2 * rho2 * u_lambda * v_lambda) / (1 + k * u_lambda^2)^2;

    J22 = (rho2 * u_lambda^2 / (1 + k*u_lambda^2) - lambda);

    Jacobian = [
        J11, J12;
        J21, J22
    ];

    Diffusion = [
        Dx, 0;
        0, Dy
    ];

    DispersionRelation = arrayfun(@(q) max(real(eig(Jacobian - q^2 * Diffusion))), qspace);

    % Analisi della stabilità del sistema
    StableWithoutDiffusion = (max(real(eig(Jacobian))) < 0);
    NoiseAmplifying = false;
    PositiveForSomeK = (max(DispersionRelation) > 0);

    if StableWithoutDiffusion && (~NoiseAmplifying) && PositiveForSomeK
        result = 0; % Modello che mostra pattern
    elseif StableWithoutDiffusion && (~NoiseAmplifying) && (~PositiveForSomeK)
        result = 1; % Sempre stabile
    elseif StableWithoutDiffusion && NoiseAmplifying
        result = 2; % Amplificazione del rumore
    elseif ~StableWithoutDiffusion
        result = 3; % Instabile
    end
end
