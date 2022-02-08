load 'physical fitness test.mat'
%% 统计描述
MIN = min(Test);  % 每一列的最小值
MAX = max(Test);   % 每一列的最大值
MEAN = mean(Test);  % 每一列的均值
MEDIAN = median(Test);  %每一列的中位数
SKEWNESS = skewness(Test); %每一列的偏度
KURTOSIS = kurtosis(Test);  %每一列的峰度
STD = std(Test);  % 每一列的标准差
RESULT = [MIN;MAX;MEAN;MEDIAN;SKEWNESS;KURTOSIS;STD]  %将这些统计量放到一个矩阵中表示