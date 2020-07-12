%% 10-fold
%% Written by Hong Zhao
% 2017-4-11
%% Input
%  data
%  numFolds
%  indices = varargin{4};
%% Output
function [accuracyMean,accuracyStd] = Kflod_TopDownClassifier(varargin)
if(length(varargin) == 3)
    data = varargin{1};
    numFolds = varargin{2};
    tree = varargin{3};
    %     indices = varargin{4};
else
    if(length(varargin)==4)
        data = [varargin{1},varargin{2}];
        numFolds = varargin{3};
        tree = varargin{4};
        %   indices = varargin{5};
    end
end
[M,N]=size(data);
rand('seed',1);
accuracy_k = zeros(1,numFolds);
nacc=cell(1,10);
totalacc=0;
indices = crossvalind('Kfold',data(1:M,N),numFolds);%//��������ְ� for k=1:10//������֤k=10��10����������Ϊ���Լ�
%     save indices10001 indices;
%     load indices1000;
for k = 1:numFolds
    testID = (indices == k);%//���test��Ԫ�������ݼ��ж�Ӧ�ĵ�Ԫ���
    trainID = ~testID;%//train��Ԫ�صı��Ϊ��testԪ�صı��
    test_data = data(testID,1:end-1);
    test_label = data(testID,end);
    train_data = data(trainID,:);
    train_label = data(trainID,end);
    train_num=tabulate(train_label);% data distribution of leaf nodes in the training set
    
    train_num=train_num(:,1:2);
    
    
   
    
    %% Creat sub table
    [trainDataMod, trainLabelMod] = creatSubTable(train_data, tree);

    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Train classifiers of all internal nodes
    numNodes = length(tree(:,1));%ZH: The total of all nodes.
    for i = 1:numNodes
      if (~ismember(i, tree_LeafNode(tree)))
            [model{i}]  = train(double(sparse(trainLabelMod{i})), sparse(sparse(trainDataMod{i})), '-c 2 -s 0 -B 1 -q');
        end
    end
    
    %%           Prediction       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %if (flag==1)
     [predict_label,pred2levelnode] = topDownPrediction(test_data,test_label, model, tree,train_num);
  %  [predict_label,pred2levelnode,pred3levelnode] = topDownPrediction(test_data,test_label, model, tree,train_num);
    %else
   %[predict_label] = topDownPredictionComputeAll(test_data,test_label, model, tree);
    %end
    %%          Envaluation       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [PH(k), RH(k), FH(k)] = EvaHier_HierarchicalPrecisionAndRecall(test_label,predict_label,tree);
    [P_LCA(k),R_LCA(k),F_LCA(k)] = EvaHier_HierarchicalLCAPrecisionAndRecall(test_label,predict_label,tree);
    TIE(k) = EvaHier_TreeInducedError(test_label,predict_label,tree);
    accuracy_k(k) = EvaHier_HierarchicalAccuracy(test_label,predict_label, tree);%����
    level2acc_k(k)= level2accuracy(test_label,pred2levelnode,tree);
  %   level3acc_k(k)= level3accuracy(test_label,pred3levelnode,tree);%�������Ĳ�ṹ
    nacc{1,k} = midacc(test_label,pred2levelnode,tree);
    totalacc=totalacc+nacc{1,k};
   
    
end
totalacc=totalacc/10;
 accuracyMean = mean(accuracy_k);
 tieMean=mean(TIE);
 accuracyStd = std(accuracy_k);
 F_LCAMean=mean(F_LCA);
 FHMean=mean(FH);
 level2accMean=mean(level2acc_k);
 % level3accMean=mean(level3acc_k);
end