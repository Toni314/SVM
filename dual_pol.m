function alfa = dual_pol(C)
global xpos;
global ypos;
global xneg;
global yneg;
global g;
global delta;
global x;
global clase;

X=[[xpos;ypos]';[xneg;yneg]'];

n=size(X,1);
Y=[ones(size(xpos,2),1);-ones(size(xneg,2),1)]

%0.5*(alfa.*Y)'*X*(X')*(Y.*alfa)-sum(alfa) 

%Calculamos alfa con optimtools y nos da:
x0=100*ones(n,1);
alfa=zeros(n,1);
lb=zeros(n,1);
ub=C*ones(n,1);

alfa=fmincon(@(alfa)(fun_ker_pol(alfa)),x0,[],[],Y',0,lb,ub);

%   Determinación del borde de las clases +1 y -1

%   Primero se evalúa la función de clasificación en cada uno de los puntos
%   que construyen la máquina virtual:

%   Se determina el valor de la matriz K(i,j) del Kernel
K=zeros(n,n);
for(i=1:n)
    for(j=1:n)
        K(i,j)=(delta+X(i,:)*(X(j,:)'))^g;
    end
end
% Valor=zeros(n,1);
% 
% 
% Valor=K*(alfa.*Y)
% vmin=Inf;
% vmax=-Inf;
% for i=1:n
%     if Y(i)== 1
%         if Valor(i) < vmin
%             vmin=Valor(i);
%         end
%     else
%         if Valor(i) > vmax
%             vmax=Valor(i);
%         end
%     end
% end
Valor=zeros(n,1)


Valor=K*(alfa.*Y)
vmin=Inf;
vmax=-Inf;
for i=1:n
    if Y(i)== 1
        if Valor(i) < vmin
            vmin=Valor(i);
        end
    else
        if Valor(i) > vmax
            vmax=Valor(i);
        end
    end
end


vmin
vmax
vmed=(vmin+vmax)/2.0

%   Se añade el valor medio para definir la función de clasificación
for i=1:n
    Valor(i)=kernel_pol(X(i,:),n,X,Y,alfa,delta,g,vmed);
end
Valor;

% A continuación se representan los valores en que la función de
% clasificación es igual a 0
[xinf,xsup,yinf,ysup]=cuadra(xpos,ypos,xneg,yneg);

plot(xpos,ypos,'+r',xneg,yneg,'bo');
legend('Positivos','Negativos');

delx=(xsup-xinf)/100;
dely=(ysup-yinf)/100;
for x1=xinf:delx:xsup
    %   Se recorren los valores de la abscisa
    for y1=yinf:dely:ysup
        zz=kernel_pol([x1,y1],n,X,Y,alfa,delta,g,vmed);
        if abs(zz)< 0.1
%             [x1,y1]
            plot(x1,y1,'or');
        end
    end
end

hold off;
%Clasifica
if(kernel_pol([x(1),x(2)],n,X,Y,alfa,delta,g,vmed)<0)
    clase=-1;
elseif(kernel_pol([x(1),x(2)],n,X,Y,alfa,delta,g,vmed)>0)
    clase=+1;
else
    clase=0;
end
end