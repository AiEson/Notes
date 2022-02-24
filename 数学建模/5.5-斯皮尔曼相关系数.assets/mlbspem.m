clear;clc
load 'physical fitness test.mat'
spearman = corr(Test, 'type', 'Spearman')
person = corrcoef(Test)