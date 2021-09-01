eeg_dataset=zscore(features_eeg)
ecg_dataset=zscore(features_ecg)
%subject 1
train_eeg=eeg_dataset((750:8415),:)
train_ecg=ecg_dataset((750:8415),:)

classtemp=[classes_sub{2},classes_sub{3},classes_sub{4},classes_sub{5},classes_sub{6},classes_sub{7},classes_sub{8},classes_sub{9},classes_sub{10}]
classtemp=reshape(classtemp,[7666,1])
traindata=[train_eeg,train_ecg,classtemp]

testdata_eeg=eeg_dataset((1:749),:)
testdata_ecg=ecg_dataset((1:749),:)
testdata=[testdata_eeg,testdata_ecg]

testclass=classes_sub{1}
testclass=reshape(testclass,749,1)

classificationLearner
 
result=trainedModel_LDA_38_1.predictFcn(testdata)
result=trainedModel_QDA_38_1.predictFcn(testdata)
result=trainedModel_LSVM_38_1.predictFcn(testdata)
result=trainedModel_QSVM_38_1.predictFcn(testdata)
%Ԥ����result-linear result2-quad result3-linearSVM result4-quadSVM

%subject2��Ϊ����
temp=eeg_dataset((1:749),:)
temp2=eeg_dataset((1632:8415),:)
train_eeg=combine(temp,temp2)%eegѵ����

temp=ecg_dataset((1:749),:)
temp2=ecg_dataset((1632:8415),:)
train_ecg=combine(temp,temp2)

classtemp=[classes_sub{1},classes_sub{3},classes_sub{4},classes_sub{5},classes_sub{6},classes_sub{7},classes_sub{8},classes_sub{9},classes_sub{10}]
classtemp=reshape(classtemp,[7533,1])%1-7666 2-7533
traindata=[train_eeg,train_ecg,classtemp]

testdata_eeg=eeg_dataset((750:1631),:)
testdata_ecg=ecg_dataset((750:1631),:)
testdata=[testdata_eeg,testdata_ecg]

testclass=classes_sub{2}
testclass=reshape(testclass,882,1)%1-749,2-882

classificationLearner
 
result=trainedModel_LDA_38_2.predictFcn(testdata)
result=trainedModel_QDA_38_2.predictFcn(testdata)
result=trainedModel_LSVM_38_2.predictFcn(testdata)
result=trainedModel_QSVM_38_2.predictFcn(testdata)

%subject3��Ϊ����
temp=eeg_dataset((1:1631),:)
temp2=eeg_dataset((2445:8415),:)
train_eeg=combine(temp,temp2)%eegѵ����

temp=ecg_dataset((1:1631),:)
temp2=ecg_dataset((2445:8415),:)
train_ecg=combine(temp,temp2)

classtemp=[classes_sub{1},classes_sub{2},classes_sub{4},classes_sub{5},classes_sub{6},classes_sub{7},classes_sub{8},classes_sub{9},classes_sub{10}]
classtemp=reshape(classtemp,[7602,1])%1-7666 2-7533 3-7602
traindata=[train_eeg,train_ecg,classtemp] %���úϳ����ݵ�

testdata_eeg=eeg_dataset((1632:2444),:)
testdata_ecg=ecg_dataset((1632:2444),:)
testdata=[testdata_eeg,testdata_ecg]

testclass=classes_sub{3}
testclass=reshape(testclass,813,1)%1-749,2-882��3-813

classificationLearner
%%%����
result3_3=trainedModel_LinearSVM_38_3.predictFcn(testdata)
result3_3_2=trainedModel_LinearSVM_38_3_2.predictFcn(testdata)%%%subject 3 lsvm ������
result3_3_3=trainedModel_LinearSVM_38_3_3.predictFcn(testdata)%%%subject 3 lsvm 3����
result3_3_4=trainedModel_LinearSVM_38_3_4.predictFcn(testdata)%%%subject 3 lsvm 4����
%%����
result=trainedModel_LDA_38_3.predictFcn(testdata)
result=trainedModel_QDA_38_3.predictFcn(testdata)
result=trainedModel_LSVM_38_3.predictFcn(testdata)
result=trainedModel_QSVM_38_3.predictFcn(testdata)

%subject4��Ϊ����
temp=eeg_dataset((1:2444),:) %2245-3369
temp2=eeg_dataset((3370:8415),:)
train_eeg=combine(temp,temp2)%eegѵ����

temp=ecg_dataset((1:2444),:)
temp2=ecg_dataset((3370:8415),:)
train_ecg=combine(temp,temp2)

classtemp=[classes_sub{1},classes_sub{2},classes_sub{3},classes_sub{5},classes_sub{6},classes_sub{7},classes_sub{8},classes_sub{9},classes_sub{10}]
classtemp=reshape(classtemp,[7490,1])%1-7666 2-7533 3-7602 4-7490
traindata=[train_eeg,train_ecg,classtemp]

