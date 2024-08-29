function result = Bifurcation_Turing(k, mu2, lambda, mu1, rho1, rho2, nc, Dx, Dy, qspace)

    X_fixed = max([
        (-k*lambda^2*rho1 - k*lambda*mu1*rho2 + sqrt(lambda) * sqrt(lambda*rho1 + mu1*rho2) * sqrt(k^2*lambda^2*rho1 + ...
         8*mu2*lambda*mu1^2*rho1 + k^2*lambda*mu1*rho2 + 8*mu2*mu1^3*rho2 + 8*mu2*mu1^2*rho1*rho2*nc)) / (4 * (mu2 * ...
         lambda*mu1*rho1 + mu2*mu1^2*rho2)),
        (-k*lambda^2*rho1 - k*lambda*mu1*rho2 - sqrt(lambda) * sqrt(lambda*rho1 + mu1*rho2) * sqrt(k^2*lambda^2*rho1 + ...
         8*mu2*lambda*mu1^2*rho1 + k^2*lambda*mu1*rho2 + 8*mu2*mu1^3*rho2 + 8*mu2*mu1^2*rho1*rho2*nc)) / (4 * (mu2 * ...
         lambda*mu1*rho1 + mu2*mu1^2*rho2))
    ]);

    Y_fixed = lambda / mu1;

    Jacobian = [
        -k*Y_fixed - 4*mu2*X_fixed, -k*X_fixed - rho1^2*rho2*nc*Y_fixed / (rho2 + rho1*Y_fixed)^2 + rho1*rho2*nc / (rho2 + rho1*Y_fixed);
        k*Y_fixed + 4*mu2*X_fixed, k*X_fixed - mu1 + rho1^2*rho2*nc*Y_fixed / (rho2 + rho1*Y_fixed)^2 - rho1*rho2*nc / (rho2 + rho1*Y_fixed)
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