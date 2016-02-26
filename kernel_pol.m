function [ y ] = kernel_pol(x,n,X,Y,alfa,delta,g,cte)
%Función de clasificación del kernel polinómico de parámetros (delta,g)
 y=-cte;
 
 for i=1:n
     y=y+alfa(i)*Y(i)*(delta+X(i,:)*x')^g;
 end
end
