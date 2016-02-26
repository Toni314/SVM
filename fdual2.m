function J = fdual2( z,xpos,xneg,Y,C)
    X=[xpos;xneg]
    n=size(X,1);
    eps=z(n+1:2*n);
    alfa=z(1:n);
    J=0.5*(alfa.*Y)'*X*(X')*(Y.*alfa)-sum(alfa)+C*sum(eps);
end