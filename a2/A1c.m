clear all;
close all;

load 'data/skin.mat'

load 'data/nonskin.mat'

%calculate cov_matrix, compare to Octaave
cov_mat(sdata')-cov(sdata')<.000001

cov_mat(ndata')-cov(ndata')<.0001

cov_sdata=cov_mat(sdata');


cov_m_n=cov_mat(ndata');


mean_n=cmean(ndata')';

skin_data=struct('mu',cmean(sdata')','sigma',cov_mat(sdata'));

nonskin_data=struct('mu',cmean(ndata')','sigma',cov_mat(ndata'));

[im,skin_model,nonskin_model]=detector('data/image.png',0.1,skin_data,nonskin_data);
mask=double(imread('data/mask.png'))/255.0;
mask=reshape(mask,[],1);
n_t=100;
theta=logspace(-5,5,n_t);

nfns=zeros(n_t,1);
nfps=zeros(n_t,1);
ntps=zeros(n_t,1);
ntns=zeros(n_t,1);

for i=1:100
    bin=bin_threshold(skin_model,nonskin_model,log(theta(i)));

    [nfns(i),nfps(i),ntps(i),ntns(i)] = compare_mask(mask,bin);
    

end

%Def from wikipedia
plot(nfps./(nfps+ntns),ntps./(ntps+nfns),'.')

xlabel('false positive rate')
ylabel('true positive rate')
title('ROC')

%%get optimal thetas
figure()
plot(log10(theta),nfns,'r',log10(theta),nfps,'b',log10(theta),nfps+nfns,'g')
legend('False Negative','False Positive','TotalError');
[eq_err_theta,y]=polyxpoly(theta,nfns,theta,nfps);
hold on;
plot(log10(eq_err_theta),y,'o')
[nerr,i]=min(nfps+nfns);
min_err_theta=theta(i);
plot(log10(min_err_theta),nerr,'o')
xlabel('\Theta')
ylabel('#of pixels');

%%Construct the max a posteriori classifier
[p_skin,p_nonskin] = getPriorsfromMask(mask);

skin_data.prior = p_skin;
nonskin_data.prior = p_nonskin;
imgtest=double(imread('data/test.png'))/255.0;

binmaxPost = maxApostClassifier(imgtest,nonskin_data,skin_data);
[binminerror, a,b] = detector('data/test.png',min_err_theta,skin_data,nonskin_data);
[bineqerror, a,b] = detector('data/test.png',eq_err_theta,skin_data,nonskin_data);

%%%TODO : ERROR RATES
mask=double(imread('data/mask-test.png'))/255.0;
n_maxPost=zeros(1,4);
n_minError = zeros(1,4);
n_eqError = zeros(1,4);
[nfn_maxPost,nfp_maxPost,ntp_maxPost,ntn_maxPost] = compare_mask(mask,binmaxPost);

[nfn_minError,nfp_minError,ntp_minError,ntn_minError] = compare_mask(mask,binminerror);

[nfn_eqError,nfp_eqError,ntp_eqError,ntn_eqError] = compare_mask(mask,bineqerror);


figure()
subplot(2,2,2)
imshow(binmaxPost)
title('Max a Posteriori')
subplot(2,2,3)
imshow(binminerror);
title('Minimal Error')
subplot(2,2,4)
imshow(bineqerror)
title('Equal error')
subplot(2,2,1)
imshow('data/mask-test.png')
title('Original');

%display rates
fprintf('Max A Post Classifier TP Rate: %0.3f, FP Rate: %0.3f, Total Error Rate: %0.3f\n',ntp_maxPost/(ntp_maxPost+nfn_maxPost),nfp_maxPost/(nfp_maxPost+ntn_maxPost),(nfp_maxPost+nfn_maxPost)/numel(mask))

fprintf('Min Error Classifier TP Rate: %0.3f, FP Rate: %0.3f, Total Error Rate: %0.3f\n',ntp_minError/(ntp_minError+nfn_minError),nfp_minError/(nfp_minError+ntn_minError),(nfp_minError+nfn_minError)/numel(mask))


fprintf('Eq Error Classifier TP Rate: %0.3f, FP Rate: %0.3f, Total Error Rate: %0.3f\n',ntp_eqError/(ntp_eqError+nfn_eqError),nfp_eqError/(nfp_eqError+ntn_eqError),(nfp_eqError+nfn_eqError)/numel(mask))

