% Criar figuras para dissertação
% Consequentes
% Antecedentes
% Gauss Tipo-2
% MFs da Gauss Tipo-2 antes da combinação

% Sistema 01A v7
% Ultima modificação: 26/09/2011
% Design:
% Com todos os padroes (15)
% Com 20 antecedentes
% Usando o "winner takes all"
% Sem otimizacao
% Com validacao leaving-one-out

clear all
close all
load Dados_Sist01v7_1.mat

y = 0:0.001:2;
x = 0:0.001:200;

% padraototal = [0 1 2 3 4 7 8 9 10 11 12 13 14];
% Padroes usados para extrair os parametros dos antecedentes
padrao = [0 1 7 8 9 10 11 12 13 14];
% Numero de clusters para cada um dos padroes
% nclusters = [5 8 2 6 3 3 3 5 10 5 12 2 2 5 4];
nclusters = [4 2 2 3 6 6 6 7 3 5 3 2 2 2 3];
% numero de antecedentes: n+1
ant = 20;
% padrao a ser testado
temp2 = temp;
temp2(temp2(:,end-1)==2,end-1) = 1;

for idt=0 %padrao
    
    data = datapd(temp2, idt, ant);
    
    %Usar somente 1 valor por vez para testar
    for i=300:300%size(data,1)
        entrada = data(i,:);
        % Parametros
        % Tenho que passar os dados sem o feature de teste
        
        MFpar = mfpars6(temp2, padrao, ant, nclusters, i, idt);
        
%         tic;
        clear mf
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
%                 figure(r);
%                 subplot(2, 10, a)
%                 plot(x, [mf.l' mf.u'])
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
    end
%     EndTime = toc;
end
J = 0;
r = idmax;
for a = 13%1:((size(MFpar,2)-2)/4)

    % parametros do antecedente
    pars(r,a).m1 = MFpar(r, a+2+J);
    pars(r,a).s1 = MFpar(r, a+3+J);
    pars(r,a).m2 = MFpar(r, a+4+J);
    pars(r,a).s2 = MFpar(r, a+5+J);
    J = J + 3;

    mf = gauss4mf(x, pars(r,a));
    figure(a)
    plot(x, [mf.l' mf.u'])
            
end
set(gcf, 'color', 'white');
hLegend = legend('LMF','UMF');
set(hLegend, 'TextColor', [.3 .3 .3], 'EdgeColor', [.3 .3 .3]);
hYLabel = ylabel('Grau de Pertinencia');
hXLabel = xlabel('Temperatura');
%prtyplt('consequentes.eps')
set(gca, 'FontName', 'Helvetica');
set([hXLabel, hYLabel], ... % Caso sem Título
            'FontName', 'AvantGarde');
set([hXLabel, hYLabel, hLegend], 'FontSize', 12);
set(gca, ...
          'Box'         , 'off'     , ...
          'TickDir'     , 'out'     , ...
          'TickLength'  , [.02 .02] , ...
          'XMinorTick'  , 'on'      , ...
          'YMinorTick'  , 'on'      , ...
          'YGrid'       , 'on'      , ...
          'XColor'      , [.3 .3 .3], ...
          'YColor'      , [.3 .3 .3], ...
          'LineWidth'   , 1);  
set(gcf, 'PaperPositionMode', 'auto');
xlim([85.5 94.5])
print('-depsc2', '-r200', 'two-sided2.eps');
fixEPS('two-sided2.eps')
%% separadas
y1 = gaussmf(x, [pars(idmax, 13).s1 pars(idmax, 13).m1]);
y2 = gaussmf(x, [pars(idmax, 13).s2 pars(idmax, 13).m2]);
plot(x, [y2' y1']);

set(gcf, 'color', 'white');
hLegend = legend('m=1,5','m=3,0');
set(hLegend, 'TextColor', [.3 .3 .3], 'EdgeColor', [.3 .3 .3]);
hYLabel = ylabel('Grau de Pertinencia');
hXLabel = xlabel('Temperatura');
%prtyplt('consequentes.eps')
set(gca, 'FontName', 'Helvetica');
set([hXLabel, hYLabel], ... % Caso sem Título
            'FontName', 'AvantGarde');
set([hXLabel, hYLabel, hLegend], 'FontSize', 12);
set(gca, ...
          'Box'         , 'off'     , ...
          'TickDir'     , 'out'     , ...
          'TickLength'  , [.02 .02] , ...
          'XMinorTick'  , 'on'      , ...
          'YMinorTick'  , 'on'      , ...
          'YGrid'       , 'on'      , ...
          'XColor'      , [.3 .3 .3], ...
          'YColor'      , [.3 .3 .3], ...
          'LineWidth'   , 1);  
set(gcf, 'PaperPositionMode', 'auto');
xlim([85.5 94.5])
print('-depsc2', '-r200', 'MFs-separadas2.eps');
fixEPS('MFs-separadas2.eps')

%% Consequentes

cs1 = trimf(0:0.001:0.5, [0 0 0.5]);
cs2 = trimf(.5:.001:1.5, [0.5 1 1.5]);
cs3 = trimf(1.5:.001:2, [1.5 2 2]);

plot(0:.001:.5, cs1, 'b');
hold on;
plot(0.5:.001:1.5, cs2, 'm');
hold on;                
plot(1.5:.001:2, cs3, 'r');  


 set(gcf, 'color', 'white');
 hLegend = legend('Normal - 0','Bias - 1', 'Rompido - 2');                
set(hLegend, 'Location', 'South', 'TextColor', [.3 .3 .3], 'EdgeColor', [.3 .3 .3]);
 hYLabel = ylabel('Grau de Pertinencia');
 hXLabel = xlabel('Temperatura');
%prtyplt('consequentes.eps')
 set(gca, 'FontName', 'Helvetica');
set([hXLabel, hYLabel], ... % Caso sem Título
            'FontName', 'AvantGarde');
set([hXLabel, hYLabel, hLegend], 'FontSize', 12);
set(gca, ...
          'Box'         , 'off'     , ...
          'TickDir'     , 'out'     , ...
          'TickLength'  , [.02 .02] , ...
          'XMinorTick'  , 'on'      , ...
          'YMinorTick'  , 'on'      , ...
          'YGrid'       , 'on'      , ...
          'XColor'      , [.3 .3 .3], ...
          'YColor'      , [.3 .3 .3], ...
          'LineWidth'   , 1);  
set(gcf, 'PaperPositionMode', 'auto');


print('-depsc2', '-r300', 'consequentes.eps');
fixEPS('consequentes.eps')