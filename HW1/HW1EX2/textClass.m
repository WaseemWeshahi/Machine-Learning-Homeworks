function textClass
readTrainData('r8-train-stemmed.txt');
readTrainData('r8-train-stemmed.txt');
[Pw,P] = learn_NB_text();%potintioal error
suc = Classify_NB_text(Pw,P);
disp("Success rate is: " + suc*100 + "%");

