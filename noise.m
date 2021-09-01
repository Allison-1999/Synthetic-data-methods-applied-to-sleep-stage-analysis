trainfeature=[train_eeg,train_ecg]
trainfeature_noise=imnoise(trainfeature,'gaussian',0.1,0.002)
%%%%100% 7602条数据
traindata_noise=combine(trainfeature,trainfeature_noise)
class_noise=combine(classtemp,classtemp)
traindata_noise=[traindata_noise,class_noise]
%testdata_noise=imnoise(testdata,'gaussian',0.1,0.002)
result3_3_noise=trainedModel_LinearSVM_38_3_noise.predictFcn(testdata)
%%%二分类
result3_3_noise_2=trainedModel_LinearSVM_38_3_noise_2.predictFcn(testdata)
%%%3分类
result3_3_noise_3=trainedModel_LinearSVM_38_3_noise_3.predictFcn(testdata)
%%%4分类
result3_3_noise_4=trainedModel_LinearSVM_38_3_noise_4.predictFcn(testdata)

%%% 75% 5701条数据
%%%test=trainfeature_noise((1:5701),:)
traindata_noise=combine(trainfeature,trainfeature_noise((1:5701),:))
class_noise=combine(classtemp,classtemp((1:5701),:))
traindata_noise=[traindata_noise,class_noise]

result3_3_noise=trainedModel_LSVM_38_3_noise2.predictFcn(testdata)
%%%二分类
result3_3_noise_2=trainedModel_LinearSVM_38_3_noise2_2.predictFcn(testdata)
%%%3分类
result3_3_noise_3=trainedModel_LinearSVM_38_3_noise2_3.predictFcn(testdata)
%%%4分类
result3_3_noise_4=trainedModel_LinearSVM_38_3_noise2_4.predictFcn(testdata)

%%% 50% 3801条数据
%%%test=trainfeature_noise((1:5701),:)
traindata_noise=combine(trainfeature,trainfeature_noise((1:3801),:))
class_noise=combine(classtemp,classtemp((1:3801),:))
traindata_noise=[traindata_noise,class_noise]

result3_3_noise=trainedModel_LSVM_38_3_noise3.predictFcn(testdata)
%%%二分类
result3_3_noise_2=trainedModel_LinearSVM_38_3_noise3_2.predictFcn(testdata)
%%%3分类
result3_3_noise_3=trainedModel_LinearSVM_38_3_noise3_3.predictFcn(testdata)
%%%4分类
result3_3_noise_4=trainedModel_LinearSVM_38_3_noise3_4.predictFcn(testdata)

%%% 25% 1900
traindata_noise=combine(trainfeature,trainfeature_noise((1:1900),:))
class_noise=combine(classtemp,classtemp((1:1900),:))
traindata_noise=[traindata_noise,class_noise]

result3_3_noise=trainedModel_LSVM_38_3_noise4.predictFcn(testdata)
%%%二分类
result3_3_noise_2=trainedModel_LinearSVM_38_3_noise4_2.predictFcn(testdata)
%%%3分类
result3_3_noise_3=trainedModel_LinearSVM_38_3_noise4_3.predictFcn(testdata)
%%%4分类
result3_3_noise_4=trainedModel_LinearSVM_38_3_noise4_4.predictFcn(testdata)

%% 10% 760
traindata_noise=combine(trainfeature,trainfeature_noise((1:760),:))
class_noise=combine(classtemp,classtemp((1:760),:))
traindata_noise=[traindata_noise,class_noise]

result3_3_noise=trainedModel_LSVM_38_3_noise5.predictFcn(testdata)
%%%二分类
result3_3_noise_2=trainedModel_LinearSVM_38_3_noise5_2.predictFcn(testdata)
%%%3分类
result3_3_noise_3=trainedModel_LinearSVM_38_3_noise5_3.predictFcn(testdata)
%%%4分类
result3_3_noise_4=trainedModel_LinearSVM_38_3_noise5_4.predictFcn(testdata)

% 5% 380
traindata_noise=combine(trainfeature,trainfeature_noise((1:380),:))
class_noise=combine(classtemp,classtemp((1:380),:))
traindata_noise=[traindata_noise,class_noise]

result3_3_noise=trainedModel_LSVM_38_3_noise6.predictFcn(testdata)
%%%二分类
result3_3_noise_2=trainedModel_LinearSVM_38_3_noise6_2.predictFcn(testdata)
%%%3分类
result3_3_noise_3=trainedModel_LinearSVM_38_3_noise6_3.predictFcn(testdata)
%%%4分类
result3_3_noise_4=trainedModel_LinearSVM_38_3_noise6_4.predictFcn(testdata)

%%% 1% 76
traindata_noise=combine(trainfeature,trainfeature_noise((1:76),:))
class_noise=combine(classtemp,classtemp((1:76),:))
traindata_noise=[traindata_noise,class_noise]

result3_3_noise=trainedModel_LSVM_38_3_noise7.predictFcn(testdata)
%%%二分类
result3_3_noise_2=trainedModel_LinearSVM_38_3_noise7_2.predictFcn(testdata)
%%%3分类
result3_3_noise_3=trainedModel_LinearSVM_38_3_noise7_3.predictFcn(testdata)
%%%4分类
result3_3_noise_4=trainedModel_LinearSVM_38_3_noise7_4.predictFcn(testdata)

%%%%15% 1140条数据
traindata_noise=combine(trainfeature,trainfeature_noise((1:1140),:))
class_noise=combine(classtemp,classtemp((1:1140),:))
traindata_noise=[traindata_noise,class_noise]

result3_3_noise=trainedModel_LSVM_38_3_noise8.predictFcn(testdata)
%%%二分类
result3_3_noise_2=trainedModel_LinearSVM_38_3_noise8_2.predictFcn(testdata)
%%%3分类
result3_3_noise_3=trainedModel_LinearSVM_38_3_noise8_3.predictFcn(testdata)
%%%4分类
result3_3_noise_4=trainedModel_LinearSVM_38_3_noise8_4.predictFcn(testdata)