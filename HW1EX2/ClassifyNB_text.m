function suc = ClassifyNB_text(Pw,P)
% INPUT: test data documnets
%        Pw - Conditinal probabilities matrix
%        P  - class priors
% OUTPUT: 
%       suc - success rate: number of successfully classified documents

m = matfile('corpus_train.mat');
cat = m.cat;
voc = m.Voc;


testAll = m.texAll;

lbAll = m.lbAll;

suc = 0;

Pw = log(Pw); % to avoid underflow
P = log(P);
% for each line, we guess what class he belongs toe
for i=1:length(testAll)
    % todo: find the posetions in which the word belong to the vocab that
    % we've built
    % positions = strfind(texAll 
    idx = ismember(testAll{i},voc); % we take only the words that have previously 
    docs = testAll{i}(idx);         % appeared in out vocabulary
    positions = zeros(1,length(docs));
    for j=1:length(docs)
        positions(j) = find(strcmp(voc,docs(j)));
    end
    
    probVec = P+sum(Pw(mod(positions,14575)+1,:));
    [~,ind] = max((probVec));
    pred = cat{ind};
    if(ismember(pred,lbAll{i}))
        suc = suc+1;
    end
end
suc = suc/lines;