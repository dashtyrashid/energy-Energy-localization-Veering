
%% ==== Figure 7(a): Modes 1 and 2 ====


% Dimensionalize frequencies

% Call dimensionalize once, passing all 4 columns
[f1, f2, f3, f4] = dimensionalize(omega_store(:,1), omega_store(:,2), omega_store(:,3), omega_store(:,4), p, E, I, Lt, rho, A);

% Recombine into a matrix (optional)
f_dim = [f1, f2, f3, f4];  % 100x4 matrix


% Set custom colormap
customcolormap = slanCM('coolwarm');  % Ensure slanCM.m is on path
colormap(customcolormap);

% Setup figure
figure('Units', 'inches', 'Position', [1, 1, 8, 6]);
hold on;

x = xi_values;
y1 = f1; lambda1 = energy_localization(:,1);
y2 = f2; lambda2 = energy_localization(:,2);

% Plot Omega_1
for i = 1:length(x)-1
    idx = round(((lambda1(i) - min(lambda1)) / (max(lambda1) - min(lambda1))) * (size(customcolormap,1)-1)) + 1;
    plot(x(i:i+1), y1(i:i+1), '-', 'Color', 'k', 'LineWidth', 3);
end
scatter(x, y1, 100, lambda1, 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceAlpha', 1);

% Plot Omega_2
for i = 1:length(x)-1
    idx = round(((lambda2(i) - min(lambda2)) / (max(lambda2) - min(lambda2))) * (size(customcolormap,1)-1)) + 1;
    plot(x(i:i+1), y2(i:i+1), '-', 'Color', 'k', 'LineWidth', 3);
end
scatter(x, y2, 100, lambda2, 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceAlpha', 1);

% Experimental points
scatter(0.7, 1249.49, 350, 'diamond', 'r', 'filled', 'MarkerEdgeColor', 'w', 'LineWidth', 2);
scatter(0.7, 1562.7,  350, 'diamond', 'b', 'filled', 'MarkerEdgeColor', 'w', 'LineWidth', 2);
scatter(0.76, 1881.8, 400, 'square',  'r', 'filled', 'MarkerEdgeColor', 'w', 'LineWidth', 2);
scatter(0.76, 1316.7, 400, 'square',  'b', 'filled', 'MarkerEdgeColor', 'w', 'LineWidth', 2);

% Colorbar
c = colorbar('Location', 'eastoutside');
caxis([0, 1]);
c.Ticks = [0, 1];
c.TickLabelInterpreter = 'latex';
c.Label.String = '$\Lambda_n$';
c.Label.Interpreter = 'latex';
c.Label.FontSize = 24;
c.Label.Rotation = 0;
c.FontSize = 16;

% Axes formatting
ax = gca;
ax.FontSize = 16;
ax.LineWidth = 1.5;
ax.TickLabelInterpreter = 'latex';
xlim([0.68, 0.78]);
ylim([1000, 2000]);
xlabel('$\xi$', 'Interpreter', 'latex', 'FontSize', 24);
ylabel('$\Omega_n$', 'Interpreter', 'latex', 'FontSize', 24);
box on;

%% ==== Figure 7(b): Modes 2 and 3 ====

customcolormap = slanCM('coolwarm');
colormap(customcolormap);

figure('Units', 'inches', 'Position', [1, 1, 8, 6]);
hold on;

xline(0.76, ':k', 'LineWidth', 2.5);
xline(0.84, ':k', 'LineWidth', 2.5);

x = xi_values;
y1 = f2; lambda1 = energy_localization(:,2);
y2 = f3; lambda2 = energy_localization(:,3);

% Plot Omega_2
for i = 1:length(x)-1
    idx = round(((lambda1(i) - min(lambda1)) / (max(lambda1) - min(lambda1))) * (size(customcolormap,1)-1)) + 1;
    plot(x(i:i+1), y1(i:i+1), '-', 'Color', 'k', 'LineWidth', 3);
end
scatter(x, y1, 100, lambda1, 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceAlpha', 1);

% Plot Omega_3
for i = 1:length(x)-1
    idx = round(((lambda2(i) - min(lambda2)) / (max(lambda2) - min(lambda2))) * (size(customcolormap,1)-1)) + 1;
    plot(x(i:i+1), y2(i:i+1), '-', 'Color', 'k', 'LineWidth', 3);
end
scatter(x, y2, 100, lambda2, 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceAlpha', 1);

% Colorbar
c = colorbar('Location', 'eastoutside');
caxis([0, 1]);
c.Ticks = [0, 1];
c.TickLabelInterpreter = 'latex';
c.Label.String = '$\Lambda_n$';
c.Label.Interpreter = 'latex';
c.Label.FontSize = 24;
c.Label.Rotation = 0;
c.FontSize = 16;

% Axes formatting
ax = gca;
ax.FontSize = 16;
ax.LineWidth = 1.5;
ax.TickLabelInterpreter = 'latex';
xlim([0.74, 0.86]);
ylim([1400, 5000]);
xlabel('$\xi$', 'Interpreter', 'latex', 'FontSize', 24);
ylabel('$\Omega_n$', 'Interpreter', 'latex', 'FontSize', 24);
box on;

%% ==== Figure 7(c): Modes 3 and 4 ====

customcolormap = slanCM('coolwarm');
colormap(customcolormap);

figure('Units', 'inches', 'Position', [1, 1, 8, 6]);
hold on;

xline(0.84, ':k', 'LineWidth', 2.5);
xline(0.88, ':k', 'LineWidth', 2.5);

x = xi_values;
y1 = f3; lambda1 = energy_localization(:,3);
y2 = f4; lambda2 = energy_localization(:,4);

% Plot Omega_3
for i = 1:length(x)-1
    idx = round(((lambda1(i) - min(lambda1)) / (max(lambda1) - min(lambda1))) * (size(customcolormap,1)-1)) + 1;
    plot(x(i:i+1), y1(i:i+1), '-', 'Color', 'k', 'LineWidth', 3);
end
scatter(x, y1, 100, lambda1, 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceAlpha', 1);

% Plot Omega_4
for i = 1:length(x)-1
    idx = round(((lambda2(i) - min(lambda2)) / (max(lambda2) - min(lambda2))) * (size(customcolormap,1)-1)) + 1;
    plot(x(i:i+1), y2(i:i+1), '-', 'Color', 'k', 'LineWidth', 3);
end
scatter(x, y2, 100, lambda2, 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceAlpha', 1);

% Colorbar
c = colorbar('Location', 'eastoutside');
caxis([0, 1]);
c.Ticks = [0, 1];
c.TickLabelInterpreter = 'latex';
c.Label.String = '$\Lambda_n$';
c.Label.Interpreter = 'latex';
c.Label.FontSize = 24;
c.Label.Rotation = 0;
c.FontSize = 16;

% Axes formatting
ax = gca;
ax.FontSize = 16;
ax.LineWidth = 1.5;
ax.TickLabelInterpreter = 'latex';
xlim([0.82, 0.9]);
ylim([3500, 6700]);
xlabel('$\xi$', 'Interpreter', 'latex', 'FontSize', 24);
ylabel('$\Omega_n$', 'Interpreter', 'latex', 'FontSize', 24);
box on;