testdata_eeg=eeg_dataset((2245:3369),:)
testdata_ecg=ecg_dataset((2245:3369),:)
testdata=[testdata_eeg,testdata_ecg]

testclass=classes_sub{4}
testclass=reshape(testclass,925,1)%1-749,2-882,3-813,4-925

classificationLearner
 
result=trainedModel_LDA_38_4.predictFcn(testdata)
result=trainedModel_QDA_38_4.predictFcn(testdata)
result=trainedModel_LSVM_38_4.predictFcn(testdata)
result=trainedModel_QSVM_38_4.predictFcn(testdata)

%subject5��Ϊ����
temp=eeg_dataset((1:3369),:) %3370-4276
temp2=eeg_dataset((4277:8415),:)
train_eeg=combine(temp,temp2)%eegѵ����

temp=ecg_dataset((1:3369),:)
temp2=ecg_dataset((4277:8415),:)
train_ecg=combine(temp,temp2)

classtemp=[classes_sub{1},classes_sub{2},classes_sub{3},classes_sub{4},classes_sub{6},classes_sub{7},classes_sub{8},classes_sub{9},classes_sub{10}]
classtemp=reshape(classtemp,[7508,1])% 5-7508
traindata=[train_eeg,train_ecg,classtemp]

testdata_eeg=eeg_dataset((3370:4276),:)
testdata_ecg=ecg_dataset((3370:4276),:)
testdata=[testdata_eeg,testdata_ecg]

testclass=classes_sub{5}
testclass=reshape(testclass,907,1)%5-907

classificationLearner
 
result=trainedModel_LDA_38_5.predictFcn(testdata)
result=trainedModel_QDA_38_5.predictFcn(testdata)
result=trainedModel_LSVM_38_5.predictFcn(testdata)
result=trainedModel_QSVM_38_5.predictFcn(testdata)

%subject6��Ϊ����
temp=eeg_dataset((1:4276),:) %4277-5177
temp2=eeg_dataset((5178:8415),:)
train_eeg=combine(temp,temp2)%eegѵ����

temp=ecg_dataset((1:4276),:)
temp2=ecg_dataset((5178:8415),:)
train_ecg=combine(temp,temp2)

classtemp=[classes_sub{1},classes_sub{2},classes_sub{3},classes_sub{4},classes_sub{5},classes_sub{7},classes_sub{8},classes_sub{9},classes_sub{10}]
classtemp=reshape(classtemp,[7514,1])% 6-7514
traindata=[train_eeg,train_ecg,classtemp]

testdata_eeg=eeg_dataset((4277:5177),:)
testdata_ecg=ecg_dataset((4277:5177),:)
testdata=[testdata_eeg,testdata_ecg]

testclass=classes_sub{6}
testclass=reshape(testclass,901,1)%6-901

classificationLearner
 
result=trainedModel_LDA_38_6.predictFcn(testdata)
result=trainedModel_QDA_38_6.predictFcn(testdata)
result=trainedModel_LSVM_38_6.predictFcn(testdata)
result=trainedModel_QSVM_38_6.predictFcn(testdata)

%subject7��Ϊ����
temp=eeg_dataset((1:5177),:) %5178-6041
temp2=eeg_dataset((6042:8415),:)
train_eeg=combine(temp,temp2)%eegѵ����

temp=ecg_dataset((1:5177),:)
temp2=ecg_dataset((6042:8415),:)
train_ecg=combine(temp,temp2)

classtemp=[classes_sub{1},classes_sub{2},classes_sub{3},classes_sub{4},classes_sub{5},classes_sub{6},classes_sub{8},classes_sub{9},classes_sub{10}]
classtemp=reshape(classtemp,[7551,1])% 7-7551
traindata=[train_eeg,train_ecg,classtemp]

testdata_eeg=eeg_dataset((5178:6041),:)
testdata_ecg=ecg_dataset((5178:6041),:)
testdata=[testdata_eeg,testdata_ecg]

testclass=classes_sub{7}
testclass=reshape(testclass,864,1)%7-864

classificationLearner
 
result=trainedModel_LDA_38_7.predictFcn(testdata)
result=trainedModel_QDA_38_7.predictFcn(testdata)
result=trainedModel_LSVM_38_7.predictFcn(testdata)
result=trainedModel_QSVM_38_7.predictFcn(testdata)

%subject8��Ϊ����
temp=eeg_dataset((1:6041),:) %6042-6852
temp2=eeg_dataset((6853:8415),:)
train_eeg=combine(temp,temp2)%eegѵ����

temp=ecg_dataset((1:6041),:)
temp2=ecg_dataset((6853:8415),:)
train_ecg=combine(temp,temp2)

