%% ����Ԥ������������еĽṹ�������С�
%% ��TreeInducedError���һ����
%% Author: Hong Zhao
%% Date: 2016-5-13
%% Example:
% tree=[0,0;1,1;1,1;2,2;2,2;2,2];
% label_test = 4;
% label_predict = 6;
% TIE1 = EvaHier_SymmetricDifferenceLoss(label_test,label_predict,tree); %ans=2
% label_test = 4;
% label_predict = 3;
% TIE2 = EvaHier_SymmetricDifferenceLoss(label_test,label_predict,tree);%ans=3
function [ TIE ] = EvaHier_SymmetricDifferenceLoss( label_test,label_predict,tree )

    TIE = 0;
    for i = 1:length(label_test)
        l1 = rda_ancestor(tree,label_test(i),1);%���һ������1�Ǵ�������Լ��������0�򲻰����Լ� 
        l2 = rda_ancestor(tree,label_predict(i),1);
        b = l1(ismember(l1,l2)==0);
        c = l2(ismember(l2,l1)==0);
        TIE = TIE + length([c,b]);
    end

end

