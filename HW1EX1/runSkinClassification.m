function av_res=runSkinClassification(k)
%k is the number of test images
D=createTrainData;
[model_skin, model_bkg, th]=learnSkinModel(D');
%run over k images
k = 10;
for i=1:k
    img=imread(sprintf('ibtd/ibtd/%04d.jpg',i+371));
    mask=imread(sprintf('ibtd/ibtd/Mask/%04d.bmp',i+371));
    res(i)=classifyImg(img,mask,model_skin, model_bkg, th);
    
end
av_res=mean(res);