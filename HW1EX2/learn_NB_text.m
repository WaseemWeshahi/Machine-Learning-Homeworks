function [Pw,P] = learn_NB_text
% INPUT: the text attributes saved in corpus_train.mat
% OUTPUT:
%   Pw - class conditional probabilities matrix: a |voc| x #OfCategories that Pw(i,j) is the probability of the word
% i showing up in the class j, aka P(Wi|Cj)
%   P - class Priors vector: a 1 x #OfCategories vector so that P(j) is the
% prior of the class j
%

m = matfile('corpus_train.mat');
texAll = m.texAll;
cat = m.cat;
lbAll = m.lbAll;
voc = m.Voc;

wordsCount=0;

P = zeros(1,length(cat)); 
Pw = zeros(length(voc),length(cat));
for j=1:length(cat)
    % Calculating Priors
    sum=0; % The number of words labeled j (counting duplicates)
    for i =1:length(lbAll)
        if(ismember(cat{j,1},lbAll{i,1})) % equavilant of ==
           sum=sum+length(texAll{i,1});
        end
    end
    P(j)=sum;
    P = P/wordsCount; %to get the probabilities

    wordsCount=wordsCount+sum;
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







            