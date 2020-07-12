%% 删除所有非叶子结点
%
clear;
clc;
load('data3_SAIAPR.mat');
middleNode = NoLeafNode(tree);
[m,n] = size(data_array);
lengMiddleNode = length(middleNode);
for i=1:lengMiddleNode
     label=find(data_array(:,n)==middleNode(i));     
     data_array(label,:)=[];   
end