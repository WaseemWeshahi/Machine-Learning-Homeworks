function suc = Classify_NB_text(Pw,P)
% INPUT: test data documnets
%        Pw - Conditinal probabilities matrix
%        P  - class priors
% OUTPUT: 
%       suc - success rate: number of successfully classified documents

test = matfile('corpus_test.mat');
train = matfile('corpus_train.mat');

cat = train.cat;
voc = train.Voc;

testAll = test.TestexAll;
lbAll = test.TestlbAll;

suc = 0;

 Pw = log(Pw); % to avoid underflow
 P = log(P);
% for each line, we guess what class he belongs toe
for i=1:length(testAll)
    idx = ismember(testAll{i},voc); % we take only the words that have previously 
    docs = testAll{i}(idx);         % appeared in our vocabulary
    positions = zeros(1,length(docs));
    for j=1:length(docs)
        positions(j) = find(strcmp(voc,docs(j)));
    end
    
    probVec = P+sum(Pw(positions,:));
    [~,ind] = max((probVec));

    pred = cat{ind};
    if(ismember(pred,lbAll{i}))
        suc = suc+1;
    end
end
suc = suc/length(testAll);