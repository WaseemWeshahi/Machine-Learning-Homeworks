function [model_skin, model_bkg, th]=learnSkinModel(D)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% D training data  
% model_skin the model of the skin pixels
% model_bkg the model of the background pixel
% th threshold on the likelihood ratio 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=size(D,2);
D2=zeros(3,n);
sum_all=D(1,:)+D(2,:)+D(3,:);
black_px=find(sum_all==0);
D2(1,:)=D(1,:)./sum_all;
D2(2,:)=D(2,:)./sum_all;
D2(1,black_px)=0;
D2(2,black_px)=0;
%%%%%skin pixels
ind=find(D(4,:)==1);
n1=length(ind);
skin=D2(1:2,ind);
%%%%%background pixels
ind=find(D(4,:)~=1);
n2=length(ind);
bg=D2(1:2,ind);

nvalid1=round(n1/3);
ntrain1=n1-nvalid1;
skin_train=skin(:,1:ntrain1);
nvalid2=round(n2/3);
ntrain2=n2-nvalid2;
bg_train=bg(:,1:ntrain2);
valid_data=[skin(:,ntrain1+1:end) bg(:,ntrain2+1:end)];
valid_lb=[ones(1,nvalid1) zeros(1,nvalid2)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%find the model of the skin pixels
%find the model of the background
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%add you code here
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot the distributions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%add your code here
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%find the threshold on the likelihood ratio 
%using the validation set.
%
% Use the following code to compute the ROC curve
% roc = computeROC(lr(gt_pos),lr(gt_neg));
% where lr is the predicted score, gt_pos are the indices of the skin points and gt_neg are the indices of the background points.
% The EER is a point on the ROC curve that gives the equal error rate for both classes. It can be
% compute as follows:
% [ign, r]=min(abs(roc(:,1)-roc(:,2)));
% eer = roc(r,:);
% eer(3) is the threshold corresponding to the equal error rate (EER).
% Note that EER might not be the best theshold in terms of skin pixel detection. 
% In this case, find a point on the ROC that provides better separation in terms of pixel mask.
% You can use any image from  250 to 370 for these purpose.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%add your code here
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
