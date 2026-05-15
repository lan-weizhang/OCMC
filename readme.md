# Matrix Completion with Incomplete Side Information via Orthogonal Complement Projection

论文 **Matrix Completion with Incomplete Side Information via Orthogonal Complement Projection** 的 MATLAB 实现：在不完整侧信息时，用正交补投影OCMC 做矩阵补全。

**环境**：MATLAB（建议较新版本）。

## 目录

| 路径 | 用途 |
|------|------|
| `basic_function/` | 核心子函数：合成数据与侧信息、矩阵补全主流程、奇异值阈值及多标签实验用到的评估等。 |
| `basic_simulation/` | 数值模拟实验：在合成数据上调节采样率、矩阵与侧信息相关设置并跑实验。 |
| `mll_related/` | 真实数据（多标签）实验：加载数据集、设置观测比例与重复次数等并评估结果。 |

## 运行方式

1. 启动 MATLAB，将 `basic_function` 加入搜索路径（或将整个代码根目录设为当前文件夹，使各子文件夹可被调用）。
2. **数值模拟**：在 `basic_simulation` 中打开并运行实验脚本；按需在脚本内修改矩阵规模、采样率、迭代与正则等参数，并设置结果输出路径（若原为占位需先填好）。
3. **真实数据实验**：在 `mll_related` 中打开并运行实验脚本；先在脚本中指定本地 `.mat` 数据路径及与数据一致的选项，再运行。

## 引用

> G. Chang, W. Zhang<sup>*</sup>, and L. Zhang. Matrix Completion with Incomplete Side Information via Orthogonal Complement Projection. *International Conference on Machine Learning (ICML)*, 2025.
