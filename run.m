clear;
clc;
warning off;
addpath(genpath('./'));

dsPath = './dataset/';
ds = {
'Mfeat'
    };


for dsi = 1:1:length(ds)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    :length(ds)
    % load data & make folder
    dataName = ds{dsi}; disp(dataName);
    load(strcat(dsPath,dataName));
    k = length(unique(Y));
    numview = length(X);
    %% para setting
    selectanchor = [1 2 5]*k;
    lambda = [0.0001 0.01 0.1 1 100];
    mu = [0,10^-4,1,10^4];
    ACC = zeros(length(selectanchor),length(lambda),length(mu));
    NMI = zeros(length(selectanchor),length(lambda),length(mu));
    Purity = zeros(length(selectanchor),length(lambda),length(mu));
    %%
    idx = 0;
    ResBest = zeros(8);
    StdBest = zeros(8);
    A = cell(1,numview);
    for ichor = 1:length(selectanchor)
        tic;
        m = selectanchor(ichor) ;
        parfor i = 1:numview
            if size(X{i},1)<m
                A{i} = initplize(X{i},m);
                A{i} = A{i}';
            else
                rand('twister',5489);
                [~, A{i}] = litekmeans(X{i},m,'MaxIter', 100,'Replicates',10);
                A{i} = A{i}';
            end
            % turn into d*n
        end
        time1 = toc;
        for id = 1:length(lambda)
            for ic = 1:length(mu)
                tic;
                [U,A,Z,iter,obj] = my_algo(X,Y,selectanchor(ichor),lambda(id),mu(ic),A); % X,Y,lambda,d,numanchor
                [tempRes,tempStd] = myNMIACCwithmean(U,Y,k); % [ACC nmi Purity Fscore Precision Recall AR Entropy]
                time2  = toc;
                idx = idx +1;
                runtime(idx) = time1+time2;
                ACC(ichor, id,ic) = tempRes(1);
                NMI(ichor, id,ic) = tempRes(2);
                Purity(ichor, id,ic) = tempRes(3);
                for tempIndex = 1 : 8
                    if tempRes(tempIndex) > ResBest(tempIndex)
                        if tempIndex == 1
                            newA = A;
                            newZ = Z;
                            objection = obj;
                        end
                        ResBest(tempIndex) = tempRes(tempIndex);
                        StdBest(tempIndex) = tempStd(tempIndex);
                    end
                end
            fprintf('iter = %d ',idx)
            end
            aRuntime = mean(runtime);
        end
        fprintf('\n')
    end
    fprintf('Res:%12.6f %12.6f %12.6f \n',[ResBest(1) ResBest(2) ResBest(3)]);
    clear runtime;
end

