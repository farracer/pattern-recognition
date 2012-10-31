function gmm = gmmEM(data, K, iter,showbool)
%GMMEM - EM-algorithm for Gaussian Mixture Models
%  Usage: gmm = gmmEM(data, K, iter)
%
%  Parameters:  data - Training inputs,           #(dims) x #(samples)
%               K- Number of GMM components, integer (>=1) 
%               iter - Number of iterations, integer (>=0)
%               
%  Outputs: gmm - Array of structures holding the GMM parameters
%           Use gmm(i).mean, gmm(i).covm, gmm(i).p
%
%

[dims,samples] = size(data);

%% Initialization
gmm = initMixtureModels(data,K);

%% calculate probabilities of components
for i=1:iter
    if showbool
        gmmDraw(gmm,data);
    end
    %p(x_k|j,theta)
    comp_lik = evaluateComponents(data,gmm);

    %% calculate probabilities
    p_x=sum(comp_lik);
    %probability of  p(x | theta)
    

    %responsibility of mixture component p_j for each sample p(j|x_k,theta)
%     p_j = zeros(K,samples);
%     for j=1:K
% 
%         p_j(j,:)=comp_lik(j,:)./p_x;
%     end
    p_j=comp_lik./(repmat(p_x,size(comp_lik,1),1));

    %% update parameters
    for j = 1:K
        [gmm(j).mean,gmm(j).covm,gmm(j).p] = updateParametersGMM(data,p_j(j,:));

    end
    if showbool
        pause(.5);
    end
end