%% ===== Figure 5: Normalized Frequency Surface with Energy Ratio Coloring =====
clear; close all; clc;


% Load data (adjust file path if needed)
load('filepath\data_Fig5.mat');

% ==== Data Setup ====
MODE_IDX = 4;  % Mode to visualize

% Create meshgrid for xi and kt
[XI, KT] = meshgrid(xi_values, kt_values);  % xi in [0,1], kt in log scale

% Extract frequency and localization data for selected mode
freq_mode = squeeze(frequencies(MODE_IDX, :, :))';  % size: [kt, xi]
lambda = mode_energy_ratios(:, :, MODE_IDX)';       % size: [kt, xi]

% Normalize frequency surface
freq_norm = freq_mode / max(freq_mode(:));  % Rescale to [0,1]

% ==== Plot Setup ====
figure('Units', 'inches', 'Position', [1, 1, 8, 5]);
hold on;

% Set custom colormap
colormap(slanCM('coolwarm'));  % Requires slanCM function on path

% ==== Surface Plot ====
s = surf(XI, KT, freq_norm, lambda, ...
    'EdgeColor', 'none', ...
    'FaceColor', 'interp');

% ==== Axes Formatting ====
ax = gca;
ax.YScale = 'log';  % Log scale for kt axis
ax.FontSize = 16;
ax.LineWidth = 1.2;
ax.TickLabelInterpreter = 'latex';
set(gca, 'XColor', 'k', 'YColor', 'k');
box on;

xlabel('$\xi$', 'Interpreter', 'latex', 'FontSize', 24);
ylabel('$k_t$', 'Interpreter', 'latex', 'FontSize', 24);
zlabel(['$\omega_', num2str(MODE_IDX), '/\omega_{\max}$'], ...
    'Interpreter', 'latex', 'FontSize', 24);

zlim([0, 1.1]);
grid off;
view(-10, 30);  % Set 3D viewing angle

% ==== Colorbar Formatting ====
c = colorbar('Location', 'eastoutside');
c.Label.String = ['$\Lambda_', num2str(MODE_IDX), '$'];
c.Label.Interpreter = 'latex';
c.Label.FontSize = 24;
c.Label.Rotation = 0;
c.TickLabelInterpreter = 'latex';
c.FontSize = 16;
caxis([0, 1]);
c.Ticks = [0, 1];

shading interp;
