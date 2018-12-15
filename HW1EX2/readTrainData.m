function readTrainData(fname)
%texAll cell array of documents, each row is a cell array of words.
%lbAll  cell array of documents' labels
%Voc  cell array of all distinct words in the train set
%cat  cell array of document categories
%%%%%%%%%%%% 
fid=fopen(fname,'r');
texAll=cell(10000,1);
lbAll=cell(10000,1);
Voc=cell(2000000,1);
i=1;
j=1;
while 1
    tline = fgetl(fid);
    if ~ischar(tline), break, end
    [lb,tex]=readText(tline);
    texAll{i}=tex;     
    lbAll(i)=lb;
    w=unique(tex);
    Voc(j:j+length(w)-1)=w;
    j=j+length(w);
    if(mod(i,100)==0)
     disp(i);    
    end
    i=i+1;
    
end
texAll=texAll(1:i-1);
lbAll=lbAll(1:i-1);
Voc=Voc(1:j-1);
Voc=unique(Voc);
cat=unique(lbAll);
save('corpus_train.mat', 'texAll','lbAll','Voc','cat');

fclose(fid);