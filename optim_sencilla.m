function [yopt,fopt,exit]=optim_sencilla(y)
%% función sencilla no lineal con restricciones no lineales a optimizar
%   y   es la variable de decisión
%   f   es el valor de la función objetivo
 y0=[1.5;0.9]
%  fobj(y0)
%  nonlincon(y0)
%  x
 
 [yopt,fopt,exit]=fmincon(@fobj,y0,[],[],[],[],[],[],@nonlincon);

 function f=fobj(y)
    f=y(1)*y(2);
 end  
 function [c,ceq] = nonlincon(y)
%     x=zeros(4,2);
    x=[-2.0 0; -0.5 0.5; 1.2 0.8;1.6 -0.4];
    c = [x(:,1).^2 / y(1)^2 + x(:,2).^2 /y(2)^2 - 1.0];
    ceq = [ ];
 end  
end