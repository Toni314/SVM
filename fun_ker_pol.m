function J = fun_ker_pol(alfa)
%XX conjunto de datos
%n observaciones en filas
%d dimensiones en columnas

%x nuevo punto d-dimensional(vertical)
%parametros alfa y b
%parametros delta y g de la función k(x,y)
global xpos; global xneg;
global ypos; global yneg;
global x;
global g;
global delta;


% display('grado del polinomio')
% g
% display('traslación del polinomio')
% delta

% XX=[[xpos;ypos]';[xneg;yneg]'];

X=[[xpos;ypos]';[xneg;yneg]'];

n=size(X,1);
Y=[ones(size(xpos,2),1);-ones(size(xneg,2),1)];

% z = (alfa,delta,g)

% J=0;
% for(i=1:n)
%     J=J+alfa(i)*(x'*(XX(i,:))'+delta)^g;
% end
K=zeros(n,n);

for(i=1:n)
    for(j=1:n)
        K(i,j)=(delta+X(i,:)*(X(j,:)'))^g;
    end
end
 K
J=0.5*(alfa.*Y)'*K*(Y.*alfa)-sum(alfa);

end
