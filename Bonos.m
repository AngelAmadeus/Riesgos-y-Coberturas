%% Bono
clear all
clc
%notas
%% Bono
precio = bndprice(.0781,.085,today,'05-jun-2027');
disp(['Precio del Bono: ',num2str(precio)])