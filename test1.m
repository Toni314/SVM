%test para ver funcionamiento de funciones recursivas
%suma de i hasta n
function [ i,n,k ] = test1( i,n,k )
if(i==n)
    return;
else
    i=i+1;
    k=k+i;
    test1(i,n,k)
end

end

