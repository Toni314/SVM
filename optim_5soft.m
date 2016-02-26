function [yopt,fopt,exit]=optim_5soft(A,C, flag, xpos,xneg)
% A contiene constantes que dependen de los valores que les pongamos en
% svm.fig

%flag=(f1,f2) con f1,f2 valores binarios
%f1 determina si hay o no rotación
%f2 determina si hay o no traslación

%nombre contiene el string del nombre del fichero a abrir

%% función que determina las elipses estándar concéntricas con menor area 
%%  entre ellas de forma que unos datos (y=+1) están fuera de la exterior 
%%  y los otros (y=-1) están dentro de la interior
%   y   es la variable de decisión (y(1)=a, y(2)=b, que definen la elipse
%   estándar centrada en el (0,0) e y(3) es el valor de lambda que
%   multiplica a los parámetros (a,b) para obtener la elipse interior
%   y(4) es el ángulo de rotacion
%   y(5), y(6) son las coordenadas del centro de la elipse

% penalizaciones epsilon a partir de y(7)

%   f   es el valor de la función objetivo (el area de dicha elipse es a*b)

%  fobj(y0)
%  nonlincon(y0)
%  x


%fit=fopen(nombre,'r');
%n=fscanf(fit,'%d')
%[xpos(:,1), xpos(:,2), xneg(:,1),xneg(:,2)]=leer(nombre,n,2);

n=size(xpos,1)+size(xneg,1);

y0=0.5*ones(6+n,1);
% %     xpos son los datos exteriores de la elipse mayor (y=+1)
% %     xneg son los datos exteriores de la elipse mayor (y=-1)

 hold on;
%  xlim([-7,7]);
%  ylim([-7,7]);
    plot(xneg(:,1),xneg(:,2),'go');
    plot(xpos(:,1),xpos(:,2),'r+');
    
lb=[0,0,0,0,-Inf,-Inf];
lb=[lb,zeros(1,n)];
ub=[10,10,1.0,2*pi,Inf,Inf];
ub=[ub,C*ones(1,n)];
%flag 2, traslacion
if(flag(2)==0)
    lb(5)=0;
    lb(6)=0;
    ub(5)=0;
    ub(6)=0;
end

%flag 1, rotacion
if(flag(1)==0)
    ub(4)=0;
end

[yopt,fopt,exit]=fmincon(@fobj,y0,[],[],[],[],lb,ub,@(y)nonlincon(y,xneg,xpos));
if(exit~=1)
    yopt=zeros(1,n+6); fopt=0;
    open('error1.fig');
end
  t = linspace(0,2*pi);
  xaux=yopt(1)*cos(t);
  yaux=yopt(2)*sin(t);
  xaux2=xaux*yopt(3);
  yaux2=yaux*yopt(3);
  %Rotacion + traslacion

  x=xaux*cos(-yopt(4))+yaux*sin(-yopt(4));
  y=-xaux*sin(-yopt(4))+yaux*cos(-yopt(4));
  x=x+yopt(5);
  y=y+yopt(6);
  
  x2=xaux2*cos(-yopt(4))+yaux2*sin(-yopt(4));
  y2=-xaux2*sin(-yopt(4))+yaux2*cos(-yopt(4));  
  x2=x2+yopt(5);
  y2=y2+yopt(6);  

 plot(x,y,'g');
 plot(x2,y2,'r');
 
 function f=fobj(y)  % maximizar el area intermedia
   %f=-1*(y(1)*y(2)*(y(3)-1.0)^2);
   n=length(y)-6;
   eps=y(7:n+6);
   f=-pi*(y(1)*y(2)*(1-y(3)*y(3)))+A(1)*abs(y(1)-y(2))+C*(sum(eps));
   %Cuanto más grande es C, más pequeños deben ser las epsilon
 end


 function [c,ceq] = nonlincon(y,xneg,xpos)
%     xneg son los datos interiores de la elipse menor (y=-1)
%     xpos son los datos exteriores de la elipse mayor (y=+1)

cuadra(xpos(:,1),xpos(:,2),xneg(:,1),xneg(:,2));


xneg(:,1)=xneg(:,1)-y(5);
xneg(:,2)=xneg(:,2)-y(6);
xpos(:,1)=xpos(:,1)-y(5);
xpos(:,2)=xpos(:,2)-y(6);

xnegaux(:,1)=xneg(:,1)*cos(y(4))+xneg(:,2)*sin(y(4));
xnegaux(:,2)=-xneg(:,1)*sin(y(4))+xneg(:,2)*cos(y(4));

xposaux(:,1)=xpos(:,1)*cos(y(4))+xpos(:,2)*sin(y(4));
xposaux(:,2)=-xpos(:,1)*sin(y(4))+xpos(:,2)*cos(y(4));

n=length(y)-6;
eps=y(7:n+6);

%size(xnegaux,1);
%size(xposaux,1);
%eps1(:)=eps(1:size(xnegaux,1));
%eps2(:)=eps(size(xnegaux,1)+1:n);

   c = [xnegaux(:,1).^2 / (y(3)^2*y(1)^2) + xnegaux(:,2).^2 /(y(3)^2*y(2)^2) - 1+eps(1:size(xnegaux,1)); ...
       1- xposaux(:,1).^2 / y(1)^2 - xposaux(:,2).^2 /y(2)^2-eps(size(xnegaux,1)+1:n) ];

    ceq = [ ];
 end
hold off;
end
