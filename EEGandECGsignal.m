%%%%%%%%noise
plot(trainfeature(1:200,1),'g')
hold on
plot(trainfeature_noise(1:200,1),'b')
xlabel('epoch')
ylabel('microvolts')
title('EEG Features');

plot(trainfeature(1:200,9),'g')
hold on
plot(trainfeature_noise(1:200,9),'b')
xlabel('epoch')
ylabel('Autoregressive coefficients')
title('ECG Features');

%%%%%surrogate
plot(trainfeature(1:200,1),'g')
hold on
plot(trainfeature_surrogate(1:200,1),'b')
xlabel('epoch')
ylabel('microvolts')
title('EEG Features');

plot(trainfeature(1:200,9),'g')
hold on
plot(trainfeature_surrogate(1:200,9),'b')
xlabel('epoch')
ylabel('Autoregressive coefficients')
title('ECG Features');