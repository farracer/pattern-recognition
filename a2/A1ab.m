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

[im,skin_model,nonskin_model]=detector('data/image.png',1.1233,skin_data,nonskin_data);
% im=double(imread('data/image.png'))/255.0;
% 
% im=reshape(im,[],3);
% 
% 
%     sk=mvnpdf(im,skin.mu',skin.sigma);
%     nsk=mvnpdf(im,nonskin.mu',nonskin.sigma);

figure();
subplot(2,1,1);imshow(imread('data/image.png'))
subplot(2,1,2);imshow(im);


%%%%%%%%%%%


