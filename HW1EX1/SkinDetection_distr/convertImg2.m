function [x,lb]=convertImg2(I,M)
 M=rgb2gray(M);
 M=reshape(M,size(M,1)*size(M,2),1);
 lb=zeros(size(M,1),1);
 lb(find(M<255))=1;
 lb(find(M==255))=0;
 
 
 I=double(reshape(I,size(I,1)*size(I,2),3));
 sum_all=I(:,1)+I(:,2)+I(:,3);
 black_px=find(sum_all==0);
 x=zeros(size(I,1),2);
 x(:,1)=I(:,1)./sum_all;
 x(:,2)=I(:,2)./sum_all;
 x(black_px,1)=0;
 x(black_px,2)=0; 
 

