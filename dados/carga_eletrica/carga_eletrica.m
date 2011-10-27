function [serie_trval, serie_teste, series_selecionadas] = carga_eletrica(serie_alvo,limiar_corr,flag)
%Seleciona as s�ries a serem analisadas
%serie_alvo: linha da matriz contendo a serie alvo. Se zero, utiliza-se o valor m�ximo
%limiar_corr: valor da correla��o para selecionar a s�rie explicativa (se zero, utiliza-se a correla��o com a temperatura)

%Carrega os dados
carga_97=load('carga_97.txt');
carga_98=load('carga_98.txt');
carga_99=load('carga_jan99.txt');
temperatura_97=load('temperatura_97.txt');
temperatura_98=load('temperatura_98.txt');
temperatura_jan99=load('temperatura_jan99.txt');

periodo=2;
switch periodo
    case 1
    %Serie teste � janeiro
    ajuste_inicial=16;%Numero de amostras necess�rias para se compor o modelo e n�o precisar estimar as condi��es iniciais
    serie_trval_completa=[carga_97;carga_98]';
    serie_teste_completa=[carga_98(end-ajuste_inicial:end,:);carga_99]';
    temperatura_trval=[temperatura_97;temperatura_98]';
    temperatura_teste=[temperatura_98(end-ajuste_inicial:end,:);temperatura_jan99]';
    case 2
    %Serie teste � 98
    serie_trval_completa=[carga_97]';
    serie_teste_completa=[carga_98]';
    temperatura_trval=[temperatura_97]';
    temperatura_teste=[temperatura_98]';
end

switch flag
    case 'maximo'
    serie_trval=[temperatura_trval; max(serie_trval_completa)];
    serie_teste=[temperatura_teste; max(serie_teste_completa)];  
    series_selecionadas=['max'];
    case 'manual'%Series_selecionadas manualmente
    series_selecionadas=[37 38 39 40 41 42 43];
    serie_trval=[temperatura_trval; serie_trval_completa(series_selecionadas,:)];
    serie_teste=[temperatura_teste; serie_teste_completa(series_selecionadas,:)];
    case 'correlacao'
    c=corrcoef(serie_trval_completa');
    if limiar_corr ==0
        c=corrcoef([serie_trval_completa;temperatura_trval]');limiar_corr=abs(c2(1,49));%para o caso de sele��o pelo nivel de correlacao com a temperatura
    end

    k=0;
    for i=1:size(c,1);
        corr=abs(c(serie_alvo,i));
        if corr>abs(limiar_corr)
            if i~=serie_alvo
            k=k+1;
            serie(k,:)=serie_trval_completa(i,:);
            seriet(k,:)=serie_teste_completa(i,:);
            serie_select(k,1)=i;
            end
        end
    end
    serie_trval=[serie_trval_completa(serie_alvo,:);serie;temperatura_trval];
    serie_teste=[serie_teste_completa(serie_alvo,:);seriet; temperatura_teste];
    series_selecionadas=[serie_alvo;serie_select;size(serie_trval_completa,1)+1];   
end

