function [R, A_inc, B_inc] = genera(m, n, r, incrat, num)
    % generate a low-rank and side-info matirx A_inc, B_inc
    % m, n:
    % r:
    % incrat: side_information incompleteness
    % num: whether use the SVD matrix or not(0 for not)
    
    R_L = randn(m, r);
    R_R = randn(n, r);
    R = R_L * R_R';
    [A_all, ~, B_all] = svds(R, r);
    
    if num == 1 && incrat == 1
        A_inc = A_all;
        B_inc = B_all;
    else
        incrat_int = round(r * incrat);
        
        A_inc = A_all * randn(r, incrat_int);
        B_inc = B_all * randn(r, incrat_int);
        
        [A_inc, ~] = qr(A_inc, 0);
        [B_inc, ~] = qr(B_inc, 0);
    end
end
