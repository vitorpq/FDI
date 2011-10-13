%calling function to search the optimal number of clusters
close all
clear all
load Dados_Sist01v7_2.mat
% addpath ../progs
% addpath /home/vitor/Documents/MATLAB/FUZZCLUST/

ant = 20;
%padrao = [0 1 2 3 4 7 8 9 10 11 12 13 14];
padrao = 7;

for idt = padrao
    close
    dados = datapd(UsedData, idt, ant);
    data.X = dados(:,1:end-2);

    [N,n]=size(data.X);
    %data normalizaiton
    %data = clust_normalize(data,'range');

    %parameters
    ncmax=14; %maximal number of cluster
    param.m=1.5;

    %
    ment=[];
    %figure(1)
    for cln=2:ncmax
        param.c=cln;

        %rand('state', 0);
        result=FCMclust(data,param);
    %     clf
        %plot(data.X(:,1),data.X(:,2),data.X(:,3),data.X(:,4),data.X(:,5),data.X(:,6
        %),'b.',result.cluster.v(:,1),result.cluster.v(:,2),result.cluster.v(:,3),result.cluster.v(:,4), result.cluster.v(:,5), result.cluster.v(:,6),'r*');
        new.X=data.X;
        clusteval(new,result,param);
        %validation
        result=modvalidity(result,data,param);
        ment{cln}=result.validity;
    end
    PC=[];CE=[];SC=[];S=[];XB=[];DI=[];ADI=[];
        for i=2:ncmax
           PC=[PC ment{i}.PC];
           CE=[CE ment{i}.CE];
           SC=[SC ment{i}.SC];
           S=[S ment{i}.S];
           XB=[XB ment{i}.XB];
           DI=[DI ment{i}.DI];
           ADI=[ADI ment{i}.ADI];
        end

    figure(1)
    clf
    subplot(2,1,1), plot([2:ncmax],PC)
    title('Partition Coefficient (PC)')
    subplot(2,1,2), plot([2:ncmax],CE,'r')  
    title('Classification Entropy (CE)')
    figure(2)
    subplot(3,1,1), plot([2:ncmax],SC,'g')
    title('Partition Index (SC)')
    subplot(3,1,2), plot([2:ncmax],S,'m')
    title('Separation Index (S)')
    subplot(3,1,3), plot([2:ncmax],XB)
    title('Xie and Beni Index (XB)')
    figure(3)
    subplot(2,1,1), plot([2:ncmax],DI)
    title('Dunn Index (DI)')
    subplot(2,1,2), plot([2:ncmax],ADI)
    title('Alternative Dunn Index (ADI)')
    
    
    [v1 idxb]=min(XB);
    [v2 ids]=min(S);
    [v3 idsc]=min(SC);
    disp(idxb+1);
    pause();
end
