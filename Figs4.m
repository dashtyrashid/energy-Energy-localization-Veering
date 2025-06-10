%% Figure 4 - Frequencies and Energy Localization
clear; close all; clc;

% Load data (adjust file path if needed)
load('filepath\data_Fig4.mat');
%%
% Define consistent color palette
color1 = [191, 115, 143] / 255;  % Mode 1: #BF738F
color2 = [68, 120, 166]  / 255;  % Mode 2: #4478A6
color3 = [66, 140, 71]   / 255;  % Mode 3: #428C47
color4 = [191, 186, 111] / 255;  % Mode 4: #BFBA6F

%% ------------------ Figure 4(a): Modes 1 & 2 ------------------

figure('Units', 'inches', 'Position', [1, 1, 8, 5]);

% Left axis: Frequencies
yyaxis left
hold on;
h1 = plot(xi_values, omega_store(:,1), '-', 'Color', color1, 'LineWidth', 3);
h2 = plot(xi_values, omega_store(:,2), '-', 'Color', color2, 'LineWidth', 3);
ylabel('$\omega_n$', 'Interpreter', 'latex', 'FontSize', 24);
xlabel('$\xi$',      'Interpreter', 'latex', 'FontSize', 24);
set(gca, 'XColor', 'k', 'YColor', 'k');

% Right axis: Localization
yyaxis right
h3 = plot(xi_values, energy_localization(:,1), 'o-', 'Color', color1, ...
    'LineWidth', 1.5, 'MarkerFaceColor', color1, 'MarkerEdgeColor', 'k', 'MarkerSize', 8);
h4 = plot(xi_values, energy_localization(:,2), 'o-', 'Color', color2, ...
    'LineWidth', 1.5, 'MarkerFaceColor', color2, 'MarkerEdgeColor', 'k', 'MarkerSize', 8);
ylabel('$\Lambda_n$', 'Interpreter', 'latex', 'FontSize', 24);

% Axes formatting
xlim([0.69, 0.74]);
ax = gca;
ax.FontSize = 16;
ax.LineWidth = 1.5;
ax.TickLabelInterpreter = 'latex';
box on;

% Legends
ax1 = axes('Position', ax.Position, 'Color', 'none', 'XTick', [], 'YTick', [], 'HitTest', 'off');
legend(ax1, [h1 h2], {'$\omega_1^{(\mathcal{M}_{LC})}$', '$\omega_2^{(\mathcal{M}_{LC})}$'}, ...
    'Interpreter', 'latex', 'FontSize', 20, 'Location', 'east', 'Box', 'off');

ax2 = axes('Position', ax.Position, 'Color', 'none', 'XTick', [], 'YTick', [], 'HitTest', 'off');
legend(ax2, [h3 h4], {'$\Lambda_1$', '$\Lambda_2$'}, ...
    'Interpreter', 'latex', 'FontSize', 20, 'Location', 'west', 'Box', 'off');

%% ------------------ Figure 4(b): Modes 2 & 3 ------------------

figure('Units', 'inches', 'Position', [1, 1, 8, 5]);

% Left axis: Frequencies
yyaxis left
hold on;
h1 = plot(xi_values, omega_store(:,2), '-', 'Color', color2, 'LineWidth', 3);
h2 = plot(xi_values, omega_store(:,3), '-', 'Color', color3, 'LineWidth', 3);
ylabel('$\omega_n$', 'Interpreter', 'latex', 'FontSize', 24);
xlabel('$\xi$',      'Interpreter', 'latex', 'FontSize', 24);
ylim([65, 100]);
set(gca, 'XColor', 'k', 'YColor', 'k');

% Right axis: Localization
yyaxis right
h3 = plot(xi_values, energy_localization(:,2), 'o-', 'Color', color2, ...
    'LineWidth', 1.5, 'MarkerFaceColor', color2, 'MarkerEdgeColor', 'k', 'MarkerSize', 8);
h4 = plot(xi_values, energy_localization(:,3), 'o-', 'Color', color3, ...
    'LineWidth', 1.5, 'MarkerFaceColor', color3, 'MarkerEdgeColor', 'k', 'MarkerSize', 8);
ylabel('$\Lambda_n$', 'Interpreter', 'latex', 'FontSize', 24);

% Axes formatting
xlim([0.77, 0.85]);
ax = gca;
ax.FontSize = 16;
ax.LineWidth = 1.5;
ax.TickLabelInterpreter = 'latex';
box on;

% Legends
ax1 = axes('Position', ax.Position, 'Color', 'none', 'XTick', [], 'YTick', [], 'HitTest', 'off');
legend(ax1, [h1 h2], {'$\omega_2^{(\mathcal{M}_{LC})}$', '$\omega_3^{(\mathcal{M}_{LC})}$'}, ...
    'Interpreter', 'latex', 'FontSize', 20, 'Location', 'east', 'Box', 'off');

ax2 = axes('Position', ax.Position, 'Color', 'none', 'XTick', [], 'YTick', [], 'HitTest', 'off');
legend(ax2, [h3 h4], {'$\Lambda_2$', '$\Lambda_3$'}, ...
    'Interpreter', 'latex', 'FontSize', 20, 'Location', 'west', 'Box', 'off');

%% ------------------ Figure 4(c): Modes 3 & 4 ------------------

figure('Units', 'inches', 'Position', [1, 1, 8, 5]);

% Left axis: Frequencies
yyaxis left
hold on;
h1 = plot(xi_values, omega_store(:,3), '-', 'Color', color3, 'LineWidth', 3);
h2 = plot(xi_values, omega_store(:,4), '-', 'Color', color4, 'LineWidth', 3);
ylabel('$\omega_n$', 'Interpreter', 'latex', 'FontSize', 24);
xlabel('$\xi$',      'Interpreter', 'latex', 'FontSize', 24);
ylim([100, 160]);
set(gca, 'XColor', 'k', 'YColor', 'k');

% Right axis: Localization
yyaxis right
h3 = plot(xi_values, energy_localization(:,3), 'o-', 'Color', color3, ...
    'LineWidth', 1.5, 'MarkerFaceColor', color3, 'MarkerEdgeColor', 'k', 'MarkerSize', 8);
h4 = plot(xi_values, energy_localization(:,4), 'o-', 'Color', color4, ...
    'LineWidth', 1.5, 'MarkerFaceColor', color4, 'MarkerEdgeColor', 'k', 'MarkerSize', 8);
ylabel('$\Lambda_n$', 'Interpreter', 'latex', 'FontSize', 24);

% Axes formatting
xlim([0.82, 0.92]);
ax = gca;
ax.FontSize = 16;
ax.LineWidth = 1.5;
ax.TickLabelInterpreter = 'latex';
box on;

% Legends
ax1 = axes('Position', ax.Position, 'Color', 'none', 'XTick', [], 'YTick', [], 'HitTest', 'off');
legend(ax1, [h1 h2], {'$\omega_3^{(\mathcal{M}_{LC})}$', '$\omega_4^{(\mathcal{M}_{LC})}$'}, ...
    'Interpreter', 'latex', 'FontSize', 20, 'Location', 'east', 'Box', 'off');

ax2 = axes('Position', ax.Position, 'Color', 'none', 'XTick', [], 'YTick', [], 'HitTest', 'off');
legend(ax2, [h3 h4], {'$\Lambda_3$', '$\Lambda_4$'}, ...
    'Interpreter', 'latex', 'FontSize', 20, 'Location', 'west', 'Box', 'off');
