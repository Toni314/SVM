function alfa = dual_pol(C)
global xpos;
global ypos;
global xneg;
global yneg;
global g;
g=2;

X=[[xpos;ypos]';[xneg;yneg]'];

n=size(X,1);
Y=[ones(size(xpos,2),1);-ones(size(xneg,2),1)];




%alfa=ones(8,1);
%0.5*(alfa.*Y)'*X*(X')*(Y.*alfa)-sum(alfa)
%fundual1(ones(8,1))
 

%Calculamos alfa con optimtools y nos da:
x0=0.1*ones(n,1);
alfa=zeros(n,1);
delta0=0.0;
lb=zeros(n,1);
ub=C*ones(n,1);
z0=[x0;delta0];
zlb=[lb;-Inf];
zub=[ub;Inf];
zeq=[Y',0];

zopt=fmincon(@(z)(fun_ker_pol(z)),z0,[],[],zeq,0,zlb,zub);

alfa=zopt(1:n)
delta=zopt(n+1)


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

Valor=zeros(n,1);


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
Valor

% A continuación se representan los valores en que la función de
% clasificación es igual a 0
xmin=min(min(xpos),min(xneg));
ymin=min(min(ypos),min(yneg));
xmax=max(max(xpos),max(xneg));
ymax=max(max(ypos),max(yneg));

%   Límites del gráfico
xinf=xmin-0.3*(xmax-xmin)
xsup=xmax+0.3*(xmax-xmin)
yinf=ymin-0.3*(ymax-ymin)
ysup=ymax+0.3*(ymax-ymin)

axis([xinf xsup yinf ysup]);
hold on;

plot(xpos,ypos,'+r',xneg,yneg,'bo');

delx=(xsup-xinf)/100;
dely=(ysup-yinf)/100;
for x1=xinf:delx:xsup
    %   Se recorren los valores de la abscisa
    for y1=yinf:dely:ysup
        zz=kernel_pol([x1,y1],n,X,Y,alfa,delta,g,vmed);
        if abs(zz)< 0.2
%             [x1,y1]
            plot(x1,y1,'or');
        end
    end
end
      


hold off;