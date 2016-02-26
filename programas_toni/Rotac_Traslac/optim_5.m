function [yopt,fopt,exit]=optim_5()
%% función que determina las elipses estándar concéntricas con menor area 
%%  entre ellas de forma que unos datos (y=+1) están fuera de la exterior 
%%  y los otros (y=-1) están dentro de la interior
%   y   es la variable de decisión (y(1)=a, y(2)=b, que definen la elipse
%   estándar centrada en el (0,0) e y(3) es el valor de lambda que
%   multiplica a los parámetros (a,b) para obtener la elipse interior
%   y(4) es el ángulo de rotacion
%   y(5), y(6) son las coordenadas del centro de la elipse

%   f   es el valor de la función objetivo (el area de dicha elipse es a*b)
 y0=[1.5;0.9;0.5;2.;0.5;0.5];
%  fobj(y0)
%  nonlincon(y0)
%  x

%   cte_excen  es la penalización de la excentricidad de las elipses
cte_excen = pi;

 xneg=[-2.0, 0.; -0.5, 0.5; 1.2, 0.8;1.6, -0.4];
%     xpos son los datos exteriores de la elipse mayor (y=+1)
 xpos=[-4.0, 0.; -3.0, 2.0;-3.0, -2.0;1.0, -2.5; 1.5, 1.8; 4.5, 0.5];
    
 hold on;
 xlim([-7,7]);
 ylim([-7,7]);
    plot(xneg(:,1),xneg(:,2),'go');
    plot(xpos(:,1),xpos(:,2),'r+');
    
 
lb(1)=0.;
lb(2)=0.;
lb(3)=0.;
lb(4)=0;
lb(5)=-Inf;
lb(6)=-Inf;

ub=[100,100,1.0,2*pi,Inf,Inf];
 [yopt,fopt,exit]=fmincon(@fobj,y0,[],[],[],[],lb,ub,@nonlincon);
 

   
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

 plot(x,y,'b');
 plot(x2,y2,'b');
 
    
 function f=fobj(y)  % maximizar el area intermedia
   %f=-1*(y(1)*y(2)*(1-y(3)*y(3)));
   %f=-1*(y(1)*y(2)*(y(3)-1.0)^2);
   %f=-pi*(y(1)*y(2)*(1-y(3)*y(3)))+cte_excen*(y(1)-y(2))^2;
   f=y(3);
 end  
 function [c,ceq] = nonlincon(y)
%     xneg son los datos interiores de la elipse menor (y=-1)
    xneg=[-2.0 0; -0.5 0.5; 1.2 0.8;1.6 -0.4];
%     xpos son los datos exteriores de la elipse mayor (y=+1)
    xpos=[-4.0 0; -3.0 2.0;-3.0 -2.0;1.0 -2.5; 1.5 1.8; 4.5 0.5];
 hold on;
%     plot(xneg,'ro');
%     plot(xpos,'go');

xneg(:,1)=xneg(:,1)-y(5);
xneg(:,2)=xneg(:,2)-y(6);
xpos(:,1)=xpos(:,1)-y(5);
xpos(:,2)=xpos(:,2)-y(6);

xnegaux(:,1)=xneg(:,1)*cos(y(4))+xneg(:,2)*sin(y(4));
xnegaux(:,2)=-xneg(:,1)*sin(y(4))+xneg(:,2)*cos(y(4));

xposaux(:,1)=xpos(:,1)*cos(y(4))+xpos(:,2)*sin(y(4));
xposaux(:,2)=-xpos(:,1)*sin(y(4))+xpos(:,2)*cos(y(4));


    c = [xnegaux(:,1).^2 / y(1)^2 + xnegaux(:,2).^2 /y(2)^2 - y(3)^2; ...
        1- xposaux(:,1).^2 / y(1)^2 - xposaux(:,2).^2 /y(2)^2 ];
    ceq = [ ];
 end  
end
