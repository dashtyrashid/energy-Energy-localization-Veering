function [PSI1, PSI2, x1, x2] = ModeShape(omega, xi, p, kt, kr, m1, m2, j1, j2)
% ModeShape: Computes the normalized mode shape of a two-segment beam model
% with an internal constraint at location xi, using symbolic solutions.
%
% Inputs:
%   omega - nondimensional natural frequency
%   xi    - normalized interface location (xi = lc / l)
%   p     - nondimensional axial preload
%   kt    - nondimensional translational stiffness
%   kr    - nondimensional rotational stiffness
%   m1    - dimensionless point mass at clamped end
%   m2    - dimensionless point mass at internal interface
%   j1    - dimensionless rotary inertia at clamped end
%   j2    - dimensionless rotary inertia at internal interface
%
% Outputs:
%   PSI1 - mode shape on segment [0, xi]
%   PSI2 - mode shape on segment [xi, 1]
%   x1   - corresponding x positions for PSI1
%   x2   - corresponding x positions for PSI2

    syms a1 a2 a3 a4 b1 b2 b3 b4 x1 x2

    % Define wavenumbers
    gamma = sqrt(sqrt((p / 2)^2 + omega^2) + p / 2);
    lambda = sqrt(sqrt((p / 2)^2 + omega^2) - p / 2);
    beta = sqrt(omega);

    % General solutions in each segment
    GS1 = a1*cos(lambda*x1) + a2*sin(lambda*x1) + a3*cosh(gamma*x1) + a4*sinh(gamma*x1);
    GS2 = b1*cos(beta*x2) + b2*sin(beta*x2) + b3*cosh(beta*x2) + b4*sinh(beta*x2);

    % Derivatives of segment 1
    Y = GS1; Y1 = diff(Y); Y2 = diff(Y1); Y3 = diff(Y2);
    
    % Derivatives of segment 2
    D = GS2; D1 = diff(D); D2 = diff(D1); D3 = diff(D2);

    % Evaluate segment 1 at x = 0
    Y0  = subs(Y, x1, 0);
    Y10 = subs(Y1, x1, 0);
    Y20 = subs(Y2, x1, 0);
    Y30 = subs(Y3, x1, 0);

    % Evaluate segment 1 at x = xi
    Y   = subs(Y, x1, xi);
    Y1  = subs(Y1, x1, xi);
    Y2  = subs(Y2, x1, xi);
    Y3  = subs(Y3, x1, xi);

    % Evaluate segment 2 at x = xi
    D0  = subs(D, x2, xi);
    D10 = subs(D1, x2, xi);
    D20 = subs(D2, x2, xi);
    D30 = subs(D3, x2, xi);

    % Evaluate segment 2 at x = 1
    D   = subs(D, x2, 1);
    D1  = subs(D1, x2, 1);
    D2  = subs(D2, x2, 1);
    D3  = subs(D3, x2, 1);

    % Boundary and interface conditions (eccentricity terms removed)
    BC1 = Y20 == kr*Y10 - j1*omega^2*Y10;
    BC2 = Y30 == p*Y10 - kt*Y0 + m1*omega^2*Y0;
    BC3 = Y == D0;
    BC4 = Y1 == D10;
    BC5 = D20 == Y2 + kr*Y1 - j2*omega^2*Y1;
    BC6 = D30 == Y3 - p*Y1 - kt*Y + m2*omega^2*Y;
    BC7 = D2 == 0;
    BC8 = D3 == 0;

    % Solve homogeneous linear system A*c = 0
    BCs = [BC1; BC2; BC3; BC4; BC5; BC6; BC7; BC8];
    vars = [a1, a2, a3, a4, b1, b2, b3, b4];
    [Amat, ~] = equationsToMatrix(BCs, vars);

    % Null space solution via SVD
    [~, ~, V] = svd(double(Amat));
    null_space = V(:, end);
    Cs = null_space / norm(null_space);

    % Extract constants
    A1 = Cs(1); A2 = Cs(2); A3 = Cs(3); A4 = Cs(4);
    B1 = Cs(5); B2 = Cs(6); B3 = Cs(7); B4 = Cs(8);

    % Construct mode shapes numerically
    x1 = linspace(0, xi, 1000);
    x2 = linspace(xi, 1, 1000);

    PSI1 = A1 * cos(lambda * x1) + A2 * sin(lambda * x1) + A3 * cosh(gamma * x1) + A4 * sinh(gamma * x1);
    PSI2 = B1 * cos(beta * x2) + B2 * sin(beta * x2) + B3 * cosh(beta * x2) + B4 * sinh(beta * x2);

    % Normalize entire mode shape
    max_val = max([max(abs(PSI1)), max(abs(PSI2))]);
    PSI1 = PSI1 / max_val;
    PSI2 = PSI2 / max_val;
end
