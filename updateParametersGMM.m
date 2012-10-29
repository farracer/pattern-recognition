function [mu_new,covm_new,p_new] = updateParametersGMM(data,p_j)
%Update the parameters in EM Algorithm
[covm_size,n_samples] = size(data);
p_new = mean(p_j); % 1/n*sum(p_j)

norm_factor = sum(p_j);

sum_mu = 0;

% for i=1:n_samples
%     sum_mu = sum_mu + p_j(i)*data(:,i); %repmat
% end

sum_mu = sum(repmat(p_j,covm_size,1).*data,2);

mu_new = sum_mu/norm_factor;
 % to make it fit, should be 

covm_new = zeros(covm_size);
for i=1:n_samples
    covm_new = covm_new + p_j(i)*(data(:,i)-mu_new)*(data(:,i)-mu_new)';
end

covm_new = covm_new/norm_factor;

