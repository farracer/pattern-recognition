function gmm=initMixtureModels(data,K)
%Initialize a gaussian mixture consisting of k components

%  Parameters:  data - Training inputs,           #(dims) x #(samples)
%               K- Number of GMM components, integer (>=1) 



[r,c] = size(data);
if r>c
    error 'there should be more samples than dimensions'
end

    
[idx,c] = kmeans(data',K);

gmm = struct([]);
n_samples = numel(data)/3;

for i=1:K
   
    gmm(i).mean = c(i,:)';
    gmm(i).p = double(nnz(idx == i))/double(n_samples);
    gmm(i).covm = cov(data(:,idx==i)');
    
end