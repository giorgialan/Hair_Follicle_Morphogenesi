function result = Bifurcation_Turing(k, lambda, mu, rho1, rho2, ks, Dx, Dy, qspace)

    % Punto fisso per la variabile u
    u_lambda = sqrt((1 / k) * ( (rho2 / lambda) * (rho2 * mu^2 / rho1) - 1 ));

    % Punto fisso per la variabile v
    v_lambda = (rho2 * mu) / (rho1 * lambda * u_lambda);

    % Calcolo della matrice Jacobiana
    J11 = ( (-rho1^2 * lambda + 2 * rho2 * mu^2) * mu ) / (rho1^2 * lambda );
    J12 = -rho1 * lambda / rho2;
    J21 = 2 * rho2^2 * mu^3 / (rho1^3 * lambda);
    J22 = -2 * lambda;

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
