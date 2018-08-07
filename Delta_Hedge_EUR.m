%% Delta Hedge EUR
clc;
clear all;
%% Concepto
% Indica la cantidad de activos subyacentes necesaria para que estén cubiertos los beneficios o 
% las pérdidas originados por las variaciones en el precio del subyacente. El nivel de cobertura 
% necesario ha de adaptarse continuamente a las oscilaciones de la cotización del subyacente 
% (delta-neutral, hedge dinámico, cobertura dinámica). 
%% Calculo
call = blsprice(23.77, 24.00, 0.0771 + 0.0062, 20/360, 0.1490);
disp(['Valor del Call: ',num2str(call)])
spots = [23.77;23.70;23.66;23.25;23.28;23.85;23.55;23.70;24.11;24.02;23.90;23.77;23.64;23.87;23.80;23.68;24.45;24.59;24.61;24.46;24.53];
call = zeros(1,20);
call(1) = blsprice(spots(1,1), 24.00, 0.0771 + 0.0062, 20/360, 0.1490);
delta = zeros(1,20);
delta(1) = blsdelta(spots(1,1), 24.00, 0.0771 + 0.0062, 20/360, 0.1490);
for i=1:19
    call(i+1) = blsprice(spots(i+1,1), 24.00, 0.0771 + 0.0062, (20-i)/360, 0.1490);
end
for i=1:19
    delta(i+1) = blsdelta(spots(i+1,1), 24.00, 0.0771 + 0.0062, (20-i)/360, 0.1490);
end
disp(['Valores del Call: ',num2str(call)])
disp(['Valores del Delta: ',num2str(delta)])