clear;
clc;
load zh100tree
% load SAIAPR
load tree;
r=0;
s=0.2;
%zh100tree�а���������
%1. tree�������Ե����ṹ
%2. data_array������������+�������ԣ����һ���Ǿ������ԣ�
treeParent = tree(:,1)';%�������
treeLevel = tree(:,2)';%������в��
clear tree;
[m,n] = size(data_array);
treeHeight = max(treeLevel); %���ĸ߶�
%�ж��ǲ���Ҷ�ӽ��
% leaf = treeLevel(data_array(:,n))==treeHeight

x=treeParent(data_array(:,n))==treeParent(data_array(1,n));
for i=2:2
% %        label_diff=find(data_array(:,n)~=data_array(i,n));%zh2015-12-12�ҵ���ǰ�������������о��߲�ͬ�����ҵ�������������
%        % ֻ���ֵ�������Ϊ����������Ч�����ã����ݼ���СΪ500���󲻳������
%        % �󲻳����������Ϊ���Լ�Ҳ���������ˣ��ֵܽ��Ӧ���ǳ����Լ���ͬ���׽��

        label_diff=find(treeParent(data_array(:,n))==treeParent(data_array(i,n)));
 Locate=find(label_diff(:)==i)%    % �󲻳����������Ϊ���Լ�Ҳ���������ˣ��ֵܽ��Ӧ���ǳ����Լ���ͬ���׽��
        label_diff(Locate)=[];%ɾ��ͬ��ǵļ�¼
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
%          label_diff=find(data_array(:,n)~=data_array(i,n));%zh2015-12-12�ҵ���ǰ�������������о��߲�ͬ�����ҵ�������������
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
        
        
        
        
        