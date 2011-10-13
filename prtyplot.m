function prtyplot(dados, nome, varargin)
%, XLabel, YLabel, HTitle, tFlag, tStart)
% O q vai de entrada?
% dados, se eh dado temporal, tempo inicial, xlabel, ylabel, title
    
    if exist('images', 'dir') ~= 7
        mkdir('images');
    end
    
    % only want 3 optional inputs at most
    numvarargs = length(varargin);
    if numvarargs > 2
        error('myfuns:prtyplot:TooManyInputs', ...
            'requires at most 2 optional inputs');
    end

    % set defaults for optional inputs
    optargs = {0 0};

    % now put these defaults into the valuesToUse cell array, 
    % and overwrite the ones specified in varargin.
    optargs(1:numvarargs) = varargin;
    % or ...
    % [optargs{1:numvarargs}] = varargin{:};

    % Place optional args in memorable variable names
    [tiff png] = optargs{:};


    figure('visible', 'off');
    idt=nome;
    tFlag = 1;
    XLabel = 'Tempo (horas)';
    YLabel = 'Temperatura (^{\circ}C)';
    %HTitle = 
    
    if tFlag == 1
        tStart = '00:00:00';
        startDate = datenum(tStart);
        [hora minu secu] = sec2hms(30*(size(dados,1)));
        endDate = datenum(strcat(int2str(hora),':',int2str(minu),':',int2str(secu)));
        xData = linspace(startDate, endDate, size(dados,1));
        plot(xData, dados, 'r');
        [xInicio xFim xpts] = limtempo(xData);
        %hTitle  = title ('My Publication-Quality Graphics');
        hXLabel = xlabel(XLabel);
        hYLabel = ylabel(YLabel);


        %xlim([xData(1) xData(end)]);
        set(gcf, 'color', 'white');        


        set( gca                       , ...
            'FontName'   , 'Helvetica' );
        %set([hTitle, hXLabel, hYLabel], ...
        %    'FontName'   , 'AvantGarde');
        set([hXLabel, hYLabel], ... % Caso sem Título
            'FontName', 'AvantGarde');
        set([hXLabel, hYLabel]  , ...
            'FontSize', 12);
%         set( hTitle                    , ...
%             'FontSize'   , 12          , ...
%             'FontWeight' , 'bold'      );

        [inicio fim ticos] = limites(dados);


        set(gca, ...
          'Box'         , 'off'     , ...
          'TickDir'     , 'out'     , ...
          'TickLength'  , [.02 .02] , ...
          'XMinorTick'  , 'on'      , ...
          'YMinorTick'  , 'on'      , ...
          'YGrid'       , 'on'      , ...
          'XColor'      , [.3 .3 .3], ...
          'YColor'      , [.3 .3 .3], ...
          'YTick'       , ticos, ...
          'YTickLabel'  , num2str(transpose(ticos), '%0.1f'), ...
          'YLim'        , [inicio fim], ...
          'LineWidth'   , 1, ...
          'XTick'       , xpts, ...
          'XTickLabel'  , datestr(xpts, 'HH:MM'),...
          'XLim'        , [xInicio xFim]);

        set(gcf, 'PaperPositionMode', 'auto');
        
        saveeps = strcat('teste/Padrao_', int2str(idt), '.eps');
        savetiff = strcat('teste/Padrao_', int2str(idt), '.tiff');
        savepng = strcat('teste/Padrao_', int2str(idt), '.png');
        
        print('-depsc2', '-r200', saveeps);
        % Fix EPS
        fixPSlinestyle(saveeps, strcat('teste/Padrao_', int2str(idt), '_fixed.eps'));
        
        if tiff == 1, print('-dtiff', '-r300', savetiff); end
        if png ==1, print('-dpng', '-r300', savepng); end
        close;
    end
end