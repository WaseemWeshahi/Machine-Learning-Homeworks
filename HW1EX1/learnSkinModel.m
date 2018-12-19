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
meanSkin = mean(skin_train')';
sigmaSkin = zeros(2,2);
for k=1:ntrain1
	sigmaSkin = sigmaSkin +  (skin_train(:,k) - meanSkin)*((skin_train(:,k) - meanSkin)');
end
sigmaSkin = sigmaSkin./ntrain1;

meanBg = mean(bg_train')';
sigmaBg = zeros(2,2);
for k=1:ntrain2
	sigmaBg = sigmaBg +  (bg_train(:,k) - meanBg)*((bg_train(:,k) - meanBg)');
end
sigmaBg = sigmaBg./ntrain2;

skinPosterior = ntrain1/(ntrain1+ntrain2);
bgPosterior = ntrain2 / (ntrain1+ntrain2);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Plot distribution 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% xAxis = linspace(0,1,150); % values from 0 to 1
% skinRed = normpdf(xAxis,meanSkin(1),sqrt(sigmaSkin(1,1)));
% skinGreen = normpdf(xAxis,meanSkin(2),sqrt(sigmaSkin(2,2)));
% bgRed = normpdf(xAxis,meanBg(1),sqrt(sigmaBg(1,1)));
% bgGreen = normpdf(xAxis,meanBg(2),sqrt(sigmaBg(2,2)));
figure;
x1 = 0:0.02:1;
x2 = 0:0.02:1;
[X1,X2] = meshgrid(x1,x2);
F = mvnpdf([X1(:) X2(:)],meanSkin',sigmaSkin');
F = reshape(F,length(x2),length(x1));
surf(x1,x2,F);
caxis([min(F(:))-.5*range(F(:)),max(F(:))]);
axis([0 1 0 1 0 100])
xlabel('Red ratio'); ylabel('Green Ratio'); zlabel('Probability Density in being a skin');
 figure
F = mvnpdf([X1(:) X2(:)],meanBg',sigmaBg');
F = reshape(F,length(x2),length(x1));
surf(x1,x2,F);
caxis([min(F(:))-.5*range(F(:)),max(F(:))]);
axis([0 1 0 1 0 100])
xlabel('Red ratio'); ylabel('Green Ratio'); zlabel('Probability Density in being a background');
%... draw plot(xAxis,skinRed)
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
gt_pos = valid_lb==1;
gt_neg = valid_lb==0;
PrGivenSkin = (mvnpdf(valid_data',meanSkin',sigmaSkin'));
PrGivenBg = (mvnpdf(valid_data',meanBg',sigmaBg'));
lr = PrGivenSkin*skinPosterior./(PrGivenBg*bgPosterior+PrGivenSkin*skinPosterior);
ROC = computeROC(lr(gt_pos),lr(gt_neg));
% where lr is the predicted score, gt_pos are the indices of the skin points and gt_neg are the indices of the background points.
% The EER is a point on the ROC curve that gives the equal error rate for both classes. It can be
% compute as follows:

 [~, r]=min(abs(skinPosterior*ROC(:,1)-bgPosterior*ROC(:,2)));
%  [~,r] = min((0-(1-ROC(:,1))).^2 + (1-ROC(:,2)).^2);
% [~, r]=min(abs(ROC(:,1)-ROC(:,2)));
eer = ROC(r,:);
% Consider tweaking this threshold for better results
th = eer(3);
model_skin = zeros(2,4);
model_bkg = zeros(2,4);
model_skin(:,1) = meanSkin;
%MAY consider sending the whole sigma Matrix
model_skin(:,2:3) = sigmaSkin;
model_skin(:,4) = skinPosterior;

model_bkg(:,1) = meanBg;
model_bkg(:,2:3) = sigmaBg;
model_bkg(:,4) = bgPosterior;

end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
