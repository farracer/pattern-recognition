function [ im ] = bin_threshold(loglik1,loglik2,logtheta )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
im = (loglik1-loglik2)>logtheta;

end

