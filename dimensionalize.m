function [f1, f2, f3, f4] = dimensionalize(w1, w2, w3, w4, E, I, L, rho, A)
%DIMENSIONALIZE Convert nondimensional natural frequencies to dimensional form.
%
%   [f1, f2, f3, f4] = dimensionalize(w1, w2, w3, w4, E, I, L, rho, A)
%
%   Converts nondimensional natural frequencies (wn) to dimensional
%   frequencies (Hz) using beam theory scaling.
%
%   Inputs:
%       w1, w2, w3, w4 - nondimensional natural frequencies
%       E    - Young's modulus of the material [Pa]
%       I    - Second moment of area [m^4]
%       L    - Total length of the beam (or bolt) [m]
%       rho  - Density of the material [kg/m^3]
%       A    - Cross-sectional area [m^2]
%
%   Outputs:
%       f1, f2, f3, f4 - dimensional natural frequencies in Hz

    % Precompute constant coefficient for scaling
    scaleFactor = 1/(2*pi) * sqrt((E * I) / (rho * A * L^4));

    % Apply scaling to each mode
    f1 = w1 * scaleFactor;
    f2 = w2 * scaleFactor;
    f3 = w3 * scaleFactor;
    f4 = w4 * scaleFactor;
end
