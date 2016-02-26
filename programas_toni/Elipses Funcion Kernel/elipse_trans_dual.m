function J  = elipse_trans_dual(nombre,alfa,n,h )
    [V1,V2,Y]=textread(nombre,'%f %f %f',n,'headerlines',h)
    x=[V1,V2]
    z(:,1)=x(:,1).*x(:,1)
    z(:,2)=sqrt(2)*x(:,1).*x(:,2)
    z(:,3)=x(:,2).*x(:,2)
    
    %Se maximiza -J, se minimiza J
    J=0.5*(alfa.*Y)'*z*(z')*(Y.*alfa)-sum(alfa)
end
