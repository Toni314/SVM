function [ phi ] = phikernelp( x,g,a )
%con g=2, d=2 y a=0 se tiene el kernel de cónicas, que en R^2 son cónicas
%Caso 0
phi(1)=x(1)*x(1);
phi(2)=x(2)*x(2);
phi(3)=sqrt(2)*x(1)*x(2);

%Caso 1
%En general, para a=0, g=2, se tienen conicas, y
for(i=1:d)
    phi(i)=x(i)*x(i);
    
end
k=d;
for(i=1:d-1)
    for(j=i+1:d)
        k=k+1;
        phi(k)=sqrt(2)*x(i)*x(j);
    end
end
%Devuelve phi de d+(d-1)*d/2 componentes


%Caso 2

%En general, para a=0, d=2, estamos en el plano y tenemos polinomios de
%grado g, con todos los terminos de grado g
for(i=0:g)
    phi(i+2)=sqrt(nchoosek(g,i))*x(1)^i*x(2)^(g-i);
end

%recordemos que se trata de (x1+x2)^g=x1^g + x2^g + (g, 1)x1^(g-1)x2^g +
%...



%Caso 3(pendiente)
%Mas en general, para a=0 y d,g>=0 cualesquiera
%Debe existir una fórmula para encontrar la funcion phi




%Caso 4
%Lo más general, para a,d,g cualesquiera


end

