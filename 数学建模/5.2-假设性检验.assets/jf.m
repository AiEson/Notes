clear;clc
mu = 0;
sigma = 1;
pd = makedist('Normal','mu',mu,'sigma',sigma);
x =-2:0.01:2;
y = cdf(pd, x);

plot(x, y)
xlabel('x')
ylabel('y')
grid on

hold on;
ezplot('normcdf(x,0,1)');
fplot('norminv(x,0,1)',[0,1],'r');
fplot('x',[-pi,pi],'m:')
axis equal