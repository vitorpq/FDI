% Sistema 01A v7
% Ultima modificação: 28/09/2011
% Design:
% Com todos os padroes (15)
% Com 20 antecedentes
% Usando o "winner takes all"
% Sem otimizacao
% Com validacao leaving-one-out

clear all
close all
load Dados_Sist01v7_2.mat

y = 0:0.001:2;
x = 0:0.001:200;

% padraototal = [0 1 2 3 4 7 8 9 10 11 12 13 14];
% Padroes usados para extrair os parametros dos antecedentes
padrao = [0 1 7 8 9 10 11 12 13];
% Numero de clusters para cada um dos padroes
% nclusters = [5 8 2 6 3 3 3 5 10 5 12 2 2 5 4];
nclusters = [4 2 2 3 6 6 6 7 3 5 3 2 2 2 3];
% numero de antecedentes: n+1
ant = 20;
% padrao a ser testado

for idt=8 %padrao
    
    data = datapd(UsedData, idt, ant);
    
    %Usar somente 1 valor por vez para testar
    for i=1:size(data,1)
        entrada = data(i,:);
        % Parametros
        % Tenho que passar os dados sem o feature de teste
        
        MFpar = mfpars2(UsedData, padrao, ant, nclusters, i, idt);
        
        tic;
        clear G OutSet_u OutSet_l mf  RA_u RA_l
        for r = 1:size(MFpar,1)
            J = 0;
            % Para zerar a agregacao dos antecedentes
            A_u = 1;
            A_l = 1;
            for a = 1:((size(MFpar,2)-2)/4)

                % parametros do antecedente
                pars(r,a).m1 = MFpar(r, a+2+J);
                pars(r,a).s1 = MFpar(r, a+3+J);
                pars(r,a).m2 = MFpar(r, a+4+J);
                pars(r,a).s2 = MFpar(r, a+5+J);
                J = J + 3;

                mf = gauss4mf(entrada(a), pars(r,a));

                % agregacao dos antecedentes
    %             A_u = (A_u * mf.u);
    %             A_l = (A_l * mf.l);
                A_u(r,a) = mf.u;
                A_l(r,a) = mf.l;
            end
            % Consequents
            G(r,:) = trimf(y, [MFpar(r, 2)-0.5 MFpar(r, 2) MFpar(r, 2)+0.5]);
            Firing_u(r) = prod(A_u(r,:));
            Firing_l(r) = prod(A_l(r,:));
            % Implication
            OutSet_u(r,:) = (Firing_u(r) .* G(r,:));
            OutSet_l(r,:) = (Firing_l(r) .* G(r,:));
        end

        % Rule Aggregation
            % winner takes all
            [valor idmax] = max(max(OutSet_u, [], 2));
            RA_u = OutSet_u(idmax, :);
            RA_l = OutSet_l(idmax, :);
%         RA_u = max(OutSet_u, [], 1);
%         RA_l = max(OutSet_l, [], 1);

        %% Type-Reduction
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
        state(i) = (lc + rc)/2;
        
    end
    EndTime = toc;
end
AvgTime = EndTime/i;
disp(['Total Time: ', num2str(EndTime)]);
disp(['Average Time: ', num2str(AvgTime)]);
estado = data(1:i,end);
final = round(state');
% plot([estado final], 'x');
% legend('Correct', 'FDD');
Erro = 100*(size(find(final ~= estado))/size(final));
disp(['Error: ', num2str(Erro), '%'])