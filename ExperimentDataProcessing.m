%%% MODE SHAPE & NATURAL FREQUENCY EXTRACTION %%%
% This script loads experimental data, reconstructs the complex FRFs,
% extracts natural frequencies using modal fitting, and computes mode shapes.

clc; clear; close all;

%% ------------------------ USER INPUT ------------------------

% Set paths to folders containing FRF CSVs for each configuration
folder_paths = {
}; % <-- Replace with actual paths

% Sensor locations [mm] for each configuration
locations = {
    [0, 10, 20, 50, 95, 140, 185, 230], ...
    [0, 12.5, 25, 55, 98.75, 142.5, 186.25, 230], ...
    [0, 15, 30, 60, 102.5, 145, 187.5, 230], ...
    [0, 17.5, 35, 65, 106.25, 147.5, 188.75, 230], ...
    [0, 20, 40, 70, 110, 150, 190, 230], ...
    [0, 22.5, 45, 75, 113.75, 152.5, 191.25, 230], ...
    [0, 25, 50, 80, 117.5, 155, 192.5, 230], ...
    [0, 27.5, 55, 85, 121.25, 157.5, 193.75, 230], ...
    [0, 30, 60, 90, 125, 160, 195, 230], ...
    [0, 32.5, 65, 95, 128.75, 162.5, 196.25, 230], ...
    [0, 35, 70, 100, 132.5, 165, 197.5, 230]
};

%% ---------------------- INITIALIZATION ----------------------

% Storage structure for mode shapes and frequencies
mode_shapes_storage = struct;

% Frequency analysis range
min_frequency = 50;
max_frequency = 8000;

% Sampling rate and mode count
fs = 17066.67;
n_modes = 30;

%% ---------------------- PROCESSING LOOP ---------------------

for config_idx = 1:length(folder_paths)
    folder_path = folder_paths{config_idx};
    location = locations{config_idx};

    % Load all CSV files
    file_list = dir(fullfile(folder_path, '*.csv'));
    all_frfs = [];
    
    for i = 1:length(file_list)
        data = readtable(fullfile(file_list(i).folder, file_list(i).name));
        
        frequencies = data.Frequency;
        magnitude = data.Averaged_FRF_Magnitude;
        phase_deg = data.Averaged_Phase;
        
        % Convert to complex FRF
        frf_complex = magnitude .* exp(1i * deg2rad(phase_deg));
        
        if i == 1
            all_frequencies = frequencies';  % assume same across sensors
        end
        
        all_frfs = [all_frfs; frf_complex'];  % each row = sensor, cols = frequencies
    end

    % Filter within desired frequency band
    f_filter = (all_frequencies >= min_frequency) & (all_frequencies <= max_frequency);
    filtered_frequencies = all_frequencies(f_filter);
    filtered_frfs = all_frfs(:, f_filter);

    % Transpose for modalfit compatibility: rows = frequencies, cols = sensors
    frfs_for_fit = real(filtered_frfs)';  % Only real part is used

    % Modal fitting
    [fn, dr, ms, ~] = modalfit(frfs_for_fit, filtered_frequencies, fs, n_modes, 'FitMethod', 'lsrf');

    % Keep only modes within defined frequency bounds
    valid_idx = fn >= min_frequency & fn <= max_frequency;
    resonance_frequencies = fn(valid_idx);
    mode_shapes_raw = ms(:, valid_idx);

    % Normalize each mode shape
    mode_shapes = cell(1, length(resonance_frequencies));
    for k = 1:length(resonance_frequencies)
        shape = mode_shapes_raw(:, k);
        mode_shapes{k} = shape / max(abs(shape));
    end

    % Store results
    mode_shapes_storage(config_idx).location = location;
    mode_shapes_storage(config_idx).resonance_frequencies = resonance_frequencies;
    mode_shapes_storage(config_idx).mode_shapes = mode_shapes;
end

% Save results
save('mode_shapes_data.mat', 'mode_shapes_storage');
