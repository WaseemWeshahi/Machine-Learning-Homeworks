function runFaceRec()
load FaceData;
FisherFaces(trainData);
suc=recogTest(trainData, testData);
