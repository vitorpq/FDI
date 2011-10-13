function [inicio fim xpts] = limtempo(xData)
%     XTick'       , xpts, ...
%     'XTickLabel'  , datestr(xpts, 'HH:MM'),...
%     'XLim'        , [xData(1) xData(end)+passo]);
    inicio = xData(1);
    c = datevec(xData(end));
    if c(5) > 30
        hora =  c(4) + 1;
        minuto = 0;
    else
        hora = c(4);
        minuto = c(5);
    end
    fim = datenum(strcat(int2str(hora), ':', int2str(minuto), ':00'));
    passo = datenum('00:30:00')-datenum('00:00:00');
    xpts = xData(1):passo:fim;
    if size(xpts,2) >= 10
        passo = datenum('01:00:00')-datenum('00:00:00');
        xpts = xData(1):passo:fim;
    end
    
end