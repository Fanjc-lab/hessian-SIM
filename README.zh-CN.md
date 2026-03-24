# hessian-SIM

[English](./README.md) | 中文

`hessian-SIM` 是一个基于 MATLAB / MATLAB Runtime 的结构光照明显微重建工具，用于处理低信噪比 SIM 数据。项目提供 Wiener-SIM、Hessian-SIM、TV-SIM 和 Running-Average 流程，同时包含 MATLAB 入口 [`Code/Main.m`](./Code/Main.m)、Windows 可执行程序 `Hessian_SIM.exe`、示例原始数据以及默认 OTF / background 资源。

## 论文信息

- 标题：*Hessian structured illumination microscopy for fast, long-term and super-resolved live-cell imaging*
- DOI：<https://doi.org/10.1038/nbt.4115>

## 仓库结构

- [`Code/`](./Code) - MATLAB 源代码
- [`raw-data/`](./raw-data) - 示例原始数据
- `Hessian_SIM.exe` - Windows 可执行程序
- [readme.pdf](./readme.pdf) - 原始使用手册

## 快速开始

### 方式一：使用 MATLAB 源码

如果本机已经安装 MATLAB：

1. 打开 `Code/` 目录。
2. 运行 `Main.m`。
3. 程序会自动加入 `Main_fun` 路径并启动图形界面。

### 方式二：使用 Windows 可执行程序

如果不使用 MATLAB，可直接运行仓库根目录中的 `Hessian_SIM.exe`。

根据原始手册，首次运行前建议安装：

- 32-bit MATLAB Compiler Runtime
- 版本：`R2012a (7.17)`
- 下载地址：<http://www.mathworks.com/products/compiler/matlab-runtime.html>

## 处理模式

程序提供三种主要模式：

1. `3 beam Hessian-SIM`
   对 3-beam 原始数据执行 Wiener-SIM、Hessian-SIM、TV-SIM 和 Running-Average 重建。
2. `2 beam Hessian-SIM`
   对 2-beam 原始数据执行 Wiener-SIM、Hessian-SIM、TV-SIM 和 Running-Average 重建。
3. `Hessian denoise`
   对已经完成 SIM 重建的结果进一步执行 Hessian 去噪。

## 示例数据

仓库在 [`raw-data/`](./raw-data) 中提供了示例 `.tif` 文件：

- `Actin_97hz_0.5ms exposure raw data.tif`
- `Actin_97hz_7ms exposure raw data.tif`
- `HUVEC-LifeAct 2d_N-SIM.tif`
- `HEK293-LifeAct 3d N-SIM.tif`
- `Simulation_twobeam_noise_NA0.9.tif`

## 输出结果

根据源码逻辑，重建结果会在输入数据所在目录旁生成如下文件夹，例如：

- `Pseudo-TIRF/`
- `SIM-Wiener/`
- `SIM-Hessian/`
- `SIM-TV/`
- `Running-Average/`

## 使用手册

- 原始手册 PDF：[readme.pdf](./readme.pdf)

## 贡献

- Huang Xiaoshuai（黄小帅）, Peking University, Beijing, China
- Fan Junchao（范骏超）, Chongqing University of Posts and Telecommunications, Chongqing, China
