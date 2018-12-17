function [Pw,P] = learn_NB_text

m = matfile('corpus_train.mat');

P = zeros(1,length(m.cat)); 

totalsum=0;

for j=1:length(m.cat)
    sum=0;
    for i =1:length(m.lbAll)
        if(m.cat(j,1)==m.lbAll(i,1))
           sum=sum+length(m.texAll(i,1));
        end
    end
    P(j)=sum;
    totalsum=totalsum+sum;
end
%P = P/totalsum;

Pw = zeros(length(m.voc),length(m.cat));
for j=1:length(m.cat)
    cls = texAll(find(lbAll==m.cat(j)));
    
    for w=1:length(m.voc)
        nk=0;
        
        for i=1:length(cls)
            nk=nk+length(find(cls==w));
        end
        Pw(w,j)= (nk+1)/(P(j)+totalsum);
    end
end







            