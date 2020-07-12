function level2acc = level2accuracy(test_label,pred2levelnode,tree)
num_examples = max(size(test_label,1),size(test_label,2));
num_rights = 0;
treelabel=tree(:,1);
treeheight=max(tree(:,2));
if(treeheight==3)
    for i = 1:num_examples
        real3levelnode(i)=treelabel(test_label(i));
        real2levelnode(i)=treelabel(real3levelnode(i));
        if(pred2levelnode(i)==real2levelnode(i));
            num_rights = num_rights + 1;
        end
    end

else
    for i = 1:num_examples
         real2levelnode(i)=treelabel(test_label(i));
         if(pred2levelnode(i)==real2levelnode(i));
            num_rights = num_rights + 1;
         end
    end    
end
level2acc = num_rights / num_examples;
end



