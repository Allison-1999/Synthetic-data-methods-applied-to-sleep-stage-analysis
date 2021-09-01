%%%% subject3 noise
correct=0;
false=0;
for i=1:813 %sub1-749 sub2-882 sub3-813
    if result3_3_noise(i)==testclass(i)%比较预测结果和正确结果
        correct=correct+1;
    else
        false=false+1;
    end
end
acc3_3_noise=correct/813;%sub1-749 sub2-882 sub3-813
        
confusionmat(result3_3_noise,testclass)       

plot(result3_3_noise,'r')
hold on
plot(testclass,'g')

%%%%% subject1 surrogate
correct=0;
false=0;
for i=1:749 %sub1-749 sub2-882 sub3-813
    if result1_3_surrogate(i)==testclass(i)%比较预测结果和正确结果
        correct=correct+1;
    else
        false=false+1;
    end
end
acc1_3_surrogate=correct/749;%sub1-749 sub2-882 sub3-813
        
confusionmat(result1_3_surrogate,testclass)       

plot(result1_3_surrogate,'r')
hold on
plot(testclass,'g')

%%%%%% subject 3 lsvm surrogate
correct=0;
false=0;
for i=1:813 %sub1-749 sub2-882 sub3-813
    if result3_3_surrogate(i)==testclass(i)%比较预测结果和正确结果
        correct=correct+1;
    else
        false=false+1;
    end
end
acc3_3_surrogate=correct/813;%sub1-749 sub2-882 sub3-813
        
confusionmat(result3_3_surrogate,testclass)       

plot(result3_3_surrogate,'r')
hold on
plot(testclass,'g')

%%%  2分类 subject 3 lsvm surrogate
correct=0;
false=0;
for i=1:813 %sub1-749 sub2-882 sub3-813
    if result3_3_surrogate_2(i)==testclass(i)%比较预测结果和正确结果
        correct=correct+1;
    else
        false=false+1;
    end
end
acc3_3_surrogate_2=correct/813;%sub1-749 sub2-882 sub3-813
        
confusionmat(result3_3_surrogate_2,testclass)       

plot(result3_3_surrogate_2,'r')
hold on
plot(testclass,'g')
xlabel('epoch')
ylabel('stage')
%%%  2分类 subject 3 lsvm 无合成数据
correct=0;
false=0;
for i=1:813 %sub1-749 sub2-882 sub3-813
    if result3_3_2(i)==testclass(i)%比较预测结果和正确结果
        correct=correct+1;
    else
        false=false+1;
    end
end
acc3_3_2=correct/813;%sub1-749 sub2-882 sub3-813
        
confusionmat(result3_3_2,testclass)       

plot(result3_3_2,'r')
hold on
plot(testclass,'g')
xlabel('epoch')
ylabel('stage')

%%%  2分类 subject 3 lsvm noise
correct=0;
false=0;
for i=1:813 %sub1-749 sub2-882 sub3-813
    if result3_3_noise_2(i)==testclass(i)%比较预测结果和正确结果
        correct=correct+1;
    else
        false=false+1;
    end
end
acc3_3_noise_2=correct/813;%sub1-749 sub2-882 sub3-813
        
confusionmat(result3_3_noise_2,testclass)       

plot(result3_3_noise_2,'r')
hold on
plot(testclass,'g')
xlabel('epoch')
ylabel('stage')
%%%--------------3分类--------------%%%
%%%  3分类 subject 3 lsvm 无合成数据
correct=0;
false=0;
for i=1:813 %sub1-749 sub2-882 sub3-813
    if result3_3_3(i)==testclass(i)%比较预测结果和正确结果
        correct=correct+1;
    else
        false=false+1;
    end
end
acc3_3_3=correct/813;%sub1-749 sub2-882 sub3-813
confusionmat(result3_3_3,testclass)       
plot(result3_3_3,'r')
hold on
plot(testclass,'g')
xlabel('epoch')
ylabel('stage')
%%%  3分类 subject 3 lsvm noise
correct=0;
false=0;
for i=1:813 %sub1-749 sub2-882 sub3-813
    if result3_3_noise_3(i)==testclass(i)%比较预测结果和正确结果
        correct=correct+1;
    else
        false=false+1;
    end
end
acc3_3_noise_3=correct/813;%sub1-749 sub2-882 sub3-813
        
confusionmat(result3_3_noise_3,testclass)       
plot(result3_3_noise_3,'r')
hold on
plot(testclass,'g')
xlabel('epoch')
ylabel('stage')
%%%  3分类 subject 3 lsvm surrogate
correct=0;
false=0;
for i=1:813 %sub1-749 sub2-882 sub3-813
    if result3_3_surrogate_3(i)==testclass(i)%比较预测结果和正确结果
        correct=correct+1;
    else
        false=false+1;
    end
end
acc3_3_surrogate_3=correct/813;%sub1-749 sub2-882 sub3-813
confusionmat(result3_3_surrogate_3,testclass)       
plot(result3_3_surrogate_3,'r')
hold on
plot(testclass,'g')
xlabel('epoch')
ylabel('stage')
%%%--------------4分类--------------%%%
%%%  4分类 subject 3 lsvm 无合成数据
correct=0;
false=0;
for i=1:813 %sub1-749 sub2-882 sub3-813
    if result3_3_4(i)==testclass(i)%比较预测结果和正确结果
        correct=correct+1;
    else
        false=false+1;
    end
