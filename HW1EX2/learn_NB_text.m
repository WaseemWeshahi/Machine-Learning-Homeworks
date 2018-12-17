function [Pw,P] = learn_NB_text
format long
m = matfile('corpus_train.mat');
texAll = m.texAll;
cat = m.cat;
lbAll = m.lbAll;
voc = m.Voc;
P = zeros(1,length(m.cat)); 

wordsCount=0;

% Calculating Priors of each class
for j=1:length(cat)
    sum=0;
    for i =1:length(lbAll)
        if(ismember(cat{j,1},lbAll{i,1})) 
           sum=sum+length(texAll{i,1});
        end
    end
    P(j)=sum;
    wordsCount=wordsCount+sum;
end
P = P/wordsCount; %to get the probabilities

Pw = zeros(length(voc),length(cat));
for j=1:length(cat)
    % cls is a cell array, each cell containing a line that belongs to the
    % category j
    textj = texAll(ismember(lbAll,cat(j)));
    
    %now we cancatenate all lines, forming one huge cell with the words
    %that belong to category j (has duplicate words)
    textj = vertcat(textj{:});
    n = length(textj);
    for w=1:length(voc)
        % nk number of occurnces for word w in the textj
        nk = nnz(strcmp(textj,voc(w)));       
        Pw(w,j)= (nk+1)/(n+wordsCount);
    end
end







            