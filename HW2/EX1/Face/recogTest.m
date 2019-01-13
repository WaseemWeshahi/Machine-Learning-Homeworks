function suc=recogTest(trainData, testData)
% trainData is a Nxd matrix of training data for N=100 images (2 per person). d is the dimension of the features, representing an image.
% testData testData is a nxd matrix of test data for n=50 images (1 per person). d is the dimension of the features, representing an image.
load FisherSpace.mat;

%suc is the number of correct classifications (when the index of the test image is equal to the predicted index)
suc=suc/size(testData,1);
fprintf('The recognition rate is %2.2f\n',suc);