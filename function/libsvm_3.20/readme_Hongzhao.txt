����mat��ʽ

data_label��ѵ�������ݼ��ľ�������
data_inst��ѵ�������ݼ�����������ֵ��

model = svmtrain(data_label,data_inst, '-c 1 -g 0.07');


testdata_label�ǲ��Լ����ݼ��ľ�������
teatdata_inst�ǲ��Լ����ݼ�����������ֵ
[predict_label, accuracy, dec_values] =svmpredict(testdata_label,teatdata_inst, model); % test the trainingdata