%Reading of data
tic
load data_features

%Normalization
%--------------------
features_norm = {};
for kk = 1:size(features_sub,1)
    x_eeg = features_sub{kk,1}';
    x_ecg = features_sub{kk,2}';
    x_eeg = zscore(x_eeg,0,2);
    x_ecg = zscore(x_ecg,0,2);
    features_norm{kk, 1} = x_eeg';
    features_norm{kk, 2} = x_ecg';
end

datos_iniciales = features_norm;

%------------Parameters------------------
caract       = 1;  %1=EEG 2=ECG
nro_comp_eeg = 6;  %Number of components EEG
nro_comp_ecg = 12; %Number of components ECG
classification_type = 1;
%0:   0,1,2,3,4,5 Six classes
%1:   0,1-2-3-4-5 Two classes
%2:   0,1,2-3-4-5 Three classes
%3:   0,1,2-3,4-5 Four classes
%-----------------------------------------

if caract == 1
    disp ('Features EEG')
elseif caract == 2
    disp ('Features ECG')
end
if classification_type == 0
    disp('----Six classes----')
elseif classification_type == 1
    disp('----Two classes----')
elseif classification_type == 2
    disp('----Three classes----')
elseif classification_type == 3
    disp('----Four classes----')
end

%Number of experiment 
%--------------------
jj  = 0;
jjj = 0;
features_sub = datos_iniciales;
jj = jj+1;
disp (['Experiment number: ' num2str(jj)])
disp ('---------------------------------------')

%PCA estimation
%--------------------
warning('off')
features_pca = {};
explained_eeg = [];
explained_ecg = [];
for kk = 1:size(features_sub,1)
    x_eeg  = features_sub{kk,1};
    x_ecg  = features_sub{kk,2};
    [coeff,score,latent,tsquared,explained,mu] = pca(x_eeg);
    explained_eeg = [explained_eeg; explained'];
    features_pca{kk, 1} = score(:,1:nro_comp_eeg);
    [coeff,score,latent,tsquared,explained,mu] = pca(x_ecg);
    explained_ecg = [explained_ecg; explained'];
    features_pca{kk, 2} = score(:,1:nro_comp_ecg);
end
features_sub = features_pca;

%Estimate the explained variace for all the experiment
%--------------------
var_eeg = [];
var_ecg = [];
for kk = 1:size(features_sub,1)
    var_eeg = [var_eeg; cumsum(explained_eeg(kk,1:nro_comp_eeg))];
    var_ecg = [var_ecg; cumsum(explained_ecg(kk,1:nro_comp_ecg))];
end

if caract == 1
    disp (['mean of explained variance of EEG : ' num2str(mean(var_eeg(:,nro_comp_eeg)))...
        '  ' num2str(nro_comp_eeg) '/' num2str(size(features_eeg,2)) ' components'])
elseif caract == 2
    disp (['mean of explained variance of ECG : ' num2str(mean(var_ecg(:,nro_comp_ecg)))...
        '  ' num2str(nro_comp_ecg) '/' num2str(size(features_ecg,2)) ' components'])
end
warning('on')

%Leave-one-out procedure
%--------------------
for kk= 1:size(features_sub,1)
    %Testing data
    data_testing     = features_sub{kk,caract};
    classes_testing  = classes_sub{kk}';
    %Training data
    data_training    = [];
    classes_training = [];
    for kkk=1:size(features_sub,1)
        if (kkk ~= kk)
            temp             = features_sub{kkk,caract};
            data_training    = [data_training; temp];
            temp             = classes_sub{kkk}';
            classes_training = [classes_training; temp];
        end
    end
    
    %----------------------------------
    %Conversion of classes according to classification type
    %----------------------------------
    switch classification_type
        case 1
            %---- 0,1-2-3-4-5 Two classes
            for pp = 1:size(classes_training)
                if classes_training(pp) >= 1
                    classes_training(pp) = 1;
                end
            end
            for pp = 1:size(classes_testing)
                if classes_testing(pp) >= 1
                    classes_testing(pp) = 1;
                end
            end
        case 2
            %---- 0,1,2-3-4-5 Three classes
            for pp = 1:size(classes_training)
                if classes_training(pp) >= 2
                    classes_training(pp) = 2;
                end
            end
            for pp = 1:size(classes_testing)
                if classes_testing(pp) >= 2
                    classes_testing(pp) = 2;
                end
            end
        case 3
            %---- 0,1,2-3,4-5 Four classes
            for pp = 1:size(classes_training)
                if classes_training(pp) >= 2 && classes_training(pp) <= 3
                    classes_training(pp) = 2;
                elseif classes_training(pp) >= 3
                    classes_training(pp) = 3;
                end
            end
            for pp = 1:size(classes_testing)
                if classes_testing(pp) >= 2 && classes_testing(pp) <= 3
                    classes_testing(pp) = 2;
                elseif classes_testing(pp) >= 3
                    classes_testing(pp) = 3;
                end
            end
    end
    
    %----------------------------------
    %Classification of data of subject kk
    % -----LDA -----------------
    ob = fitcdiscr(data_training,classes_training,'prior','uniform','discrimtype','pseudolinear');
    [ztest1,stest1] = predict(ob,data_testing);
    scores          = stest1(:,2);
    classes_estim1  = ztest1;
    %----------------------------------
    %Display results for subject kk
    error1 = -1;
    cp = classperf(classes_testing,classes_estim1);
    error1 = round(cp.ErrorRate*100,2);
    
    disp (['suj ' num2str(subs(kk)) '   error: ' num2str(error1)])
    %figure; plot(classes_testing, 'b'); hold on; plot(classes_estim1, 'r');
    
    %----------------
    %Store results
    jjj = jjj + 1;
    resul{jjj}.subject      = subs(kk);
    resul{jjj}.error1       = error1;
end
toc


