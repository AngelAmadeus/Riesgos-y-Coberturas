%% CALL & PUT Europeas (Para tipo de Cambio)
clear all;
clc;
%% Notas
%Ir a: https://www.investing.com/currencies/forex-options
%Seleccionar el tipo de opcion, en este caso se seleccionó USD/MXN
%El numero junto a USD/MXN es el "Precio" spot
%Se selecciona el periodo, que en este caso es de un mes (1M)=(30/360)
%En la columna de Strike, el primer valor corresponde al "Strike"
%Se investiga la tasa libre de riesgo de cetes a 180 días, se encuentra en: https://www.piplatam.com/Home/iPiP
%La volatiliadad implicita depende del strike y se encuentra en: https://www.investing.com/currencies/forex-options
%La tasa Yield, es decir la tasa extranjera se encuentra en: https://www.treasury.gov/resource-center/data-chart-center/interest-rates/Pages/TextView.aspx?data=yield
%
%% Datos
Precio = 19.775;            %precio spot del subyacente
Strike = [19.300];          %Precio de ejercicio (pactado)
Tasa = 0.0751;              %Tasa libre de riesgo (cetes 180 días)
Tiempo = [30/360];          %Tiempo expresado en años
Volatilidad = 0.1374;       %Volatilidad implícita
Yield = 0.0114;             %tasa de dividendos o en tipo de cambio RF de la otra moneda
%% Call y Put Europeas
[primaCall primaPut] = blsprice(Precio,Strike,Tasa,Tiempo,Volatilidad,Yield);
disp(['Prima del Call: ',num2str(primaCall)])
disp(['Prima del Put: ',num2str(primaPut)])