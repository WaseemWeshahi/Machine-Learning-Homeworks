function [w,trainError,testError]=solveReg(X,y,train)
%% setting up train and test data
idx = 1:size(X,1);
idx=idx(randperm(length(idx)));
y = y(idx,:);
X = X(idx,:);
ytrain = y(1:train,:);
Xtrain = X(1:train,:);
ytest = y(train+1:end,:);
Xtest = X(train+1:end,:);
%% predecting w
w = Xtrain\ytrain;
predTrain = Xtrain*w;
predTest = Xtest*w;
trainError = mean((predTrain-ytrain).^2);
testError = mean((predTest-ytest).^2);



end