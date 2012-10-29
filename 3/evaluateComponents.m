function p=evaluateComponents(data,gmm)
%This function evaluates for each sample the pdf of the different
%mixture components. 
%and returns it as matrix #component x #sample
%
%
%Parameters:  data - Training inputs,           #(dims) x #(samples)
%               gmm - Array of structures holding the GMM parameters
%           Use gmm(i).mean, gmm(i).covm, gmm(i).p

[a,ncomps]=size(gmm);
[a,nsamples] = size(data);

p=zeros(ncomps,nsamples);

for i = 1:ncomps
    p(i,:)=mvnpdf(data',gmm(i).mean',gmm(i).covm);
end
    