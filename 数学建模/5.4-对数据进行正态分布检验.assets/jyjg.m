load 'physical fitness test.mat' % 加载 Test 变量，作为女生体测数据
size(Test); % 519    6

% 通过循环进行 JB 检验
% 先获取列数
r_num = size(Test, 2); % 6，因为获取的是 519 6 的第二个数字
% 创建 H，P 数组保存数据
H = zeros(1, r_num);
P = zeros(1, r_num);
% 进行循环
for i = 1 : r_num
    [h, p] = jbtest(Test(:, i), 0.05);
    H(i) = h;
    P(i) = p;
end
disp(H)
disp(P)