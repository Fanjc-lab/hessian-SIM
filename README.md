# hessian-SIM

English | [中文](./README.zh-CN.md)

`hessian-SIM` is a MATLAB / MATLAB Runtime based structured illumination microscopy reconstruction toolkit for low-SNR SIM data. It provides Wiener-SIM, Hessian-SIM, TV-SIM, and Running-Average processing workflows, together with the MATLAB entry point [`Code/Main.m`](./Code/Main.m), a Windows executable `Hessian_SIM.exe`, example raw data, and default OTF / background resources.

## Publication

- Title: *Hessian structured illumination microscopy for fast, long-term and super-resolved live-cell imaging*
- DOI: <https://doi.org/10.1038/nbt.4115>

## Repository Structure

- [`Code/`](./Code) - MATLAB source code
- [`raw-data/`](./raw-data) - Example raw data
- `Hessian_SIM.exe` - Windows executable
- [readme.pdf](./readme.pdf) - Original user manual

## Quick Start

### Option 1: Run from MATLAB

If MATLAB is installed:

1. Open the `Code/` directory.
2. Run `Main.m`.
3. The program will add the `Main_fun` path automatically and launch the GUI.

### Option 2: Run the Windows executable

If MATLAB is not installed, run `Hessian_SIM.exe` from the repository root.

Before the first launch, the original manual recommends installing:

- 32-bit MATLAB Compiler Runtime
- Version: `R2012a (7.17)`
- Download: <http://www.mathworks.com/products/compiler/matlab-runtime.html>

## Processing Modes

The program provides three main modes:

1. `3 beam Hessian-SIM`
   Reconstructs 3-beam raw data with Wiener-SIM, Hessian-SIM, TV-SIM, and Running-Average.
2. `2 beam Hessian-SIM`
   Reconstructs 2-beam raw data with Wiener-SIM, Hessian-SIM, TV-SIM, and Running-Average.
3. `Hessian denoise`
   Applies Hessian denoising to SIM results that have already been reconstructed elsewhere.

## Example Data

Example `.tif` files are included in [`raw-data/`](./raw-data):

- `Actin_97hz_0.5ms exposure raw data.tif`
- `Actin_97hz_7ms exposure raw data.tif`
- `HUVEC-LifeAct 2d_N-SIM.tif`
- `HEK293-LifeAct 3d N-SIM.tif`
- `Simulation_twobeam_noise_NA0.9.tif`

## Outputs

According to the source code, reconstruction results are written beside the input data in folders such as:

- `Pseudo-TIRF/`
- `SIM-Wiener/`
- `SIM-Hessian/`
- `SIM-TV/`
- `Running-Average/`

## Manual

- Original manual PDF: [readme.pdf](./readme.pdf)

## Contribution

- Huang Xiaoshuai（黄小帅）, Peking University, Beijing, China
- Fan Junchao（范骏超）, Chongqing University of Posts and Telecommunications, Chongqing, China
