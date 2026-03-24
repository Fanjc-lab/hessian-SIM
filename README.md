# hessian-SIM

`hessian-SIM` 是一个基于 MATLAB / MATLAB Runtime 的结构光显微重建工具，用于对低信噪比 SIM 数据进行 Wiener-SIM、Hessian-SIM、TV-SIM 与 Running-Average 处理。项目同时提供源码入口 `Code/Main.m` 和可执行程序 `Hessian_SIM.exe`，并附带示例原始数据与默认 OTF / background 资源。

## 论文信息

- 论文标题：Hessian structured illumination microscopy for fast, long-term and super-resolved live-cell imaging
- DOI：<https://doi.org/10.1038/nbt.4115>

## 项目结构

```text
.
├─ Code/                  MATLAB 源码
├─ raw-data/              示例原始数据
├─ Hessian_SIM.exe        Windows 可执行程序
└─ readme.pdf             原始操作手册
```

## 运行方式

### 方式一：使用 MATLAB 源码

如果计算机已安装 MATLAB：

1. 进入 `Code/` 目录。
2. 运行 `Main.m`。
3. 程序会自动加入 `Main_fun` 路径并启动图形界面。

### 方式二：使用 Windows 可执行程序

如果不使用 MATLAB，可直接运行根目录下的 `Hessian_SIM.exe`。

根据 `readme.pdf`，首次运行前需要安装：

- 32-bit MATLAB Compiler Runtime
- 版本：`R2012a (7.17)`
- 下载地址：<http://www.mathworks.com/products/compiler/matlab-runtime.html>

说明：

- 手册建议以管理员权限安装 MCR。
- 为减少内存不足中断，建议使用 64 位操作系统。

## 操作手册

以下步骤依据仓库内 `readme.pdf` 和源码流程整理。

### 1. 载入原始数据

点击界面中的文件加载按钮，选择 `.tif` 格式原始数据。仓库自带示例数据位于 `raw-data/`，例如：

- `Actin_97hz_0.5ms exposure raw data.tif`
- `Actin_97hz_7ms exposure raw data.tif`
- `HUVEC-LifeAct 2d_N-SIM.tif`
- `HEK293-LifeAct 3d N-SIM.tif`
- `Simulation_twobeam_noise_NA0.9.tif`

### 2. 选择处理模式

程序提供 3 种处理模式：

1. `3 beam Hessian-SIM`
   使用 3-beam 原始数据进行 Wiener-SIM、Hessian-SIM、TV-SIM 和 Running-Average 重建。
2. `2 beam Hessian-SIM`
   使用 2-beam 原始数据进行 Wiener-SIM、Hessian-SIM、TV-SIM 和 Running-Average 重建。
3. `Hessian denoise`
   对商业 SIM 软件已重建得到的结果进一步进行 Hessian 去噪。

补充说明：

- 2-beam 模式的手册中引用了 Shroff 等人的方法：
  `Shroff SA, Fienup JR, Williams DR. J Opt Soc Am A. 2010;27(8):1770-1782.`

### 3. 选择 OTF 和背景图

程序支持两种资源模式：

- `Default`
  使用程序内置的默认 OTF 和背景图。
- `Special`
  手动选择来自其他 SIM 系统的 OTF 与背景图。

注意事项：

- 默认 OTF / background 仅适配手册所述的自建 TIRF-SIM 系统。
- 如果重建来自其他 SIM 系统的数据，建议在重建前提供对应的专用 OTF 和背景图。
- 背景图由系统相机采集生成，其尺寸不能小于原始 SIM 图像尺寸。
- 源码内置了 `488OTF_512.tif`、`561OTF_512.tif`、`647OTF_512.tif` 三个默认 OTF。

### 4. 参数设置

界面中的主要参数含义如下：

- `Wiener parameter`
  Wiener 滤波参数，应根据数据的信噪比调整。
- `Wavelength`
  激发波长。源码默认支持 `488`、`561`、`647`，其他波长需手动提供专用 OTF。
- `Number of averaged frames`
  用于参数估计的平均帧数。
  手册建议：
  - 3-beam 模式下应小于总帧数的 `1/9`
  - 2-beam 模式下应小于总帧数的 `1/6`
- `Pixel Size`
  样品平面上的相机像素尺寸，单位为 `nm`。
- `Excitation NA`
  照明条纹的激发数值孔径。
- `Theta Ratio`
  `Theta1:Theta2:Theta3` 的步进比例，取决于 SLM 上的条纹移动方式。
  手册示例：
  - 自建系统：若周期为 `5.5 pixel`，每次移动 `2 pixel`，则比例为 `2:2:1.5`
  - 商业 SIM 系统若每次转动 `120°`，通常可设为 `1:1:1`
- `Mu, Sigma`
  Hessian-SIM 的正则参数。

源码默认值为：

- `Wiener parameter = 2`
- `Wavelength = 488`
- `Number of averaged frames = 20`
- `Mu = 150`
- `Sigma = 1`
- `Pixel Size = 65`
- `Excitation NA = 1.4`
- `Theta Ratio = 4 : 4 : 3`

### 5. 开始重建

点击运行按钮后：

- 3-beam / 2-beam 模式会依次执行：
  - Pseudo-TIRF
  - Wiener-SIM
  - Hessian-SIM
  - TV-SIM
  - Running-Average
- Hessian denoise 模式会直接对输入堆栈执行 Hessian 去噪。

## 输出结果

根据源码，程序会在输入数据所在目录自动创建以下结果文件夹：

- `Pseudo-TIRF/`
  保存平均后的伪 TIRF 结果，文件名形式为 `TIRF_*.tif`
- `SIM-Wiener/`
  保存 Wiener-SIM 结果，文件名形式为 `re-*.tif`
- `SIM-Hessian/`
  保存 Hessian-SIM 或 Hessian 去噪结果
- `SIM-TV/`
  保存 TV-SIM 结果，文件名形式为 `TV_*.tif`
- `Running-Average/`
  保存滑动平均结果，文件名形式为 `RunningAverage_*.tif`

## 使用提示

- 如果输入帧数小于 3，源码会自动关闭 Hessian 中 `t/z` 方向约束，此时 `sigma` 实际按 `0` 处理。
- 从源码与手册说明看，Hessian-SIM 结果的首帧和末尾若干帧可能含边界伪影，实际分析时通常需要自行检查。
- 项目根目录提供的 `raw-data/` 可作为测试数据直接上手。

## 参考手册

- 原始使用说明：`readme.pdf`

## 贡献

- 老师甲
- 老师乙

说明：由于仓库中未包含两位老师的正式姓名，这里先按占位方式写入；如你提供准确姓名，我可以继续替换为正式版本。
