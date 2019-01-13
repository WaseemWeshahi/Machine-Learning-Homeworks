function [models,cv_acc]=trainLinearSVM(X,Y,K, allC)
%Train linear SVM and use K-fold cross validation to find the best parameter (one for all classes)  from allC
% X is Nxd matrix of  training data, N is the number of items, d is the size of the feature vector
% Y is Nx1 vector of labels from 0 to 9 (meaning that there are 10 classes).
%K is the number of folds in cross validation.
% models is the array of model structes for the 10 classes obtained from running linear SVM training (using LIBSVM)
% cv_acc is the cross-validation accuracy rate (number of times the predicted label is equal to the true label devided by the number of validation points.)
% The rate should be averaged over K folds. 
%Implement your code here. Note that the multi-class classifiers should be trained in one-against-all manner.