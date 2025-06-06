function [w1, w2, w3, w4, n] = BoltModel(xi, p, kt, kr, m1, m2, j1, j2)
% BoltModel: Computes the first four natural frequencies of a segmented beam
% model representing a bolted structure with an internal constraint, without eccentricities.
%
% Inputs:
%   xi   - normalized interface location (xi = lc / l)
%   p    - nondimensional axial preload
%   kt   - nondimensional translational stiffness
%   kr   - nondimensional rotational stiffness
%   m1   - dimensionless mass at the base
%   m2   - dimensionless mass at the interface
%   j1   - dimensionless rotary inertia at the base
%   j2   - dimensionless rotary inertia at the interface
%
% Outputs:
%   w1, w2, w3, w4 - first four natural frequencies (nondimensional)
%   n             - all computed natural frequencies

    % Define symbolic variables
    syms a1 a2 a3 a4 b1 b2 b3 b4 x1 x2 omega alpha1 alpha2 beta1
    assume(omega, 'real');

    % General solutions for two beam segments
    GS1 = a1*cos(alpha1*x1) + a2*sin(alpha1*x1) + a3*cosh(alpha2*x1) + a4*sinh(alpha2*x1);
    GS2 = b1*cos(beta1*x2)  + b2*sin(beta1*x2)  + b3*cosh(beta1*x2) + b4*sinh(beta1*x2);

    % Derivatives for segment 1
    Y   = GS1;
    Y1  = diff(Y, x1);
    Y2  = diff(Y1, x1);
    Y3  = diff(Y2, x1);

    % Derivatives for segment 2
    D   = GS2;
    D1  = diff(D, x2);
    D2  = diff(D1, x2);
    D3  = diff(D2, x2);

    % Evaluate derivatives at x = 0 (base)
    Y0  = subs(Y, x1, 0);
    Y10 = subs(Y1, x1, 0);
    Y20 = subs(Y2, x1, 0);
    Y30 = subs(Y3, x1, 0);

    % Evaluate derivatives at x = xi (interface)
    Y   = subs(Y, x1, xi);
    Y1  = subs(Y1, x1, xi);
    Y2  = subs(Y2, x1, xi);
    Y3  = subs(Y3, x1, xi);

    D0  = subs(D, x2, xi);
    D10 = subs(D1, x2, xi);
    D20 = subs(D2, x2, xi);
    D30 = subs(D3, x2, xi);

    % Evaluate derivatives at x = 1 (free end)
    D   = subs(D, x2, 1);
    D1  = subs(D1, x2, 1);
    D2  = subs(D2, x2, 1);
    D3  = subs(D3, x2, 1);

    % Boundary and interface conditions 
    BC1 = Y20 == kr*Y10 - j1*omega^2*Y10;
    BC2 = Y30 == p*Y10 - kt*Y0 + m1*omega^2*Y0;
    BC3 = Y == D0;
    BC4 = Y1 == D10;
    BC5 = D20 == Y2 + kr*Y1 - j2*omega^2*Y1;
    BC6 = D30 == Y3 - p*Y1 - kt*Y + m2*omega^2*Y;
    BC7 = D2 == 0;
    BC8 = D3 == 0;

    % Convert to matrix system A*c = 0
    eqns = [BC1; BC2; BC3; BC4; BC5; BC6; BC7; BC8];
    vars = [a1, a2, a3, a4, b1, b2, b3, b4];
    Amat = equationsToMatrix(eqns, vars);

    % Define wave numbers
    alpha1_sym = sqrt(sqrt((p/2)^2 + omega^2) - p/2);
    alpha2_sym = sqrt(sqrt((p/2)^2 + omega^2) + p/2);
    beta1_sym  = sqrt(omega);

    % Substitute symbolic expressions
    Amat_numeric = subs(Amat, ...
        [alpha1, alpha2, beta1, p, xi, kt, kr], ...
        [alpha1_sym, alpha2_sym, beta1_sym, p, xi, kt, kr]);

    % Compute symbolic determinant
    detA = simplify(det(Amat_numeric));
    
    % Convert to function handles
    f_omega       = matlabFunction(detA, 'Vars', omega);
    f_omega_prime = matlabFunction(diff(detA, omega), 'Vars', omega);

    % Root finding (Newton-Raphson)
    tol = 1e-6; max_iter = 100;
    n = []; % Store roots

    for guess = 1:1:300
        omega_guess = guess;
        for iter = 1:max_iter
            f_val = f_omega(omega_guess);
            f_prime_val = f_omega_prime(omega_guess);
            if abs(f_prime_val) < eps
                break;
            end
            omega_next = omega_guess - f_val / f_prime_val;
            if abs(omega_next - omega_guess) < tol
                n = [n; omega_next]; break;
            end
            omega_guess = omega_next;
        end
    end

    % Post-processing: clean and select roots
    n = n(imag(n) == 0 & real(n) > 0);      % Real, positive roots
    n = uniquetol(sort(real(n)), 1e-4);      % Remove duplicates
    n(n < 1) = [];                           % Optional filter

    % Return first four natural frequencies
    if length(n) >= 4
        w1 = n(1); w2 = n(2); w3 = n(3); w4 = n(4);
    else
        w1 = NaN; w2 = NaN; w3 = NaN; w4 = NaN;
    end
end
