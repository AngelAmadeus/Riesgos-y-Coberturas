%% Ejercicios del 13 junio de 2018
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
%% Ejercicio 1
%Situacion: 1mdp a 1 mes.
%[call put]= blsprice(spot,strike,tasa mxn,plazo,vol-plazo-strike,vol usd);
Nocional = 1000000;
[call put] = blsprice(20.65,20.76,0.0783,30/360,0.1772,0.018);
call = call*Nocional;
put = put*Nocional;
final = call-put;
disp(['Ejercicio 1:'])
disp(['Prima: ',num2str(final)])
disp([' '])
%% Ejercicio 2
%Situacion: Participating Forward de Compra, hay que hacerlo costo 0
%Yo soy el banco
%Cliente compra un put(banco vende) y Vende un RKI (banco compra)
%Ajustar los numeros (Barrera y/o strike) para obtenerlo en costo 0
%Es a 3 meses
%Decir donde esta el Strike y la barrera
%(Recordar que el Strike es el mismo para el call y put

%Barrera
Vol = 0.1554; %Volatilidad Call
Vol2 = 0.1554; %Volatilidad Put
PrecioActivo = 20.65;
MontoDividendo = 0.0194; %Tasa de moneda extranjera
DetalleSuby = stockspec(Vol,PrecioActivo,{'continuous'},MontoDividendo); %Detalle del subyacente StockSpec
DetalleSubyp = stockspec(Vol2,PrecioActivo,{'continuous'},MontoDividendo); %Detalle del subyacente StockSpec
Opttipo = 'call'; %Tipo de opción que es 'call' ó 'put'
Opttipo2 = 'put'; %Tipo de opción que es 'call' ó 'put'
Strike = 21.00;
Settle = '13-jun-2018'; %Fecha en que se valuó
FechaEjercicio = '13-sep-2018';
BarreraTipo = 'UI'; %tipo de barrera (DO=down&out,UO=uo&out,DI=down&in,UI=up&in)
Barrera = 21.30; %Nivel del precio que se quiere la barrera
primaKOCall = barrierbybls(CurvaTasas,DetalleSuby,Opttipo,Strike,Settle,FechaEjercicio,BarreraTipo,Barrera);
%Vanillas
[call_v put_v] = blsprice(20.65,Strike,0.0789,90/360,Vol,0.0194);
%Total
Total = primaKOCall - put_v;
disp(['Ejercicio 2:'])
disp(['Prima: ',num2str(Total)])
disp(['Strike en: ',num2str(Strike)])
disp(['Barrera en: ',num2str(Barrera)])