classtemp=[classes_sub{1},classes_sub{2},classes_sub{3},classes_sub{4},classes_sub{5},classes_sub{6},classes_sub{7},classes_sub{9},classes_sub{10}]
classtemp=reshape(classtemp,[7604,1])% 8-7604
traindata=[train_eeg,train_ecg,classtemp]

testdata_eeg=eeg_dataset((6042:6852),:)
testdata_ecg=ecg_dataset((6042:6852),:)
testdata=[testdata_eeg,testdata_ecg]

testclass=classes_sub{8}
testclass=reshape(testclass,811,1)%8-811

classificationLearner
 
result=trainedModel_LDA_38_8.predictFcn(testdata)
result=trainedModel_QDA_38_8.predictFcn(testdata)
result=trainedModel_LSVM_38_8.predictFcn(testdata)
result=trainedModel_QSVM_38_8.predictFcn(testdata)

%subject9��Ϊ����
temp=eeg_dataset((1:6852),:) %6853-7626
temp2=eeg_dataset((7627:8415),:)
train_eeg=combine(temp,temp2)%eegѵ����

temp=ecg_dataset((1:6852),:)
temp2=ecg_dataset((7627:8415),:)
train_ecg=combine(temp,temp2)

classtemp=[classes_sub{1},classes_sub{2},classes_sub{3},classes_sub{4},classes_sub{5},classes_sub{6},classes_sub{7},classes_sub{8},classes_sub{10}]
classtemp=reshape(classtemp,[7641,1])% 9-7641
traindata=[train_eeg,train_ecg,classtemp]

testdata_eeg=eeg_dataset((6853:7626),:)
testdata_ecg=ecg_dataset((6853:7626),:)
testdata=[testdata_eeg,testdata_ecg]

testclass=classes_sub{9}
testclass=reshape(testclass,774,1)%9-774

classificationLearner
 
result=trainedModel_LDA_38_9.predictFcn(testdata)
result=trainedModel_QDA_38_9.predictFcn(testdata)
result=trainedModel_LSVM_38_9.predictFcn(testdata)
result=trainedModel_QSVM_38_9.predictFcn(testdata)

%subject10��Ϊ����
train_eeg=eeg_dataset((1:7626),:) %7627-8415
train_ecg=ecg_dataset((1:7626),:)

classtemp=[classes_sub{1},classes_sub{2},classes_sub{3},classes_sub{4},classes_sub{5},classes_sub{6},classes_sub{7},classes_sub{8},classes_sub{9}]
classtemp=reshape(classtemp,[7626,1])%10-7626
traindata=[train_eeg,train_ecg,classtemp]

testdata_eeg=eeg_dataset((7627:8415),:)
testdata_ecg=ecg_dataset((7627:8415),:)
testdata=[testdata_eeg,testdata_ecg]

testclass=classes_sub{10}
testclass=reshape(testclass,789,1)%10-789

classificationLearner
 
result=trainedModel_LDA_38_10.predictFcn(testdata)
result=trainedModel_QDA_38_10.predictFcn(testdata)
result=trainedModel_LSVM_38_10.predictFcn(testdata)
result=trainedModel_QSVM_38_10.predictFcn(testdata)


%%%%������0:class0 1-5:class1
for i=1:7602 %1-7666 2-7533 3-7602
    if classtemp(i)==0 %�Ƚ����
        classtemp(i)=0;
    else
        classtemp(i)=1;
    end
end

for i=1:813 %sub1-749 sub2-882 sub3-813
    if testclass(i)==0
        testclass(i)=0;
    else
        testclass(i)=1;
    end
end


%%%%3���� 0,1,2-3-4-5 Three classes
for i=1:7602 %1-7666 2-7533 3-7602
    if classtemp(i)==0 %�Ƚ����
        classtemp(i)=0;
    elseif classtemp(i)==1
        classtemp(i)=1;
    else
        classtemp(i)=2;
    end
end

for i=1:813 %sub1-749 sub2-882 sub3-813
    if testclass(i)==0 %�Ƚ����
        testclass(i)=0;
    elseif testclass(i)==1
        testclass(i)=1;
    else
        testclass(i)=2;
    end
end

%%%%4���� 0,1,2-3,4-5 Four classes
for i=1:7602 %1-7666 2-7533 3-7602
    if classtemp(i)==0 %�Ƚ����
        classtemp(i)=0;
    elseif classtemp(i)==1
        classtemp(i)=1;
    elseif classtemp(i)==2||classtemp(i)==3
        classtemp(i)=2;
    else
        classtemp(i)=3;
    end
end

for i=1:813 %sub1-749 sub2-882 sub3-813
    if testclass(i)==0 %�Ƚ����
        testclass(i)=0;
    elseif testclass(i)==1
        testclass(i)=1;
    elseif testclass(i)==2||testclass(i)==3
        testclass(i)=2;
    else
        testclass(i)=3;
    end
end
