%% Initialize Workspace
clear; close all; clc;

%% Load Data
load('filepath\data_Fig2&3_HS.mat');

%% Define Colors
colors = struct( ...
    'LC',  [191, 115, 143] / 255, ... % #BF738F
    'ER',  [68, 120, 166]  / 255, ... % #4478A6
    'C',   [66, 140, 71]   / 255, ... % #428C47
    'Alt', [191, 186, 111] / 255, ... % #BFBA6F
    'Desc', [112, 94, 178] / 255, ... % #705EB2
    'Inc', [255, 153, 102] / 255 ...  % #FF9966
);

%% Plot Settings Function
set_plot_formatting = @(ax) set(ax, ...
    'FontSize', 16, ...
    'FontName', 'Arial', ...
    'LineWidth', 2, ...
    'TickLabelInterpreter', 'latex', ...
    'TickLength', [0 0], ...
    'TickDir', 'out', ...
    'XColor', [0 0 0], ...
    'YColor', [0 0 0]);

%% ----------- Figure 2(d): Frequencies vs. \xi ----------------
figure('Units', 'inches', 'Position', [1, 1, 8, 5]); hold on;

plot(xi_values, frequencies_xi(1,:)', 'Color', colors.LC,  'LineWidth', 3);
plot(xi_values, frequencies_xi(2,:)', 'Color', colors.ER,  'LineWidth', 3);
plot(xi_values, frequencies_xi(3,:)', 'Color', colors.C,   'LineWidth', 3);
plot(xi_values, frequencies_xi(4,:)', 'Color', colors.Alt, 'LineWidth', 3);

set_plot_formatting(gca);
xlabel('$\xi$', 'Interpreter', 'latex', 'FontSize', 24);
ylabel('$\Omega_n$ [Hz]', 'Interpreter', 'latex', 'FontSize', 24);

legend({ ...
    '$\Omega_1^{(\mathcal{M}_{LC})}(\xi)$', ...
    '$\Omega_2^{(\mathcal{M}_{LC})}(\xi)$', ...
    '$\Omega_3^{(\mathcal{M}_{LC})}(\xi)$', ...
    '$\Omega_4^{(\mathcal{M}_{LC})}(\xi)$' ...
}, 'Interpreter', 'latex', 'FontSize', 20, 'Location', 'South', 'Box', 'off', 'NumColumns', 2);

xlim([0.025, 1]); ylim([-62000, 2e5]);

%% ----------- Figure 2(e): Descending Frequencies vs. \xi ----------------
figure('Units', 'inches', 'Position', [1, 1, 8, 5]); hold on;

for i = 1:4
    plot(L_values(1:2:end), frequencies_L_desc(i,1:2:end), 'o', ...
        'LineWidth', 1, 'MarkerFaceColor', colors.(getfieldnames(colors){i}), ...
        'MarkerEdgeColor', 'k', 'MarkerSize', 8);
end

set_plot_formatting(gca);
xlabel('$\xi$', 'Interpreter', 'latex', 'FontSize', 24);
ylabel('$\Omega_n$ [Hz]', 'Interpreter', 'latex', 'FontSize', 24);

legend({ ...
    '$\Omega_1^{(\mathcal{M}_{ER})}(l_c)$', ...
    '$\Omega_2^{(\mathcal{M}_{ER})}(l_c)$', ...
    '$\Omega_3^{(\mathcal{M}_{ER})}(l_c)$', ...
    '$\Omega_4^{(\mathcal{M}_{ER})}(l_c)$' ...
}, 'Interpreter', 'latex', 'FontSize', 20, 'Location', 'South', 'Box', 'off', 'NumColumns', 2);

xlim([0.025, 1]); ylim([-62000, 2e5]);

%% ----------- Figure 2(f): Increasing Frequencies vs. \xi ----------------
figure('Units', 'inches', 'Position', [1, 1, 8, 5]); hold on;

for i = 1:4
    plot(xi_values(1:2:end), frequencies_L_inc(i,1:2:end), 'o', ...
        'LineWidth', 1, 'MarkerFaceColor', colors.(getfieldnames(colors){i}), ...
        'MarkerEdgeColor', 'k', 'MarkerSize', 8);
end

set_plot_formatting(gca);
xlabel('$\xi$', 'Interpreter', 'latex', 'FontSize', 24);
ylabel('$\Omega_n$ [Hz]', 'Interpreter', 'latex', 'FontSize', 24);

legend({ ...
    '$\Omega_1^{(\mathcal{M}_{C})}(l_f)$', ...
    '$\Omega_2^{(\mathcal{M}_{C})}(l_f)$', ...
    '$\Omega_3^{(\mathcal{M}_{C})}(l_f)$', ...
    '$\Omega_4^{(\mathcal{M}_{C})}(l_f)$' ...
}, 'Interpreter', 'latex', 'FontSize', 20, 'Location', 'South', 'Box', 'off', 'NumColumns', 2);

xlim([0.025, 1]); ylim([-62000, 2e5]);

%% ----------- Figure 3(a): Combined Plot (HS Data) ----------------
figure('Units', 'inches', 'Position', [1, 1, 8, 6]); hold on;

% Line plots
for i = 1:4
    plot(xi_values, frequencies_xi(i,:)', 'Color', colors.(getfieldnames(colors){i}), 'LineWidth', 3);
end

% Descending markers
for i = 1:4
    plot(xi_values(1:3:end), frequencies_L_desc(i,1:3:end), 'o', ...
        'LineWidth', 1, 'MarkerFaceColor', colors.Desc, 'MarkerEdgeColor', 'k', 'MarkerSize', 6);
end

% Increasing markers
for i = 1:4
    plot(xi_values(1:3:end), frequencies_L_inc(i,1:3:end), 'o', ...
        'LineWidth', 1, 'MarkerFaceColor', colors.Inc, 'MarkerEdgeColor', 'k', 'MarkerSize', 6);
end

set_plot_formatting(gca);
xlabel('$\xi$', 'Interpreter', 'latex', 'FontSize', 20);
ylabel('$\Omega_n$ [Hz]', 'Interpreter', 'latex', 'FontSize', 20);

legend({ ...
    '$\Omega_1^{(\mathcal{M}_{LC})}(\xi)$', ...
    '$\Omega_2^{(\mathcal{M}_{LC})}(\xi)$', ...
    '$\Omega_3^{(\mathcal{M}_{LC})}(\xi)$', ...
    '$\Omega_4^{(\mathcal{M}_{LC})}(\xi)$', ...
    '$\Omega_n^{(\mathcal{M}_{ER})}(l_c)$', '', '', '', ...
    '$\Omega_n^{(\mathcal{M}_{C})}(l_f)$' ...
}, 'Interpreter', 'latex', 'FontSize', 20, 'Location', 'South', 'Box', 'off', 'NumColumns', 4);

xlim([0.025, 1]); ylim([-45000, 1.6e5]);

%% ----------- Figure 3(b): Combined Plot (LS Data) ----------------
load('filepath\data_Fig2&3_LS.mat');

figure('Units', 'inches', 'Position', [1, 1, 8, 6]); hold on;

for i = 1:4
    plot(xi_values, frequencies_xi(i,:)', 'Color', colors.(getfieldnames(colors){i}), 'LineWidth', 3);
end

for i = 1:4
    plot(xi_values(1:3:end), frequencies_L_desc(i,1:3:end), 'o', ...
        'LineWidth', 1, 'MarkerFaceColor', colors.Desc, 'MarkerEdgeColor', 'k', 'MarkerSize', 6);
    plot(xi_values(1:3:end), frequencies_L_inc(i,1:3:end), 'o', ...
        'LineWidth', 1, 'MarkerFaceColor', colors.Inc, 'MarkerEdgeColor', 'k', 'MarkerSize', 6);
end

set_plot_formatting(gca);
xlabel('$\xi$', 'Interpreter', 'latex', 'FontSize', 20);
ylabel('$\Omega_n$ [Hz]', 'Interpreter', 'latex', 'FontSize', 20);

legend({ ...
    '$\Omega_1^{(\mathcal{M}_{LC})}(\xi)$', ...
    '$\Omega_2^{(\mathcal{M}_{LC})}(\xi)$', ...
    '$\Omega_3^{(\mathcal{M}_{LC})}(\xi)$', ...
    '$\Omega_4^{(\mathcal{M}_{LC})}(\xi)$', ...
    '$\Omega_n^{(\mathcal{M}_{ER})}(l_c)$', '', '', '', ...
    '$\Omega_n^{(\mathcal{M}_{C})}(l_f)$' ...
}, 'Interpreter', 'latex', 'FontSize', 20, 'Location', 'South', 'Box', 'off', 'NumColumns', 4);

xlim([0.025, 1]); ylim([-45000, 1.6e5]);
