%% Opciones Digitales
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
%% Digitales
vol=0.1850;
vol2=0.1806;
precioactivo = 19.979;
montodividendo = 0.0114;%tasa moneda extranjera
detallesuby = stockspec(vol,precioactivo,('continuous'),montodividendo); %detalles del subyacente stockspec
detallesuby2 = stockspec(vol2,precioactivo,('continuous'),montodividendo); %detalles del subyacente stockspec
strike = 21.00;
strike2 = 22.50;
settle = '31-may-2018'; %fecha en que se valuo
fechaejercicio = '30-ago-2018';
opttipo = 'call';
payoff= 100000;
payoff2 = 50000;
primacalldigital1 = (cashbybls(CurvaTasas,detallesuby,settle,fechaejercicio,opttipo,strike,payoff));
primacalldigital2 = (cashbybls(CurvaTasas,detallesuby2,settle,fechaejercicio,opttipo,strike2,payoff2));
disp(['Prima Call Digital 1: ',num2str(primacalldigital1)])
disp(['Prima Call Digital 2: ',num2str(primacalldigital2)])