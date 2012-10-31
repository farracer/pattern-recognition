
mu = [2 3];
SIGMA = [1 .9; .9,1.8];
r = mvnrnd(mu,SIGMA,500);
mu2 = [-1 2.5];
SIGMA2 = [ 2.5 1.4; 1.4,1.5];
r2 = mvnrnd(mu2,SIGMA2,1000);
tot = [r2;r];
tot = tot';
plot(r(:,1),r(:,2),'+')
hold on
plot(r2(:,1),r2(:,2),'or')
