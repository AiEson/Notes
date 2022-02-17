clear;clc
% 加载体测数据
load 'physical fitness test.mat' 
% 求解 R P
[R, P] = corrcoef(Test)