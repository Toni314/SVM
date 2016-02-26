function [exitflag,w,b1,b2] = resuelve_elipse3( xpos,ypos,xneg,yneg)
%global V1;
V1=[xpos xneg]';
%global V2;
V2=[ypos yneg]';
%global Y;
Y=[ones(size(xpos,2),1); -ones(size(xneg,2),1)]';

%Hacer optimtool con elipse_trans_dual para obtener las alfas

%Obtenemos los resultados
n=length(Y)
alfa=0.1*ones(1,n)
lambda1=0;lambda2=0;theta=0;
sol=[alfa,lambda1,lambda2,theta];
alfas=[alfa,lambda1,lambda2]
fun1=@(alfas)(elipse_trans_dual5(V1,V2,Y,alfas))

[alfas,fval,exitflag]=fmincon(@(alfas)elipse_trans_dual5(V1,V2,Y,alfas),0.1*ones(1,n+2),[],[],[Y,0,0],0,[zeros(1,n),-100,-100],100*ones(1,n+2))
alfa=alfas(1:n);
lambda1=alfas(n+1);
lambda2=alfas(n+2);

% if(exitflag~=1)
%     w=0;b1=0;b2=0;
%     return;
% end

z=trans2(V1,V2);

%Calculo de w (generalizar)
Y=Y(1:n);
w=(Y.*alfa)*z;

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
%axis([-1 4 -1 4]);
hold on;
plot(xpos,ypos,'+r',xneg,yneg,'go');
ezplot(@(x1,x2)elipse_iso(x1,x2,w,b,lambda1,lambda2,theta));
setcurve('color','red','linestyle','-','linewidth',2);
ezplot(@(x1,x2)elipse_iso(x1,x2,w,b1,lambda1,lambda2,theta));
setcurve('color','blue','linestyle','-','linewidth',1);
ezplot(@(x1,x2)elipse_iso(x1,x2,w,b2,lambda1,lambda2,theta));
setcurve('color','blue','linestyle','-','linewidth',1);

title('Separación Elipse Datos d');
legend('positivos','negativos','Separador', 'Franjas');

end

