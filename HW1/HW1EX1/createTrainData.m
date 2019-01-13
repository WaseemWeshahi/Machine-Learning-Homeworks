function D=createTrainData
ntrain=370;
nsample1=140;
nsample2=520;
D=zeros(ntrain*(nsample1+nsample2),4);
count=1;
for i=1:ntrain
    i
    M=(imread(sprintf('ibtd/ibtd/Mask/%04d.bmp',i-1)));
    M=rgb2gray(M);
    M=reshape(M,size(M,1)*size(M,2),1);
    I=imread(sprintf('ibtd/ibtd/%04d.jpg',i-1));
    I=reshape(I,size(I,1)*size(I,2),3);
    pos=find(M<255);
    neg=find(M==255);
    pos=pos(randperm(length(pos)));
    D(count:count+nsample1-1,1:3)=I(pos(1:nsample1),:);
    D(count:count+nsample1-1,4)=1;
    count=count+nsample1;
    neg=neg(randperm(length(neg)));
    D(count:count+nsample2-1,1:3)=I(neg(1:nsample2),:);
    D(count:count+nsample2-1,4)=0;
    count=count+nsample2;
    
end
    