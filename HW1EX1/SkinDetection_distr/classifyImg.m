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
%add your implementation here
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lb_pred=zeros(size(lb));
lb_pred(find(lr>th))=1;
gt_pos=find(lb==1);
gt_neg=find(lb==0);

%ROC curve and the AUC
display('computing ROC...');
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