function gmm = gmmEM(data, K, iter)
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
    
    gmmDraw(gmm,data);
    %p(x_k|j,theta)
    comp_lik = evaluateComponents(data,gmm);

    %% calculate probabilities
    p_x=zeros(1,samples);
    %probability of  p(x | theta)
    for i=1:K
        p_x = p_x+comp_lik(i,:)*gmm(i).p;
    end

    %responsibility of mixture component p_j for each sample p(j|x_k,theta)
    p_j = zeros(K,samples);
    for i=1:K

        p_j(i,:)=comp_lik(i,:)*gmm(i).p./p_x;
    end


    %% update parameters
    for i = 1:K
        [gmm(i).mean,gmm(i).covm,gmm(i).p] = updateParametersGMM(data,p_j(i,:));

    end
    
    pause(.5);
end