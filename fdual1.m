function J = fdual1( alfa,xpos,xneg,Y)
    X=[xpos;xneg]
    J=0.5*(alfa.*Y)'*X*(X')*(Y.*alfa)-sum(alfa);
    X*(X')
end
