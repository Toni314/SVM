%(V1,V2,Y,alfa,lambda1,lambda2,theta);
function J  = elipse_trans_dual4(V1,V2,Y,alfas)
    %Transformacion de matriz de datos y calculo de z's
    n=size(V1,1);
    alfa=alfas(1:n);
    lambda1=alfas(n+1);
    lambda2=alfas(n+2);
    theta=alfas(n+3);
    x=[V1,V2]
    x=isometria(x,lambda1,lambda2,theta)
    
    z(:,1)=x(:,1).*x(:,1);
    z(:,2)=sqrt(2)*x(:,1).*x(:,2);
    z(:,3)=x(:,2).*x(:,2);
    
    %Se maximiza -J, se minimiza J
    J=0.5*(alfa.*Y')*z*(z')*(Y.*alfa')-sum(alfa);
end
