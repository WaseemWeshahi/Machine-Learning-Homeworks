function rate = computeROC(Class1Marg,Class2Marg)

%Class1Marg is the scores of the first class

 %Class2Marg is the scores of the second class

Class1Length = length(Class1Marg);
Class2Length = length(Class2Marg);
r1 = [Class1Marg,ones(Class1Length,1)];
r2 = [Class2Marg,2*ones(Class2Length,1)];
R = [r1;r2];
[sR,ind] = sort(R(:,1));
sR =[sR, R(ind,2)];
for th = 1 : length(R)
    rate(th,1) = size(find(sR(1:th,2) == 2),1)/Class2Length;%True negative
    rate(th,2) = size(find(sR(th+1:end,2) == 1),1)/Class1Length;
    rate(th,3)=sR(th,1);
end