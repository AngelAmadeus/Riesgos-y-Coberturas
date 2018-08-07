%% Range Forward de Compra
clear all
clc
%% Notas
%ir a: http://www.mexder.com.mx/wb3/wb/MEX/boletin_diario
%dar click en:  Boletín Diario de Transacciones del Mercado de Futuros
%Descargar el PDF
%ir a https://www.ilovepdf.com/es 
%transfomar e PDF a Excel
%En el Excel, buscar los datos que corresponden a:
%"FUTUROS SOBRE TIIE 28 DIAS / 28 DAY INTERBANK EQUILIBRIUM INTEREST RATE FUTURES"
%importar esos datos a MATLAB, utilizar plantilla boletina.
%% Curva de Tasas
FuturosTiie = xlsread('/Users/pablomendoza/Documents/ITESO/PAP_Riesgos_y_Coberturas/MATLAB/Exceles para Matlab/Boletina.xlsx','Hoja1','C3:C122')/100;
Fechas = xlsread('/Users/pablomendoza/Documents/ITESO/PAP_Riesgos_y_Coberturas/MATLAB/Exceles para Matlab/Boletina.xlsx','Hoja1','A3:A122'); %Fechas de Vencimiento
Dates = x2mdate(Fechas,0);    
FechaInicio = '23-may-2018'; %Fecha inicio del año
Reset = 12; %Numero de pagos al año
Basis = 2; %Convención de días (2 = 360) si es ISDA utilizar 12(365 días)
[cupocero, fechascurva] = fwd2zero(FuturosTiie,Dates,FechaInicio,Reset,Basis);
CurvaTasas = intenvset('Rates',cupocero,'EndDates',fechascurva,'StartDates',FechaInicio);
%% Long Call
precio = 19.88;%precio spot del subyacente
strike = [19.75];%precio de ejercicio
tasa = 0.0789; %tasa libre de riesgo
tiempo = [90/360]; %tiempo expresado en años
volatilidad = 0.1468; %volatilidad implicita
yield = 0.0193; %tasa de dividendos o en tipo de cambio rf de la otra moneda 
[primacall] = blsprice(precio,strike,tasa,tiempo,volatilidad,yield);
disp(['Prima Long Call: ',num2str(primacall)])
%% Short Put
precio = 19.88;%precio spot del subyacente
strike = [19.75];%precio de ejercicio
tasa = 0.0789; %tasa libre de riesgo
tiempo = [90/360]; %tiempo expresado en años
volatilidad = 0.1468; %volatilidad implicita
yield = 0.0193; %tasa de dividendos o en tipo de cambio rf de la otra moneda 
[primacall primaput] = blsprice(precio,strike,tasa,tiempo,volatilidad,yield);
disp(['Prima Short Put: ',num2str(primaput)])
%% Digitales
vol=0.1610;
vol2=0.1450;
precioactivo = 19.89;
montodividendo = 0.0193;%tasa moneda extranjera
detallesuby = stockspec(vol,precioactivo,('continuous'),montodividendo); %detalles del subyacente stockspec
detallesuby2 = stockspec(vol2,precioactivo,('continuous'),montodividendo); %detalles del subyacente stockspec
strike = 21.30;
strike2 = 18.90;
settle = '25-jun-2018'; %fecha en que se valuo
fechaejercicio = '25-sep-2018';
opttipo = 'call';
opttipo2 = 'put';
payoff= 1;
payoff2 = 1;
calldigital = (cashbybls(CurvaTasas,detallesuby,settle,fechaejercicio,opttipo,strike,payoff));
calldigital2 = (cashbybls(CurvaTasas,detallesuby2,settle,fechaejercicio,opttipo2,strike2,payoff2));
disp(['Call Digital 1: ',num2str(calldigital)])
disp(['Call Digital 2: ',num2str(calldigital2)])

