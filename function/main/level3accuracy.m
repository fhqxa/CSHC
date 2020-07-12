function level3acc = level3accuracy(test_label,pred3levelnode,tree)
num_examples = max(size(test_label,1),size(test_label,2));
num_rights = 0;
treelabel=tree(:,1);

for i = 1:num_examples
        real3levelnode(i)=treelabel(test_label(i));
        
        if(pred3levelnode(i)==real3levelnode(i));
            num_rights = num_rights + 1;
        end
end
level3acc = num_rights / num_examples;
end
