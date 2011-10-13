% Teste de paralelizacao
%
tic;
parfor r=1:10
    i = 0;
    for a=1:20
        i=i+1
        sin(i+a);
    end
end
toc;
tic;
for r=1:10
    i=0;
    for a=1:20
        i=i+1;
        sin(i+a);
    end
end
toc;
