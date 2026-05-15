function [X] = SVT(R,tau);
%rankOverTime = zeros(kmax);
[U, S, V] = svd(R,'econ');
sizeS = size(S);
sigma = diag(S);
b = find(sigma <= tau);
if isempty(b) 
    X= U(:,1:sizeS)*diag(sigma(1:sizeS)-tau)*V(:,1:sizeS)';
else
r = b(1)-1; %% r is the index of the last sigma greater than tau
X= U(:,1:r)*diag(sigma(1:r)-tau)*V(:,1:r)';
end
% exit if tolerance is sufficient
end


