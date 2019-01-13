function runSVM 
   rng('default');     
   load mnist_svm;

   % extract 
   tr = ones(1, size(trainX,1));
   tr(1:5:size(trainX,1)) = 0;
   tr = logical(tr);
   trX = trainX( tr,:); trY = trainY( tr); %training set that you use for training and cross validation
   deX = trainX(~tr,:); deY = trainY(~tr); %test set

   allC = [1 5];
   allG = [0.005 0.01 0.05];
   numFolds=5;
  % For each class learn models for this class in one-against-all manner 
  
  % train linear SVM and use 5-fold cross-validation to find the best C parameter
  % from allC.  
  [models,cv_acc]=trainLinearSVM(trX,trY,numFolds,allC);
  fprintf('Cross-validation accuracy is %2.2f\n',cv_acc);
  mypause();
  %test linear SVM for each class in one-against-all manner and report the
  %accuracy rate for each class
  acc=testSVM(models, deX,deY);
  fprintf('Test accuracy is %2.2f\n',acc);
  mypause();
  %train kernel SVM with RBF kernel and cross-validation to find the best
  %C and G parameters from allC and allG.
  [models,cv_acc]=trainRBFSVM(trX,trY,numFolds, allC,allG);
  fprintf('Cross-validation accuracy of RBF SVM is %2.2f\n',cv_acc);
  mypause();
  
  %test kernel SVM for each class in one-against-all manner and report the
  %accuracy rate for each class
  acc=testSVM(models, deX,deY);
  fprintf('Test accuracy of RBF SVM is %2.2f\n',acc);
  fprintf('ALL DONE\n');
end  