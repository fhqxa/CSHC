读入mat格式

data_label是训练集数据集的决策属性
data_inst是训练集数据集的条件属性值。

model = svmtrain(data_label,data_inst, '-c 1 -g 0.07');


testdata_label是测试集数据集的决策属性
teatdata_inst是测试集数据集的条件属性值
[predict_label, accuracy, dec_values] =svmpredict(testdata_label,teatdata_inst, model); % test the trainingdata