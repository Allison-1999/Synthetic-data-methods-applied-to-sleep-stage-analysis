X=train_eeg'
surrogate_eeg=surrogate_iaaft_multivariate_synth_vsignal(X)
Y=train_ecg'
surrogate_ecg=surrogate_iaaft_multivariate_synth_vsignal(Y)

trainfeature=[train_eeg,train_ecg]
trainfeature_surrogate=[surrogate_eeg',surrogate_ecg']
traindata_surrogate=combine(trainfeature,trainfeature_surrogate)%��ԭ����data�ͺϳ�data����һ��
class_surrogate=combine(classtemp,classtemp)%���
traindata_surrogate=[traindata_surrogate,class_surrogate]

%%%classificationLearner
result1_3_surrogate=trainedModel_LinearSVM_38_1_surrogate.predictFcn(testdata)%subject 1; linear-svm-3
result3_3_surrogate=trainedModel_LinearSVM_38_3_surrogate.predictFcn(testdata)%subject 3; linear-svm-3

%%%������result
result3_3_surrogate_2=trainedModel_LinearSVM_38_3_surrogate_2.predictFcn(testdata)
%%%3����result
result3_3_surrogate_3=trainedModel_LinearSVM_38_3_surrogate_3.predictFcn(testdata)
%%%4����result
result3_3_surrogate_4=trainedModel_LinearSVM_38_3_surrogate_4.predictFcn(testdata)

%%% 75% 
traindata_surrogate=combine(trainfeature,trainfeature_surrogate((1:5701),:))%��ԭ����data�ͺϳ�data����һ��
class_surrogate=combine(classtemp,classtemp((1:5701),:))%���
traindata_surrogate=[traindata_surrogate,class_surrogate]

result3_3_surrogate=trainedModel_LSVM_38_3_surrogate2.predictFcn(testdata)
%%%������result
result3_3_surrogate_2=trainedModel_LinearSVM_38_3_surrogate2_2.predictFcn(testdata)
%%%3����result
result3_3_surrogate_3=trainedModel_LinearSVM_38_3_surrogate2_3.predictFcn(testdata)
%%%4����result
result3_3_surrogate_4=trainedModel_LinearSVM_38_3_surrogate2_4.predictFcn(testdata)

%%% 50% 
traindata_surrogate=combine(trainfeature,trainfeature_surrogate((1:3801),:))%��ԭ����data�ͺϳ�data����һ��
class_surrogate=combine(classtemp,classtemp((1:3801),:))%���
traindata_surrogate=[traindata_surrogate,class_surrogate]

result3_3_surrogate=trainedModel_LSVM_38_3_surrogate3.predictFcn(testdata)
%%%������result
result3_3_surrogate_2=trainedModel_LinearSVM_38_3_surrogate3_2.predictFcn(testdata)
%%%3����result
result3_3_surrogate_3=trainedModel_LinearSVM_38_3_surrogate3_3.predictFcn(testdata)
%%%4����result
result3_3_surrogate_4=trainedModel_LinearSVM_38_3_surrogate3_4.predictFcn(testdata)

%%% 25% 
traindata_surrogate=combine(trainfeature,trainfeature_surrogate((1:1900),:))%��ԭ����data�ͺϳ�data����һ��
class_surrogate=combine(classtemp,classtemp((1:1900),:))%���
traindata_surrogate=[traindata_surrogate,class_surrogate]

result3_3_surrogate=trainedModel_LSVM_38_3_surrogate4.predictFcn(testdata)
%%%������result
result3_3_surrogate_2=trainedModel_LinearSVM_38_3_surrogate4_2.predictFcn(testdata)
%%%3����result
result3_3_surrogate_3=trainedModel_LinearSVM_38_3_surrogate4_3.predictFcn(testdata)
%%%4����result
result3_3_surrogate_4=trainedModel_LinearSVM_38_3_surrogate4_4.predictFcn(testdata)

%%% 10% 
traindata_surrogate=combine(trainfeature,trainfeature_surrogate((1:760),:))%��ԭ����data�ͺϳ�data����һ��
class_surrogate=combine(classtemp,classtemp((1:760),:))%���
traindata_surrogate=[traindata_surrogate,class_surrogate]

result3_3_surrogate=trainedModel_LSVM_38_3_surrogate5.predictFcn(testdata)
%%%������result
result3_3_surrogate_2=trainedModel_LinearSVM_38_3_surrogate5_2.predictFcn(testdata)
%%%3����result
result3_3_surrogate_3=trainedModel_LinearSVM_38_3_surrogate5_3.predictFcn(testdata)
%%%4����result
result3_3_surrogate_4=trainedModel_LinearSVM_38_3_surrogate5_4.predictFcn(testdata)

%%% 5% 
traindata_surrogate=combine(trainfeature,trainfeature_surrogate((1:380),:))%��ԭ����data�ͺϳ�data����һ��
class_surrogate=combine(classtemp,classtemp((1:380),:))%���
traindata_surrogate=[traindata_surrogate,class_surrogate]
result3_3_surrogate=trainedModel_LSVM_38_3_surrogate6.predictFcn(testdata)
%%%������result
result3_3_surrogate_2=trainedModel_LinearSVM_38_3_surrogate6_2.predictFcn(testdata)
%%%3����result
result3_3_surrogate_3=trainedModel_LinearSVM_38_3_surrogate6_3.predictFcn(testdata)
%%%4����result
result3_3_surrogate_4=trainedModel_LinearSVM_38_3_surrogate6_4.predictFcn(testdata)

%%% 1% 
traindata_surrogate=combine(trainfeature,trainfeature_surrogate((1:76),:))%��ԭ����data�ͺϳ�data����һ��
class_surrogate=combine(classtemp,classtemp((1:76),:))%���
traindata_surrogate=[traindata_surrogate,class_surrogate]
result3_3_surrogate=trainedModel_LSVM_38_3_surrogate7.predictFcn(testdata)
%%%������result
result3_3_surrogate_2=trainedModel_LinearSVM_38_3_surrogate7_2.predictFcn(testdata)
%%%3����result
result3_3_surrogate_3=trainedModel_LinearSVM_38_3_surrogate7_3.predictFcn(testdata)
%%%4����result
result3_3_surrogate_4=trainedModel_LinearSVM_38_3_surrogate7_4.predictFcn(testdata)

%%% 15% 
traindata_surrogate=combine(trainfeature,trainfeature_surrogate((1:1140),:))%��ԭ����data�ͺϳ�data����һ��
class_surrogate=combine(classtemp,classtemp((1:1140),:))%���
traindata_surrogate=[traindata_surrogate,class_surrogate]
result3_3_surrogate=trainedModel_LSVM_38_3_surrogate8.predictFcn(testdata)
%%%������result
result3_3_surrogate_2=trainedModel_LinearSVM_38_3_surrogate8_2.predictFcn(testdata)
%%%3����result
result3_3_surrogate_3=trainedModel_LinearSVM_38_3_surrogate8_3.predictFcn(testdata)
%%%4����result
result3_3_surrogate_4=trainedModel_LinearSVM_38_3_surrogate8_4.predictFcn(testdata)