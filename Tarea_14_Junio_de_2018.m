%% Tarea para 14 de Junio de 2018
%% Primera Estrategia de Productos Estructurados
%Situación: Especulacion con un Range Forward
    % Cliente quiere hacer dinero, este piensa que el 
%Ventajas:
    %Es un producto que se puede hacer de costo 0
%Desventajas
    %Si el KO se cumple, el cliente saldrá perdiento, per tiene una noción
    %de lo máximo que puede llegar a perder
%Contrucción de la Estrategia:
    %Forward Sintetico
    %DNT 
%Datos:
    %Plazo: 6 meses
    %Spot al dia 13 de jun de 2018 = 20.65
    %Strike = 
%Calculos:
%
%% Segunda Estrategia de Productos Estructurados
%Situación: Cobertura con un Participating Forward
    % Cliente es una empresa que quiere cubrir un pago de 10 mdp que
    % recibirá en 6 meses. La empresa espera que una vez llegados los 6
    % meses el tipo de cambio MXN/USD se eleve. 
%Supuestos:
    %Comprar una vanilla es demasiado costoso en este momento para el
    %Strike que la empresa busca. Por lo que busca una alternativa con
    %menor costo aunque asuma mayor riesgo.
%Ventajas:
    %Se cubre totalmente a la alza del valor del USD
    %Es un producto que se puede hacer de costo 0
    %En caso de que el valor del USD vaya a la baja solo tendra que pagar
    %la mitad del nocional al precio pactado, y la otra mitad a precio de
    %mercado
%Desventajas
    %Asume riesgo si dentro de un año hay una baja en el valor de USD
%Contrucción de la Estrategia:
    %La empresa compra un call de USD con un nocional de 10 mdp
    %La empresa vende un put de USD con un nocional de 5 mdp
%Datos:
    %Plazo: 6 meses
    %Spot al dia 13 de jun de 2018 = 20.65
    %Strike = 21
    %Nocional: 10 mdd
    %Rango: 19-21.5
%Calculos:
%[call put]= blsprice(spot,strike,tasa mxn,plazo,vol-plazo-strike,vol usd);
