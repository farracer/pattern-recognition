function [ im ] = bin(lik_skin,lik_nskin)

im = lik_skin>lik_nskin;
end