function J = sigmoide(x,z,delta,delta0)
%funcion kernel base radial
%x, z vectores columna
J=tanh(delta*x'*z+delta0);
end