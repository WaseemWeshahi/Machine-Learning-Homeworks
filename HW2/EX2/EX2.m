data = matfile('regdata.mat');
d = data.R;
X = d;
y = d(:,1);  % the mpgs
X(:,1)=1; % the data
tr = [10,50,100,200];
teser = zeros(size(tr));
trer = teser;
for i=1:length(tr)
    [~,trer(i),teser(i)] = solveReg(X,y,tr(i));
end
figure
plot(tr,[teser;trer]);
legend('Test Error','Train Error');
xlabel('Number of training data used');
ylabel('Error');