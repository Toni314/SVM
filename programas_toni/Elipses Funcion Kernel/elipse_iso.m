function  f  = elipse_iso( x,y,w,b,lambda1,lambda2,theta )
x=x-lambda1;
y=y-lambda2;
xaux=x*cos(theta)+y*sin(theta);
y=-x*sin(theta)+y*cos(theta);
x=xaux;


f=w(1)*x*x+w(2)*sqrt(2)*x*y+w(3)*y*y - b;
end

