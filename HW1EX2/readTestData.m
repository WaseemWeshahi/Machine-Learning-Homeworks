function readTestData(fname)
%texAll cell array of documents, each row is a cell array of words.
%lbAll  cell array of documents' labels
%Voc  cell array of all distinct words in the train set
%cat  cell array of document categories
%%%%%%%%%%%% 
fid=fopen(fname,'r');
TestexAll=cell(10000,1);
TestlbAll=cell(10000,1);
TestVoc=cell(2000000,1);
i=1;
j=1;
while 1
    tline = fgetl(fid);
    if ~ischar(tline), break, end
    [lb,tex]=readText(tline);
    TestexAll{i}=tex;     
    TestlbAll(i)=lb;
    w=unique(tex);
    TestVoc(j:j+length(w)-1)=w;
    j=j+length(w);
    if(mod(i,100)==0)
     disp(i);    
    end
    i=i+1;
    
end
TestexAll=TestexAll(1:i-1);
TestlbAll=TestlbAll(1:i-1);
TestVoc=TestVoc(1:j-1);
TestVoc=unique(TestVoc);
Testcat=unique(TestlbAll);
save('corpus_test.mat', 'TestexAll','TestlbAll','TestVoc','Testcat');

fclose(fid);