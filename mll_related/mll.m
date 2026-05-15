clc; clear;
%% setting
lambdaX = 1;        
lambdaY = 2;     
mu = 1.2;
pho = 1.2;
beta_max = 1e-1;
beta = 1e-3;
maxIter = 1500;
%% dataset
dataname = 'Reference';
percents = [0.1,0.3,0.5,0.7,0.9];
num_trials = 10; 
results_struct = struct();
%% load data
data_path = [];
load(data_path);
U = [train_data; test_data];
hatT_full = [train_target; test_target];
[n, q] = size(hatT_full);
%% loop
for p_idx = 1:length(percents)
    percent = percents(p_idx);
    trial_results = cell(num_trials, 1); 
    
    for trial_idx = 1:num_trials 
        hatT = hatT_full;
        local_results = struct();
        
        %% construct Omega
        train_num = round(n * 0.9);
        obrT = zeros(size(hatT));
        indexperm = randperm(n);
        train_index = indexperm(1:train_num);
        test_index = indexperm(train_num+1:end);
        remainT = hatT(train_index, :);
        
        for iii = 1:q
            positive_index = find(remainT(:, iii) > 0);
            pos_num = length(positive_index);
            negative_index = find(remainT(:, iii) <= 0);
            neg_num = length(negative_index);
            
            if pos_num > 0
                pos_sel = positive_index(randperm(pos_num, ceil(pos_num * percent)));
                obrT(train_index(pos_sel), iii) = 1;
            end
            if neg_num > 0
                neg_sel = negative_index(randperm(neg_num, ceil(neg_num * percent)));
                obrT(train_index(neg_sel), iii) = 1;
            end
        end
        
        %% preprocess
        if min(hatT(:)) == -1
            hatT = (hatT + 1) / 2;
        end
        A = U;
        [A_2, ~] = qr(U, 0);
        M_Omega = hatT .* obrT;
        B_2 = zeros(size(M_Omega, 2));
        
        %% IDMC
        [T_2, ~] = IDMC(A_2, B_2, M_Omega, obrT, ...
            lambdaX, lambdaY, mu, pho, beta_max, beta, maxIter);
            
        %% performance
        local_results.results_IDMC = ...
            PerformanceMeasure(T_2, hatT, test_index);
           
        trial_results{trial_idx} = local_results; 
    end
    
    field_name = ['percent_' num2str(percent * 100)];
    results_struct.(dataname).(field_name) = trial_results;
end
%% save
output_filename = ['results_struct.mat'];
save(output_filename, 'results_struct');
disp(['Results saved to ' output_filename]);