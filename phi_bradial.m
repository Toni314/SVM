function [ phi ] = phi_bradial( delta,x )

%Recordemos, k(x,z)=exp(-delta * norma ( x-z) ^2 )

%Hay que ver si existe phi: R^d --> R^q tal que k(x,z)=phi(x)^t*phi(z)

%Es necesario q=Inf, pues la exponencial ya no es un
%polinomio sino que se puede entender como una expresi�n mediante serie de
%Taylor

%Aun as�, se podr�a encontrar una aproximaci�n tan buena como queramos,
%pues k es una funci�n anal�tica
%Tomamos el espacio de llegada R^q, q tan grande como sea necesario

%No es un problema trivial, y habr�a que pensarlo con detenimiento para
%encontrar una buena soluci�n.

end

