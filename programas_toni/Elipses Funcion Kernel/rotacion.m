%Matriz de rotación general
function [ R ] = rotacion( ang,d )
%vector de angulos
%tiene dimension (n-1)*n/2
R=eye(d);
k=0;
for(i=1:d-1)
    for(j=i+1:d)
        k=k+1;
        %Plantearse resolución optima
%         A=eye(d);
%         A(i,i)=cos(ang(k));
%         A(j,j)=A(i,i);
%         A(i,j)=sin(ang(k));
%         A(j,i)=-A(i,j);
%         R=R*A;
        
        %Más optimo es producto de tridiagonal * rotacion
        %En su defecto, producto de matriz * rotacion
        aux=R;
        for(s=1:d)
            aux(s,i)=R(s,i)*cos(ang(k))+R(s,j)*(-sin(ang(k)));
            aux(s,j)=R(s,i)*sin(ang(k))+R(s,j)*cos(ang(k));
        end
        R=aux;
    end
end

end

