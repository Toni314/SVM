function J = brad(x,z,delta)
%funcion kernel base radial
%x, z vectores columna
J=exp(-delta*(x-z)'*(x-z));
end