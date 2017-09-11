addpath('./ConfusionMatrices')  
A=[1 2 1 1 2 2 3 2 3 3 3 3 4 4 1 4];  
num=[4 4 4 4];  
name=cell(1,4);  
name{1}='haha';name{2}='hehe';name{3}='nani';name{4}='ok';  
compute_confusion_matrix(A,num,name) 