function res=classifyImg(img,mask,model_skin, model_bkg,th)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% img a test image from the data base
% mask the ground truth for the image
% model_skin the model of the skin pixels
% model_bkg the model of the background pixel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[v,lb]=convertImg2(img,mask);

%v is a feature vector, lb are labels.
%compute the score (likelihood) for each pixel. Denote it lr.
%
muSkin = model_skin(:,1);
muBg = model_bkg(:,1);

sigmaSkin = model_skin(:,2:3);
sigmaBg = model_bkg(:,2:3);

skinPost = model_skin(end,end);
bgPost = model_bkg(end,end);

%consider using posteriors
PrGivenSkin = (mvnpdf(v,muSkin',sigmaSkin'));
PrGivenBg = (mvnpdf(v,muBg',sigmaBg'));
lr = PrGivenSkin*skinPost./(PrGivenBg*bgPost+PrGivenSkin*skinPost);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lb_pred=zeros(size(lb));
lb_pred(find(lr>th))=1;
gt_pos=find(lb==1);
gt_neg=find(lb==0);

%ROC curve and the AUC
disp('computing ROC...');
roc = computeROC(lr(gt_pos),lr(gt_neg));
figure;
plot(1-roc(:,1),roc(:,2));
x=roc(:,1);
y=(roc(2:end,2)+roc(1:end-1,2))/2;
res=sum(diff(x).*y);
%predicted mask
pred_mask=reshape(lb_pred,size(mask,1),size(mask,2));
figure
imagesc(pred_mask);
%ground truth mask
figure;
imagesc(mask);
trueMask = mask / 255;
trueMask = trueMask(:,:,1)+trueMask(:,:,2)+trueMask(:,:,3);
trueMask(trueMask ~= 3) = 1;
trueMask(trueMask == 3) = 0;
correctClass = length(find(trueMask==pred_mask));
[r,c,~] = size(mask);
correctClass = correctClass/ (r*c);
disp("Correctly classified pixels: "+ correctClass*100 + "%");

