%% Boomerang
clear;
clc;
%% Notas
%ir a: http://www.mexder.com.mx/wb3/wb/MEX/boletin_diario
%dar click en:  Boletín Diario de Transacciones del Mercado de Futuros
%Descargar el PDF
%ir a https://www.ilovepdf.com/es 
%transfomar e PDF a excel
%En el excel, buscar los datos que corresponden a:
%"FUTUROS SOBRE TIIE 28 DIAS / 28 DAY INTERBANK EQUILIBRIUM INTEREST RATE FUTURES"
%importar esos datos a MATLAB
%Para ver la volatilidad ir a: https://www.investing.com/currencies/usd-mxn
%% Curva de Tasas
FuturosTiie = xlsread('/Users/pablomendoza/Documents/ITESO/PAP_Riesgos_y_Coberturas/MATLAB/Exceles para Matlab/Boletina.xlsx','Hoja1','C3:C122')/100;   %
Fechas = xlsread('/Users/pablomendoza/Documents/ITESO/PAP_Riesgos_y_Coberturas/MATLAB/Exceles para Matlab/Boletina.xlsx','Hoja1','A3:A122');            %Fechas de Vencimiento
Dates = x2mdate(Fechas,0);    
FechaInicio = '13-jun-2018'; %Fecha inicio del año
Reset = 12; %Numero de pagos al año
Basis = 2; %Convención de días (2 = 360) si es ISDA utilizar 12(365 días)
[cupocero, fechascurva] = fwd2zero(FuturosTiie,Dates,FechaInicio,Reset,Basis);
CurvaTasas = intenvset('Rates',cupocero,'EndDates',fechascurva,'StartDates',FechaInicio);
%% KO put
montodividendo = .0285;%tasa moneda extranjera
precio=19.47;
volatilidad= .1452;
detallesuby = stockspec(volatilidad,precio,('continuous'),montodividendo); %detalles del subyacente stockspec
opttipo = 'put';
strike=19.70
settle = '03-jul-2018'; %fecha en que se valuo
fechaejercicio = '30-nov-2018';
barreratipo = 'UO'; %TIPO DE barrera que es DO=DOWN&OUT,UO=UP&OUT,DI=DOWN&IN,UI=UP&IN
barrera = 20.30;
primaKOCall= barrierbybls(CurvaTasas,detallesuby,opttipo,strike,settle,fechaejercicio,barreratipo,barrera)
%% KI PUT
montodividendo = .0191;%tasa moneda extranjera
precio=19.47;
volatilidad= .1452;
detallesuby = stockspec(volatilidad,precio,('continuous'),montodividendo); %detalles del subyacente stockspec
opttipo = 'put';
strike=20
settle = '03-jul-2018'; %fecha en que se valuo
fechaejercicio = '27-jul-2018';
barreratipo = 'UI'; %TIPO DE barrera que es DO=DOWN&OUT,UO=UP&OUT,DI=DOWN&IN,UI=UP&IN
barrera = 20.30;
primaKOCall= barrierbybls(CurvaTasas,detallesuby,opttipo,strike,settle,fechaejercicio,barreratipo,barrera)
%% RKI CALL SHORT
montodividendo = .0285;%tasa moneda extranjera
precio=19.47;
volatilidad= .1454;
detallesuby = stockspec(volatilidad,precio,('continuous'),montodividendo); %detalles del subyacente stockspec
opttipo = 'call';
strike=20
settle = '03-jul-2018'; %fecha en que se valuo
fechaejercicio = '30-nov-2018';
barreratipo = 'UI'; %TIPO DE barrera que es DO=DOWN&OUT,UO=UP&OUT,DI=DOWN&IN,UI=UP&IN
barrera = 20.30;
primaKOCall= barrierbybls(CurvaTasas,detallesuby,opttipo,strike,settle,fechaejercicio,barreratipo,barrera)



