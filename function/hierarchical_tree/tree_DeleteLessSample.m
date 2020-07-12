%% 删除类别个数较少的类别
clear;
clc;
load zh5000;
%    load tree;
   [m,n]=size(data_array);
   leaf = LeafNode(tree);
   X = data_array(:,1:n-1);
   y = data_array(:,n);
   i=0;
   while length(leaf)~=0 
       label=find(y==leaf(1));
     
    if(length(label)>0 & length(label)<10)%少于10个
        y(label)=[];   
        X(label,:)=[];
        i=i+1;
        
    end
    leaf(1)=[];
   end

   