end
acc3_3_4=correct/813;%sub1-749 sub2-882 sub3-813
confusionmat(result3_3_4,testclass)       
plot(result3_3_4,'r')
hold on
plot(testclass,'g')
xlabel('epoch')
ylabel('stage')
%%%  4分类 subject 3 lsvm noise
correct=0;
false=0;
for i=1:813 %sub1-749 sub2-882 sub3-813
    if result3_3_noise_4(i)==testclass(i)%比较预测结果和正确结果
        correct=correct+1;
    else
        false=false+1;
    end
end
acc3_3_noise_4=correct/813;%sub1-749 sub2-882 sub3-813
        
confusionmat(result3_3_noise_4,testclass)       
plot(result3_3_noise_4,'r')
hold on
plot(testclass,'g')
xlabel('epoch')
ylabel('stage')
%%%  4分类 subject 3 lsvm surrogate
correct=0;
false=0;
for i=1:813 %sub1-749 sub2-882 sub3-813
    if result3_3_surrogate_4(i)==testclass(i)%比较预测结果和正确结果
        correct=correct+1;
    else
        false=false+1;
    end
end
acc3_3_surrogate_4=correct/813;%sub1-749 sub2-882 sub3-813
confusionmat(result3_3_surrogate_4,testclass)       
plot(result3_3_surrogate_4,'r')
hold on
plot(testclass,'g')
xlabel('epoch')
ylabel('stage')

%%%中期
%%% subject 1
correct=0;
false=0;
for i=1:749 %sub1-749 sub2-882 sub3-813
    if result(i)==testclass(i)%比较预测结果和正确结果
        correct=correct+1;
    else
        false=false+1;
    end
end
acc1_1=correct/749;%sub1-749 sub2-882 sub3-813
acc2_1=correct/749;
acc3_1=correct/749;%sub1-749 sub2-882 sub3-813
acc4_1=correct/749;
%%% subject 2
correct=0;
false=0;
for i=1:882 %sub1-749 sub2-882 sub3-813
    if result(i)==testclass(i)%比较预测结果和正确结果
        correct=correct+1;
    else
        false=false+1;
    end
end
acc1_2=correct/882;%sub1-749 sub2-882 sub3-813
acc2_2=correct/882;
acc3_2=correct/882;%sub1-749 sub2-882 sub3-813
acc4_2=correct/882;

%%% subject 3
correct=0;
false=0;
for i=1:813 %sub1-749 sub2-882 sub3-813
    if result(i)==testclass(i)%比较预测结果和正确结果
        correct=correct+1;
    else
        false=false+1;
    end
end
acc1_3=correct/813;%sub1-749 sub2-882 sub3-813
acc2_3=correct/813;
acc3_3=correct/813;%sub1-749 sub2-882 sub3-813
acc4_3=correct/813;
%%% subject 4
correct=0;
false=0;
for i=1:925 %sub4-925
    if result(i)==testclass(i)%比较预测结果和正确结果
        correct=correct+1;
    else
        false=false+1;
    end
end
acc1_4=correct/925;%sub1-749 sub2-882 sub3-813
acc2_4=correct/925;
acc3_4=correct/925;%sub1-749 sub2-882 sub3-813
acc4_4=correct/925;
%%% subject 5
correct=0;
false=0;
for i=1:907 %sub5-907
    if result(i)==testclass(i)%比较预测结果和正确结果
        correct=correct+1;
    else
        false=false+1;
    end
end
acc1_5=correct/907;%sub1-749 sub2-882 sub3-813
acc2_5=correct/907;
acc3_5=correct/907;%sub1-749 sub2-882 sub3-813
acc4_5=correct/907;
%%% subject6
correct=0;
false=0;
for i=1:901 %sub6-901
    if result(i)==testclass(i)%比较预测结果和正确结果
        correct=correct+1;
    else
        false=false+1;
    end
end
acc1_6=correct/901;%sub1-749 sub2-882 sub3-813
acc2_6=correct/901;
acc3_6=correct/901;%sub1-749 sub2-882 sub3-813
acc4_6=correct/901;
%%% subject7
correct=0;
false=0;
for i=1:864 %sub7-864
    if result(i)==testclass(i)%比较预测结果和正确结果
        correct=correct+1;
    else
        false=false+1;
    end
end
acc1_7=correct/864;%sub1-749 sub2-882 sub3-813
acc2_7=correct/864;
acc3_7=correct/864;%sub1-749 sub2-882 sub3-813
acc4_7=correct/864;
%%% subject8
correct=0;
false=0;
for i=1:811 %sub8-811
    if result(i)==testclass(i)%比较预测结果和正确结果
        correct=correct+1;
    else
        false=false+1;
    end
end
acc1_8=correct/811;%sub1-749 sub2-882 sub3-813
acc2_8=correct/811;
acc3_8=correct/811;%sub1-749 sub2-882 sub3-813
acc4_8=correct/811;
%%% subject9
correct=0;
false=0;
for i=1:774 %sub9-774
    if result(i)==testclass(i)%比较预测结果和正确结果
        correct=correct+1;
    else
        false=false+1;
    end
end
acc1_9=correct/774;%sub1-749 sub2-882 sub3-813
acc2_9=correct/774;
acc3_9=correct/774;%sub1-749 sub2-882 sub3-813
acc4_9=correct/774;
%%% subject10
correct=0;
false=0;
for i=1:789 %sub10-789
    if result(i)==testclass(i)%比较预测结果和正确结果
        correct=correct+1;
    else
        false=false+1;
    end
end
acc1_10=correct/789;%sub1-749 sub2-882 sub3-813
acc2_10=correct/789;
acc3_10=correct/789;%sub1-749 sub2-882 sub3-813
acc4_10=correct/789;