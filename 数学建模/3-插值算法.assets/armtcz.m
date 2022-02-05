% 定义 x 为步长为1，-pi到pi
x = -pi:pi;
% 定义 x 对应的 y
y = sin(x);
% 定义 new_x 步长变为 0.01
new_x = -pi:0.01:pi;
% 使用埃尔米特三次分段拟合，结果为 p
p = pchip(x, y, new_x);
% 分别画出 原始点的位置、拟合后的曲线、原始sinx的图像
plot(x, y, 'o', new_x, p, 'r-', new_x, sin(new_x), 'b-')