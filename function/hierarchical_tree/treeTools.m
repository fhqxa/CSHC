clear;
clc;
load zh100tree
% load SAIAPR
load tree;
r=0;
s=0.2;
%zh100tree中包括两部分
%1. tree决策属性的树结构
%2. data_array数据条件属性+决策属性（最后一列是决策属性）
treeParent = tree(:,1)';%父结点编号
treeLevel = tree(:,2)';%结点所有层次
clear tree;
[m,n] = size(data_array);
treeHeight = max(treeLevel); %树的高度
%判断是不是叶子结点
% leaf = treeLevel(data_array(:,n))==treeHeight

x=treeParent(data_array(:,n))==treeParent(data_array(1,n));
for i=2:2
% %        label_diff=find(data_array(:,n)~=data_array(i,n));%zh2015-12-12找到当前行与其它所有行决策不同，即找到所有异类样本
%        % 只把兄弟样本做为异类样本，效果不好，数据集大小为500的求不出结果。
%        % 求不出结果，是因为把自己也放在里面了，兄弟结点应该是除了自己的同父亲结点

        label_diff=find(treeParent(data_array(:,n))==treeParent(data_array(i,n)));
 Locate=find(label_diff(:)==i)%    % 求不出结果，是因为把自己也放在里面了，兄弟结点应该是除了自己的同父亲结点
        label_diff(Locate)=[];%删除同标记的记录
        label_diff=label_diff';
        array_diff=data_array(label_diff,1:n-1);

        [p,q]=size(array_diff);
        for j=1:p;
 %          array_diff(j,:)=min(array_diff(j,:)-data_array(i,1:n-1),1);%%%%%%%%%% for  nominal attributes
           array_diff1(j,:)=min(abs(array_diff(j,:)-data_array(i,1:n-1)),1);% Revised by Hong Zhao in 2015-12-15
        end        
         array_diff2=array_diff1.^2;
        [value_nearest,label_nearest]=min(sum(array_diff2,2));
         r=r+sqrt(1-(exp(-value_nearest/2/s))^2)/m
end
         %%%%%%%%%%%%%%%%%%%%%%%%%
%  r1=0;
% for i=1:100
%          label_diff=find(data_array(:,n)~=data_array(i,n));%zh2015-12-12找到当前行与其它所有行决策不同，即找到所有异类样本
%    label_diffb= label_diff;
%    array_diff=data_array(label_diff,1:n-1);
%         [p,q]=size(array_diff);
%         for j=1:p;
%  %          array_diff(j,:)=min(array_diff(j,:)-data_array(i,1:n-1),1);%%%%%%%%%% for  nominal attributes
%            array_diff(j,:)=min(abs(array_diff(j,:)-data_array(i,1:n-1)),1);% Revised by Hong Zhao in 2015-12-15
%         end        
%          array_diff=array_diff.^2;
%         [value_nearest,label_nearest]=min(sum(array_diff,2));
%          r1=r1+sqrt(1-(exp(-value_nearest/2/s))^2)/m
% % %     
% end;
%         
        
        
        
        
        