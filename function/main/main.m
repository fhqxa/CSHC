clear;clc;
%           load DD;   %%%%3625*474  3��
%    load ILSVRC57Test;   %%%%11845*4097   4��  8661  9634  9312 9980 9896
%    load Protein194;   %%%%8525*474   3��
%  load Car196Test;   %%%%7541*4097   3��  6874 8348 8132 8169
 load Sun324Test;   %%%%22556*4097   4��

a=data_array(:,end)
b=tabulate(a);
c=b(:,3);
sum(c(25:27))
numFolds = 10;



tic
[accuracyMean,FHMean] = Kflod_TopDownClassifier(data_array,numFolds,tree);
t=toc;