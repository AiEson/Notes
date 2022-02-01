# Non-local Neural Networks

## 开始之前

### 简介

- CVPR 2018 顶会论文
- 属于 Self-Attention
- 也是一个较为容易集成的模块

### 前置知识

####  非局部平均操作 Non-Local Means Operation

出自这篇论文 [1] 

##### 相关去噪知识

去噪是什么？

假如我们有图像**定义**如下：
$$
v(i) = u(i) + n(i)
$$
 ^ 其中，$v(i)$ 是**观测值**（带有噪声的图像）；$u(i)$ 是**真实值**（去除噪声后的图像）；$n(i)$ 是噪声值，在此处我们假设为 均值为 $0$，方差为 $\sigma^2$ 的 `IID（独立同分布） Gaussian 白噪声`

###### 相关去噪工作列举

在 NL Means 方法提出之前，已经有一些工作是针对于图像去噪的

尽管在工具和实现上可能不尽相同，但去噪算法都有一个共同点：**Means Operation（平均操作）**

下面是一些工作的列举：

- 局部平均
  - 高斯平滑模型（Gaussian smoothing model）
  - 各向异性滤波（Anisotropic filtering）
  - 邻域滤波（Neighborhood filtering）
- 变分法（Calculus of variations）
  - 总变分最小化（Total Variation minimization）
- 频域（Frequency domain）
  - 经验性维纳滤波器（The empirical Wiener filters）
  - 小波 [2] 阈值方法（Wavelet thresholding methods）

---

定义 $D_h$ 函数：
$$
v = D_hv + n(D_h, v)
$$
 ^ 其中 $v$ 为带噪声的图像；$h$ 为**滤波参数**，通常取决于噪声的标准差

理想情况下，$D_hv$ 要比 $v$ 更加平滑（噪点更少）

目前大多数的去噪算法都是对 $u$ 进行细节调整和材质优化来实现的，为了更好的理解这种去噪方式下文将会介绍和分析此类去噪算法

此外，噪声方法被定义为**理想图像与噪声图像之间的差值**

并且，本文还提出一个 $NL\text{-}means$ 算法：
$$
NL[u](x) = \frac{1}{C(x)}\int_\Omega e^{-\frac{(G_a * | u(x +  .) - u(y + .)|^2)(0)}{h^2}}u(y)dy
$$
 ^ 其中 $x \in \Omega$；$C(x) = \int_\Omega e^{-\frac{(G_a * | u(x +  .) - u(z + .)|^2)(0)}{h^2}}dz$ 是**正则化常数**；$G_a$ 为**高斯核**；$h$ 为**滤波参数**

这个公式意在说明：$x$ 处去噪后的值是高斯邻域内所有看起来像 $x$ 邻域内的所有点的**平均值**

##### Method noise

**噪声方法（Method noise）定义：**

设 $u$ 是一副图像， $D_h$ 为依赖于滤波参数 $h$ 的去噪算子，那么该方法定义为下面式子所示的图像差值：
$$
u - D_hu
$$

##### The Gaussian filtering

图像的**各向同性线性滤波（Isotropic linear filtering ）**可以理解为用线性对称的卷积核对图像进行卷积操作

这种卷积核就是高斯核 $G_h$，其定义为：
$$
x\to G_h(x) = \frac{1}{(4\pi h^2)} e^{-\frac{|x| ^ 2}{4h^2}}
$$
**定理：**

使用高斯核进行卷积后的图像的噪声方法值（Method noise）为（当 $h$ 足够小时）：
$$
u - G_h * u = -h^2\Delta u + o(h^2)
$$
**补充：**

- 此滤波方法为线性滤波，对于图像边缘，也一视同仁地进行去噪操作，可能会造成图像边缘效果不好等情况

- 平均平滑对于邻域内的像素一视同仁，为了减少平滑处理中的模糊，得到更自然的平滑效果，很自然地想到适当加大模板中心点的权重，随着距离中心点的距离增大，权重迅速减小，从而可以确保中心点看起来更接近于与它距离更近的点，基于这样的考虑得到的模板即为高斯模板

##### The anisotropic filtering

`各向异性滤波器（Anisotropic Filter）`简称 AF，尝试通过对图像 $u$ 在 $x$ 处与 $Du(x)$ 正交的方向进行卷积来避免高斯的模糊效应

在此不介绍 $AF_hu(x)$ 的数学定义，仅了解其是一种滤波器即可

**定理：**

使用各向异性滤波处理后的图像的噪声方法值（Method noise）为：
$$
u(x) - AF_hu(x) = -\frac{1}{2}|Du|curv(u)(x)  +o(h^2)
$$
上式中 $curv(u)(x)$ 代表曲率，在直线处为 $0$，所以在算法进行图像退化操作的时候，更**直的边缘**得到了保护

##### The Total Variation minimization

总变分最小化，目的是给出一个将原始图像 $u(x)$ 去噪的最小化问题的解决方案：
$$
T V F_{\lambda}(v)=\arg \min _{u} T V(u)+\lambda \int|v(\mathbf{x})-u(\mathbf{x})|^{2} d \mathbf{x}
$$
其中，$TV(u)$ 表示的是 $u$ 的**总变化量**；$\lambda$ 是给定的拉格朗日乘子，**控制输出的滤波程度**，具体取值与噪声的数学统计有关，不作介绍

上述公式的极小值是可求、存在且唯一的

**定理：**

使用总变分最小化处理后的图像的噪声方法值（Method noise）为：
$$
u(\boldsymbol{x})-T V F_{\lambda}(u)(\boldsymbol{x})=-\frac{1}{2 \lambda} {curv}\left(T V F_{\lambda}(u)\right)(\boldsymbol{x})
$$


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

[2] 银河电器——小波变换：https://www.vfe.ac.cn/NewsDetail-403.aspx
