% Sistema 01A - v8
% Ultima modificação: 06/10/2011
% Design:
% Tipo-2
% Padroes: (9)
% Com 20 antecedentes
% Usando o "winner takes all"
% Sem otimizacao
% Com validacao leaving-one-out
% usando PARFOR

clear all
close all
load Dados_Sist01v7_2.mat
addpath /home/vitor/Documents/MATLAB/fuzzy2

y = 0:0.001:2;
x = 0:0.001:200;
m = [1.5 2.5];

% padraototal = [0 1 2 3 4 7 8 9 10 11 12 13 14];
% Padroes usados para extrair os parametros dos antecedentes
padrao = [0 1 7 8 9 10 11 12 13];
% Numero de clusters para cada um dos padroes
% nclusters = [5 8 2 6 3 3 3 5 10 5 12 2 2 5 4];
nclusters = [4 2 2 3 6 6 6 7 3 5 3 2 2 2 3];
% numero de antecedentes: n+1
ant = 20;
% padrao a ser testado

%% Parallel Workers
if matlabpool('size') < 4
    if matlabpool('size') > 0
        matlabpool close force fdd;
    end
    matlabpool open 3;
end

% Clean screen
clc;

for idt=7 %padrao
    %% Identificação do padrão
    disp('-------------------------------------------------------------------');
    disp(['Iniciando Padrão - ', num2str(idt)]);
    %% Pattern Test
    clear state estado final Erro
    tic;
    
    data = datapd(UsedData, idt, ant);
    Range = size(data,1);

    parfor ii=1:Range
        %% Fuzzy trainning (FCM)
        % train without one data feature (ii)
        % m = [1.5 2.5]
        MFpar = mfpars2(UsedData, padrao, m, ant, nclusters, ii, idt);
        
        % rules number
        rules = size(MFpar,1);
        
        % pre-allocating
        OutSet_l = zeros(rules,size(y,2));
        OutSet_u = zeros(rules,size(y,2));
        
        % data feature to be tested
        entrada = data(ii,:);
        
        % clear OutSet_u OutSet_l RA_u RA_l
        % NAO PODE USAR CLEAR DENTRO DO PARFOR
        % MAS COMO ELE RODA INDEPENDENTE, ESTAS VARS NAO SE MISTURAM
        %% Fuzzy System begins
        for r = 1:rules
            % --Rules output sets--
            pars = MFpar(r, :); % pars = [1, 20]
            [OutSet_l(r,:) OutSet_u(r,:)] = OutSet2(entrada, pars);
        end
        % --Rule Aggregation--
        % winner takes all (Chiu, 19??)
        [valor idmax] = max(max(OutSet_u, [], 2));
        RA_u = OutSet_u(idmax, :);
        RA_l = OutSet_l(idmax, :);
        % Regular Rule Aggregation    
        % RA_u = max(OutSet_u, [], 1);
        % RA_l = max(OutSet_l, [], 1);

        % --Type-Reduction--
        % Centroid
        % w = (L+R)/2
        % delta = (R - L)/2
        w = (RA_l + RA_u) / 2;
        delta = (RA_u - RA_l) / 2;

        [lc rc] = centroid_tr(y, w, delta);

    %     if isnan(rc) && isnan(lc)
    %         state(n) = 0;
    %     elseif isnan(lc) && ~isnan(rc)
    %         state(n) = rc/2;
    %     elseif isnan(rc) && ~isnan(lc)
    %         state(n) = lc/2;
    %     else
    %         state(n) = (lc + rc)/2;
    %     end
        state(ii) = (lc + rc)/2;
        
    end
    %% Error and time elapsed for each pattern
    EndTime = toc;
    disp(['Time Elapsed: ', num2str(EndTime)]);
    estado = data(1:Range,end);
    final = round(state');
    % plot([estado final], 'x');
    % legend('Correct', 'FDD');
    Erro = 100*(size(find(final ~= estado))/size(final));
    disp(['Error: ', num2str(Erro), '%'])

    %% Results struct
    Results(idt+1).padrao = idt;
    Results(idt+1).estado = state;
    Results(idt+1).legenda = unique(estado);
    Results(idt+1).tamanho = size(estado);
    Results(idt+1).tempo = EndTime;
end
