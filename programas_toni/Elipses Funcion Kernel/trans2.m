%Cambiar a n en general (no solo n=10)
function  z  = trans2(V1,V2)
    x=[V1,V2];
    z(:,1)=x(:,1).*x(:,1);
    z(:,2)=sqrt(2)*x(:,1).*x(:,2);
    z(:,3)=x(:,2).*x(:,2);
end
