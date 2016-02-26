%Ejercicio 4
function [exitflag,w,b1,b2] = resuelve_elipse2( xpos,ypos,xneg,yneg)
global x;
global clase;

V1=[xpos xneg]'
V2=[ypos yneg]'
Y=[ones(size(xpos,2),1); -ones(size(xneg,2),1)]

%Hacer optimtool con elipse_trans_dual para obtener las alfas

%Obtenemos los resultados
n=length(Y);
alfa=0.1*ones(1,n);
@(alfa)(elipse_trans_dual2(V1,V2,Y,alfa))
[alfa,fval,exitflag]=fmincon(@(alfa)(elipse_trans_dual2(V1,V2,Y,alfa)),alfa',[],[],Y',0,zeros(1,n),[])

if(exitflag==0)
    w=0;b1=0;b2=0;
    return;
end
pos=size(xpos,2);
neg=size(xneg,2);

z=trans2(V1,V2);
figure(2);
hold on;
plot3(z(1:pos,1)',z(1:pos,2)',z(1:pos,3)','r+');
plot3(z(pos+1:n,1)',z(pos+1:n,2)',z(pos+1:n,3)','go');
hold off;

%Calculo de w (generalizar)
w=(Y.*alfa)'*z;

ind1=0;
mmin=Inf;
mmax=-Inf;
ind2=0;

%Tomamos el indice que tiene alfa máximo, de los de categoria -1
%Tomamos el indice que tiene alfa mínimo, de los de categoria +1

for i=1:n
    if abs(alfa(i)) > 0.001
        if Y(i)==1 && alfa(i) < mmin
            mmin=alfa(i);
            ind1=i;
        end
        if Y(i)==-1 && alfa(i) > mmax
            mmax=alfa(i);
            ind2=i;
        end        
    end
end

b1=w*z(ind1,:)';
b2=w*z(ind2,:)';

b=(b1+b2)/2;

%Dibujar

figure(2);
hold on;
clc;
xx=-10:.1:10;
[XX,YY] = meshgrid(xx);

ZZ=(b- w(1) * XX - w(2) * YY)/w(3);
surf(XX,YY,ZZ)
shading flat
xlabel('z1'); ylabel('z2'); zlabel('z3')

hold off;

hold on;
global dibujo;
axes(dibujo);
cuadra(xpos,ypos,xneg,yneg);

plot(xpos,ypos,'+r',xneg,yneg,'go');
ezplot(@(x1,x2)elipse(x1,x2,w,b));
setcurve('color','red','linestyle','-','linewidth',2);
ezplot(@(x1,x2)elipse(x1,x2,w,b1));
setcurve('color','blue','linestyle','-','linewidth',1);
ezplot(@(x1,x2)elipse(x1,x2,w,b2));
setcurve('color','blue','linestyle','-','linewidth',1);

title('');
legend('positivos','negativos','Separador', 'Franjas');

hold off;


%Clasifica
if(w(1)*x(1)+w(2)*x(2)<b)
    clase=-1;
elseif(w(1)*x(1)+w(2)*x(2)>b)
    clase=+1;
else
    clase=0;
end