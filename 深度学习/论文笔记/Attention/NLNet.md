# Non-local Neural Networks

## 开始之前

### 简介

- CVPR 2018 顶会论文
- 属于 Self-Attention
- 也是一个较为容易集成的模块

### 前置知识

####  非局部平均操作 Non-Local Means Operation

出自这篇论文 [1] 



## 论文阅读

### Abstract

- `卷积`等操作每次都是处理一个「局部区域」
- 本文提出了一系列`非局部操作（Non-Local）`的模块，用来**捕获更大尺度的相关关系**
- 可以插入到主流 Backbone 网络中
- 提供代码

### Introduction

- 介绍了之前的一些捕获全局相关关系的方法：
  - `循环神经网络（RNN）`分支中，通过建立全局分支进行捕获更长尺度的相关关系，如 `LSTM、GRU`
  - `卷积神经网络（CNN）`分支中，通过**更大的卷积核**、**更深的网络层**进行捕获更长尺度的相关关系
- 对于卷积操作，使用上述的解决办法会加大运算负担，使得**效率变低**、**优化困难**
- 同时，也会使得一些**级联操作变得困难**，尤其是需要使用很久之前的相关性信息时，普通卷积无力应对
- 本文通过 CV 领域中经典的`「非局部平均操作（Non-Local Mean Operation）」`，提出了一个简单、高效、通用的 `Non-Local Block`
- 几个优点：
  - **直接通过函数运算捕获**两个位置之间的相关关系
  - 该操作十分**高效**
  - 非局部操作保持了**可变的输入输出大小**，很容易可以嵌入卷积等操作之中
- 

## References

[1] A. Buades, B. Coll, and J.-M. Morel. A non-local algorithm for image denoising.  In Computer Vision and Pattern Recognition (CVPR), 2005. 1, 2, 3



