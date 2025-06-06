clc; clear; close all;

%% -------------------- PHYSICAL PARAMETERS --------------------
E = 200e9;      % Young's modulus (Pa)
I = 1e-1;       % Moment of inertia (m^4)
A = 1e-1;       % Cross-sectional area (m^2)
rho = 7850;     % Density (kg/m^3)
kt = 1e6;       % Translational stiffness (N/m)
kr = 1e6;       % Rotational stiffness (Nm/rad)

%% -------------------- MODEL: MLC (Locally Constrained) --------------------
xi_vals = linspace(0, 1, 200);
L_fixed = 0.1;  % Fixed total bolt length (m)
freqs_MLC = zeros(4, length(xi_vals));

for i = 1:length(xi_vals)
    xi = xi_vals(i);
    [w1, w2, w3, w4, ~] = BoltModel(xi, 0, kt, kr, 0, 0, 0, 0);
    [f1, f2, f3, f4] = dimensionalize(w1, w2, w3, w4, E, I, L_fixed, rho, A);
    freqs_MLC(:, i) = [f1; f2; f3; f4];
end

%% -------------------- MODEL: MER (Elastically Restrained) --------------------
L_vals_desc = linspace(0.01, 0.1, 200);  % Avoid L=0 to prevent singularities
xi_fixed = 1;  % All length is embedded
freqs_MER = zeros(4, length(L_vals_desc));

for i = 1:length(L_vals_desc)
    L = L_vals_desc(i);
    [w1, w2, w3, w4, ~] = BoltModel(xi_fixed, 0, kt, kr, 0, 0, 0, 0);
    [f1, f2, f3, f4] = dimensionalize(w1, w2, w3, w4, E, I, L, rho, A);
    freqs_MER(:, i) = [f1; f2; f3; f4];
end

%% -------------------- MODEL: MC (Cantilever) --------------------
L_vals_inc = linspace(0.01, 0.1, 200);
xi_fixed = 0;  % All length is protruding
freqs_MC = zeros(4, length(L_vals_inc));

for i = 1:length(L_vals_inc)
    L = L_vals_inc(i);
    [w1, w2, w3, w4, ~] = BoltModel(xi_fixed, 0, kt, kr, 0, 0, 0, 0);
    [f1, f2, f3, f4] = dimensionalize(w1, w2, w3, w4, E, I, L, rho, A);
    freqs_MC(:, i) = [f1; f2; f3; f4];
end

%% -------------------- Example Mode Shape --------------------

% Define constants
E = 200e9;   % Young's modulus (Pa)
I = 1e-1;    % Second moment of area (m^4)
A = 1e-1;    % Cross-sectional area (m^2)
rho = 7850;  % Density (kg/m^3)
kt = 1000000;    % Translational stiffness
kr = 1000000;    % Rotational stiffness


xi = 0;   % xi should be fixed depending on which model is used
L = 0.12; % Length should be fixed depending on which model is used

[w1, w2, w3, w4, ~] = BoltModel(xi, 0, kt, kr, 0, 0, 0, 0);
[omega1, omega2, omega3, omega4] = dimensionalize(w1, w2, w3, w4, 0, E, I, L, rho, A);
[PHI1, PHI2, x1, x2] = ModeShape(w1, xi, 0, kt, kr, 0, 0, 0, 0);

%% -------------------- Example Lambda --------------------

% --- Compute energy and (Λₙ) ---
[total_energy, energy_ratio] = ComputeModeEnergy(xi, 0, kt, kr, 0, 0, 0, 0, 0, 0, w1);




