function [energy, energy_localization] = ComputeModeEnergy(xi, p, kt, kr, m1, m2, j1, j2, omega)
% ComputeModeEnergy: Calculates total vibrational energy and localization index Λ_n(ξ)
% for a locally constrained beam with a given natural frequency and interface position.
%
% Inputs:
%   xi     - normalized interface location (xi = lc / l)
%   p      - nondimensional axial preload
%   kt     - nondimensional translational stiffness
%   kr     - nondimensional rotational stiffness
%   m1     - dimensionless mass at clamped base
%   m2     - dimensionless mass at internal constraint
%   j1     - dimensionless rotary inertia at clamped base
%   j2     - dimensionless rotary inertia at internal constraint
%   omega  - nondimensional natural frequency (single mode)
%
% Outputs:
%   energy               - total vibrational energy (kinetic + potential)
%   energy_localization  - Λ_n(ξ): energy fraction localized in the protruding segment [ξ, 1]

    syms x1 x2
    assume([x1 x2], 'real');

    % Define wave numbers
    alpha1 = double(sqrt(sqrt((p/2)^2 + omega^2) - p/2));
    alpha2 = double(sqrt(sqrt((p/2)^2 + omega^2) + p/2));
    beta1  = double(sqrt(omega));

    % Define general mode shape expressions
    syms a1 a2 a3 a4 b1 b2 b3 b4
    GS1 = a1*cos(alpha1*x1) + a2*sin(alpha1*x1) + a3*cosh(alpha2*x1) + a4*sinh(alpha2*x1);
    GS2 = b1*cos(beta1*x2)  + b2*sin(beta1*x2)  + b3*cosh(beta1*x2)  + b4*sinh(beta1*x2);

    % Compute derivatives
    Y1 = diff(GS1, x1); Y2 = diff(Y1, x1); Y3 = diff(Y2, x1);
    D1 = diff(GS2, x2); D2 = diff(D1, x2); D3 = diff(D2, x2);

    % Apply boundary/interface conditions (no eccentricity terms)
    BCs = [
        subs(Y2, x1, 0) == kr * subs(Y1, x1, 0) - j1 * omega^2 * subs(Y1, x1, 0);
        subs(Y3, x1, 0) == p  * subs(Y1, x1, 0) - kt * subs(GS1, x1, 0) + m1 * omega^2 * subs(GS1, x1, 0);
        subs(GS1, x1, xi) == subs(GS2, x2, xi);
        subs(Y1, x1, xi) == subs(D1, x2, xi);
        subs(D2, x2, xi) == subs(Y2, x1, xi) + kr * subs(Y1, x1, xi) - j2 * omega^2 * subs(Y1, x1, xi);
        subs(D3, x2, xi) == subs(Y3, x1, xi) - p * subs(Y1, x1, xi) - kt * subs(GS1, x1, xi) + m2 * omega^2 * subs(GS1, x1, xi);
        subs(D2, x2, 1) == 0;
        subs(D3, x2, 1) == 0;
    ];

    vars = [a1, a2, a3, a4, b1, b2, b3, b4];
    [A, ~] = equationsToMatrix(BCs, vars);
    A_numeric = double(A);

    % Solve for mode shape coefficients (null space of A)
    [~, ~, V] = svd(A_numeric);
    coeffs = V(:, end) / norm(V(:, end));

    % Substitute into symbolic mode shapes
    Y_mode = subs(GS1, vars(1:4), coeffs(1:4).');
    D_mode = subs(GS2, vars(5:8), coeffs(5:8).');

    % Compute strain energy (bending) in both segments
    PE1 = vpaintegral(diff(Y_mode, x1, 2)^2, x1, 0, xi);
    PE2 = vpaintegral(diff(D_mode, x2, 2)^2, x2, xi, 1);

    % Compute kinetic energy in both segments
    KE1 = omega^2 * vpaintegral(Y_mode^2, x1, 0, xi);
    KE2 = omega^2 * vpaintegral(D_mode^2, x2, xi, 1);

    % Point mass and inertia energy contributions
    PE_pt = 0.5 * kt * double(subs(GS1, x1, 0))^2 + ...
            0.5 * kr * double(subs(diff(GS1, x1), x1, 0))^2 + ...
            0.5 * kt * double(subs(GS1, x1, xi))^2 + ...
            0.5 * kr * double(subs(diff(GS1, x1), x1, xi))^2;

    KE_pt = 0.5 * m1 * omega^2 * double(subs(GS1, x1, 0))^2 + ...
            0.5 * m2 * omega^2 * double(subs(GS1, x1, xi))^2 + ...
            0.5 * j1 * omega^2 * double(subs(diff(GS1, x1), x1, 0))^2 + ...
            0.5 * j2 * omega^2 * double(subs(diff(GS1, x1), x1, xi))^2;

    % Total energy
    PE_total = double(0.5 * (PE1 + PE2)) + PE_pt;
    KE_total = double(0.5 * (KE1 + KE2)) + KE_pt;
    energy = PE_total + KE_total;

    % Compute energy localized in protruding segment [xi, 1]
    PE_local = double(0.5 * PE2);
    KE_local = double(0.5 * KE2);
    energy_localization = (PE_local + KE_local) / energy;
end
