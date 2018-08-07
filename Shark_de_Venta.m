%% Shark de Venta
%Ejercicio del 3 de Julio de 2018
%Cubrir un nocional de 200 mil dólares por 5 meses
clear all;
clc;
format bank
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
%% Long Put Vanilla
precio = 19.47;%precio spot del subyacente
strike = 19.7;%precio de ejercicio
tasa = 0.0772; %tasa libre de riesgo
tiempo = 150/360; %tiempo expresado en años
volatilidad = .1454; %volatilidad implicita
yield = 0.0191; %tasa de dividendos o en tipo de cambio rf de la otra moneda 
[primacall primaput] = blsprice(precio,strike,tasa,tiempo,volatilidad,yield);
disp(['Put Vanilla: ',num2str(primaput)])
%% Short RKI Call
montodividendo = 0.0191; %tasa moneda extranjera
detallesuby = stockspec(volatilidad,precio,('continuous'),montodividendo); %detalles del subyacente stockspec
opttipo = 'call';
settle = '03-jul-2018'; %fecha en que se valuo
fechaejercicio = '30-nov-2018';
barreratipo = 'UI'; %TIPO DE barrera que es DO=DOWN&OUT,UO=UP&OUT,DI=DOWN&IN,UI=UP&IN
barrera = 20.30;
primaKOCall= barrierbybls(CurvaTasas,detallesuby,opttipo,strike,settle,fechaejercicio,barreratipo,barrera);
disp(['Prima KO Call: ',num2str(primaKOCall)])
%% Total
total = - primaput - primaKOCall ;
disp(['Precio Total: ',num2str(total)])