[X1,X2] = ndgrid((-5:1:5));
R = sqrt(X1.^2 + X2.^2)+ eps;
V = sin(R)./(R);
size(V)
% 输出 ans = 11 11
Vq = interpn(V,'spline');
mesh(Vq);