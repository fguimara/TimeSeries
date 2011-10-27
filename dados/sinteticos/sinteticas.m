function [serie_trval, serie_teste] = sinteticas(flag_fontes)
%Retorna as s�ries sint�ticas. 
%Se 0,utilizam-se as misturas.
%Se flag_fontes=1,utilizam-se as fontes. 
%Se 2, utiliza-se a s�rie unica com outliers. 
%Se 3, utilizam-se todas com outliers em trval+teste. 
%Se 4, utilizam-se todas com out em teste
%Se 5, utilizam-se as misturas antigas, que foram utilizadas em algumas an�lises e trabalhos
%Se 6, utilizam-se as fontes antigas


load('fontes_sinteticas.txt');
load('fontes_antigas.txt');
%load('matriz_mistura.txt');
load('sinais_sinteticos.txt');
load('sinais_sinteticos_antigos.txt');
load('serie_unica.txt');
load('serie_unica_out.txt');
load('sinais_sinteticos_out_trval_teste.txt');
load('sinais_sinteticos_outeste.txt');

switch flag_fontes
    case 0
    serie_trval=sinais_sinteticos(:,1:500);
    serie_teste=sinais_sinteticos(:,500+1:end);%Sinais sinteticos
    case 1
    serie_trval=fontes_sinteticas(:,1:500); 
    serie_teste=fontes_sinteticas(:,500+1:end);%ICA ideal
    case 2
    serie_trval=serie_unica_out(:,1:500);%Treino com a parte limpa
    serie_teste=serie_unica_out(:,500+1:end);%Teste com a parte suja
    case 3
    serie_trval=sinais_sinteticos_out_trval_teste(:,1:500);%Treino com a parte limpa
    serie_teste=sinais_sinteticos_out_trval_teste(:,500+1:end);%Teste com a parte suja
    case 4
    serie_trval=sinais_sinteticos_outeste(:,1:500);%Treino com a parte limpa
    serie_teste=sinais_sinteticos_outeste(:,500+1:end);%Teste com a parte suja
    case 5
    serie_trval=sinais_sinteticos_antigos(:,1:250);
    serie_teste=sinais_sinteticos_antigos(:,250+1:end);%Sinais sinteticos
    case 6
    serie_trval=fontes_antigas(:,1:250); 
    serie_teste=fontes_antigas(:,250+1:end);%ICA ideal
end

end

