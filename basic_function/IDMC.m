function [X, Y] = IDMC(A, B, R, Omega, lambdaX, lambdaY, mu,  pho,  beta_max,  beta,  maxIter)
    %  input
    %   A, B      - side-information matrix
    %   R - oberved matrix
    %   Omega - observation matrix 
    %   lambdaX 
    %   lambdaY 
    %   mu
    %   maxIter
    % output：
    %   X,Y  

    [m, n] = size(R);
    X_prev = zeros(m,n);
    X = zeros(m, n);
    Y = zeros(m, n);
    M1 = zeros(m, n);
    M2 = zeros(m, n);
    PA = A*A';  PB = B*B';  
    k = 0;  
    I_1 = eye(size(PA,1));
    I_2 = eye(size(PB,1));

    while true
      
        % X^(k+1)
        f1 =  (X - R + M1 / beta).*Omega ;
        f2 = (I_1 - PA)*(X - Y + M2 / beta)*(I_2 - PB); 
        X = SVT(X - f1*mu/2 - f2*mu/2, (mu*lambdaX)/(2*beta));

        % Y^(k+1)
        Y = SVT((I_1-PA)*X*(I_2-PB) + M2/beta, lambdaY/ beta);

        % M1^(k+1)
        M1 = M1 + beta * ((X - R).*Omega);

        % M2^(k+1)
        M2 = M2 + beta * ((I_1-PA)*X*(I_2-PB)-Y);
      
        beta = min(beta_max,pho*beta);
  
        previous_relative_diff = norm(X - R, 'fro') / norm(R, 'fro');
        X_prev = X;
        k = k + 1;
        if k>maxIter
            break;
        else
        end
    end
end