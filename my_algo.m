function [H,A,Z,iter,obj] = my_algo(X,Y,m,lambda_1,lambda,A)
% m      : the number of anchor. the size of Z is m*n.
% lambda : the hyper-parameter of regularization term.
% X      : n*di

%% initplize
maxIter = 40 ; % the number of iterations
numview = length(X);
numsample = size(Y,1);
k = length(unique(Y));

e = zeros(m,numsample);
w = zeros(m,1);
M = cell(numview,1);

for i = 1:numview
    X{i} = mapstd(X{i}',0,1);
end
flag = 1;
iter = 0;
%%
Z_temp = {};
while flag
    iter = iter + 1;
    %% optimize Z
    for p = 1:numview
        M{p}=zeros(1,m);
        for j = 1:m
            M{p}(1,j) = A{p}(:,j)'*A{p}(:,j);
        end
    end
    G = zeros(m,m);
    for p=1:numview
        G = G + A{p}'*A{p};
    end
    G = G+lambda * eye(m);
    e = zeros(m,numsample);
    for i = 1:numsample
        for p = 1:numview
            e(:,i) = e(:,i) - (X{p}(:,i)'*A{p}- lambda_1 * M{p}*0.5)';
        end
    end
    
    options = optimset( 'Algorithm','interior-point-convex','Display','off'); % Algorithm 榛樿涓? interior-point-convex
    parfor i=1:numsample
        Z(:,i) = quadprog(G,e(:,i),[],[],ones(1,m),1,zeros(m,1),ones(m,1),[],options);
    end

    
    %% optimize A_i
    for p = 1:numview
        A{p} = X{p}*Z'*pinv(Z*Z'+lambda_1*diag(Z*ones(numsample,1)));
    end
    
    %%
    term1 = 0;
    for p = 1:numview
        sum2 = 0;
        temp = (A{p} *Z).^2;
        temp2 = X{p}'*A{p};
        for i = 1:numsample
            sum2 =sum2+lambda_1 * M{p}*Z(:,i) +sum(temp(:,i)) -2 * temp2(i,:)*Z(:,i);
        end
        term1 = term1 + sum2;
    end
    for i = 1:numsample
        term1 = term1 +lambda*(Z(:,i)'*Z(:,i));
    end
    obj(iter) = term1;
    Z_temp{iter}= Z;
    
    if (iter>9) && (abs((obj(iter-1)-obj(iter))/abs(obj(iter-1)))<1e-3 || iter>maxIter || abs(obj(iter)) < 1e-6)
        [H,~,~]=svd(Z','econ');
        flag = 0;
    end
end



