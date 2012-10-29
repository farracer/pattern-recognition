function [ nfp, nfn, ntp, ntn ] = compare_mask(template,calculated)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% nfp = sum(sum(~template&calculated));
% nfn = sum(sum(template&~calculated));
% 
% ntp = sum(sum(template & calculated));
% ntn = sum(sum(~template & ~calculated));
nfp = nnz(~template&calculated);
nfn = nnz(template&~calculated);

ntp = nnz(template & calculated);
ntn = nnz(~template & ~calculated);


end

