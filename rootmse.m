function rootmse()
% Root mean square



idt = 10;
Resultado = Results(idt+1).estado(1,:);
data = datapd(UsedData, idt, 20);
Esperado = data(:,end);
n= size(Resultado, 2);

Residuos  = (Resultado - Esperado').^2;
RMS = sqrt(sum((Resultado - Esperado').^2)/n)

plot(Residuos);

end