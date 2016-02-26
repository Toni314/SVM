function [yopt,fopt,exit]=polinomica_tr(M,V)
% A contiene constantes que dependen de los valores que les pongamos en
% svm.fig

%flag=(f1,f2) con f1,f2 valores binarios
%f1 determina si hay o no rotación
%f2 determina si hay o no traslación

%nombre contiene el string del nombre del fichero a abrir

%% función que determina las elipses estándar concéntricas con menor area 
%%  entre ellas de forma que unos datos (y=+1) están fuera de la exterior 
%%  y los otros (y=-1) están dentro de la interior
%   y   es la variable de decisión (y(1)=a1, y(2)=a2,...,y(n)=a_n, que definen la elipse

%   estándar centrada en el (0,0) e y(n+1) es el valor de lambda que
%   multiplica a los parámetros (a,b) para obtener la elipse interior
%   y(n+2) hasta y(n+1 + (n-1)*n/2 ) es el vector de ángulos de rotacion
%   (eje a eje)

%   y(n+1 + (n-1)*n/2  + 1), ..., y(n+1 + (n-1)*n/2  + n ) son las coordenadas del centro de la elipse

% penalizaciones epsilon a partir de los siguientes (pendiente)

%   f   es el valor de la función objetivo (el area de dicha elipse es a*b)

%  fobj(y0)
%  nonlincon(y0)
%  x
n=size(M,1);
d=size(M,2);
[xpos,xneg,pos,neg]=separa(M,V);

y0=0.5*ones(d+1+(d-1)*d/2+d,1);
size(y0);
% %     xpos son los datos exteriores de la elipse mayor (y=+1)
% %     xneg son los datos exteriores de la elipse mayor (y=-1)

 hold on;

%n semiejes
lb=zeros(1,d);
%lambda
lb=[lb,0];
%angulos
lb=[lb,zeros(1,(d-1)*d/2)];
%centro
lb=[lb,-Inf*(ones(1,d))];

%idem con cota superior
ub=Inf*ones(1,d);
ub=[ub,1];
ub=[ub,2*pi*ones(1,(d-1)*d/2)];
ub=[ub,Inf*(ones(1,d))];



 [yopt,fopt,exit]=fmincon(@(y)(fobj(y,d)),y0,[],[],[],[],lb,ub,@(y)nonlincon(y,xneg,xpos));
 
 %Caso d=2
plot(xneg(:,1),xneg(:,2),'go');
plot(xpos(:,1),xpos(:,2),'r+');
 %Modificar a partir de aquí para representación
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
 
    
 function f=fobj(y,d)  % maximizar el area intermedia
     %lambda
    f=y(d+1);   
 end


 function [c,ceq] = nonlincon(y,xneg,xpos)
%     xneg son los datos interiores de la elipse menor (y=-1)
%     xpos son los datos exteriores de la elipse mayor (y=+1)
 hold on;
 d=size(xneg,2);
 %traslacion
 centro=y(d+1+(d-1)*d/2+1:d+1+(d-1)*d/2+d);
 
 pos=size(xpos,1);
 neg=size(xneg,1);
 for(i=1:pos)
    xpos(i,:)=xpos(i,:)-centro(:)';
 end
 for(i=1:neg)
    xneg(i,:)=xneg(i,:)-centro(:)';
 end
 
%rotacion
ang=y(d+2:d+1+(d-1)*d/2);
R=rotacion(ang,d)
xnegaux=xneg*R';
xposaux=xpos*R';

seje=y(1:d);
%Falta establecer las condiciones
c=[];
for(i=1:neg)
    a=(xnegaux(i,:).*xnegaux(i,:))*(1./(seje(:).*seje(:)))-y(d+1)*y(d+1);
    c = [c;a];
end
for(i=1:pos)
    a=1-((xposaux(i,:).*xposaux(i,:))*(1./(seje(:).*seje(:))));
    c=[c;a];
end
    
%     [xnegaux(:,1).^2 / y(1)^2 + xnegaux(:,2).^2 /y(2)^2 - y(3)^2; ...
%         1- xposaux(:,1).^2 / y(1)^2 - xposaux(:,2).^2 /y(2)^2 ];
    ceq = [ ];
 end
hold off;
end
