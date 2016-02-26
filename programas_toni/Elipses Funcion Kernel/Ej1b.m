%Práctica 4
%Ejercicio 1
%Apartado b)

clear all;
close all;
%Restricciones
lb=[-Inf,0];
x0=[0,0];
%Modelo

options=optimset('Algorithm','sqp');
[z,val,flag]=fmincon(@fun_b,x0,[],[],[],[],lb,[],@restr_b,options)
