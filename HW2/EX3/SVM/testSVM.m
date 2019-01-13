function acc=testSVM(models, X,Y)
% Function for testing SVM.
% X is nxd matrix, where n is the number of tested samples and d is the dimension of the features vectors.
% Y is nx1 vector, containing the true labels. Use it to compute the accuracy.
% models is an array of model structes for the 10 classes obtained from running SVM training (using LIBSVM).
% acc is the tested accuracy rate: (the number of times the predicted label is equal to the true label devided by the number of tested points.)
%Implement the function here. Note that the multi-class classification should be implemented in one-against-all manner.