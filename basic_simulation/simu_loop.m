clc; clear;
%% Reproducibility
rng(2026422, 'twister');

%% Problem settings
m = 100;          % number of rows
n = 100;          % number of columns
r = 10;           % rank
incrat = 0.2;     % missing ratio
swi = 0;          % flag for eigenvalue matrix

sampling_rates = 0.1:0.03:0.4;
num_rates = length(sampling_rates);

%% loop
for run = 1:1

    relative_errors = zeros(num_rates, 1);

    save_path = sprintf(); % saving path

    %% Generate data
    [R_true, A, B] = genera(m, n, r, incrat, swi);

    %% Parameters for IDMC
    lambdaX = 50;
    lambdaY = 200;
    mu = 1.2;
    maxIter = 1000;
    l = 3;
    beta_max = 1;
    beta = 1e-2;
    pho = 1.2;

    for i = 1:num_rates
        sampling_rate = sampling_rates(i);

        % Generate observation mask
        Omega = rand(m, n) < sampling_rate;

        % Observed matrix
        R = R_true .* Omega;

        % Run IDMC
        [X, Y] = IDMC(A, B, R, Omega, ...
            lambdaX, lambdaY, mu, pho, beta_max, beta, maxIter);

        % Compute relative Frobenius error
        norm_original = norm(R_true, 'fro');
        norm_difference = norm(X - R_true, 'fro');
        relative_difference = norm_difference / norm_original;

        relative_errors(i) = relative_difference;
    end

    %% Save results
    data_to_save = [sampling_rates', relative_errors];

    fid = fopen(save_path, 'w');
    fclose(fid);

    writematrix(data_to_save, save_path, 'WriteMode', 'append');
end