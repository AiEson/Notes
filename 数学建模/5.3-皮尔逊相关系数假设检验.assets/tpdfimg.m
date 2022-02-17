n = 30;
x = -4:0.0001:4;
y = tpdf(x, n - 2);
plot(x, y, '-')
grid on;
hold on;

idx=x>=-4&x<=-2.0484;
xi=x(idx); yi=y(idx);
fill([xi xi(end) xi(1)],[y(idx) 0 0],'m','facealpha',.2,'edgecolor','r')

idx=x>=2.0484&x<=4;
xi=x(idx); yi=y(idx);
fill([xi xi(end) xi(1)],[y(idx) 0 0],'m','facealpha',.2,'edgecolor','r')

idx=x>=-2.0484&x<=2.0484;
xi=x(idx); yi=y(idx);
fill([xi xi(end) xi(1)],[y(idx) 0 0],'b','facealpha',.2,'edgecolor','r')