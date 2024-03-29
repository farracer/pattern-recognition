function [mu_new,covm_new,p_new] = updateParametersGMM(data,p_j)
%Update the parameters in EM Algorithm
[covm_size,n_samples] = size(data);
p_new = mean(p_j); % 1/n*sum(p_j)

norm_factor = sum(p_j);



% for i=1:n_samples
%     sum_mu = sum_mu + p_j(i)*data(:,i); %repmat
% end

sum_mu = sum(repmat(p_j,covm_size,1).*data,2);

mu_new = sum_mu/norm_factor;
 % to make it fit, should be 

% covm_new = zeros(covm_size);
% for i=1:n_samples
%     covm_new = covm_new + p_j(i)*(data(:,i)-mu_new)*(data(:,i)-mu_new)';
% end
% 
% covm_new = covm_new/norm_factor;
covm_new = updateV(data',p_j',mu_new',norm_factor,[]);

function V = updateV( X, E, M, W, b0 )

[n d] = size(X);
k = length(W);
V = zeros( [d d k] );
for i=1:k,
    x0 = X - repmat( M(i,:), n, 1 );   % center about ith centroid
    
    %TODO. this is a hack to avoid a singularity
    %in the cov(x) due to too few observations. I just use the overall
    %covariance which greatly inflates the variance
    if W(i)<d*5
        v = cov(X);
    else
        v    = (repmat(E(:,i),1,d).*x0)'*x0;   % weighted sum of squares and cross products
        v    = (v+v')/2;      % adjust roundoff errors it symmetric
    end
    V(:,:,i) = v;
end

W = reshape( repmat( W', [d*d, 1] ), [d d k ] ) ;

% collect 
if nargin > 4 && ~isempty(b0)
    for i = 1:d
        for j = 1:d
         V(i,j,:) = reshape(V(i,j,:), 1,k)*b0(:,:,i,j);
         W(i,j,:) = reshape(W(i,j,:), 1,k)*b0(:,:,i,j);
        end
    end
end
W(W==0) = 1;
V = V./W;
