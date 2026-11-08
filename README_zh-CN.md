# 虚拟电厂实时运行策略

英文版：[README.md](README.md)

本仓库包含论文 *Real-Time Operation Strategy of Virtual Power Plants With Optimal Power Disaggregation Among Heterogeneous Resources*（Applied Energy, 2024）中的数据和 MATLAB 代码。

## 快速开始

### 依赖环境

- MATLAB。
- [YALMIP](https://yalmip.github.io/)。
- Gurobi 及有效的 Gurobi 许可证。

在 MATLAB 中切换到仓库根目录，然后运行：

```matlab
run_demo
```

`run_demo` 会检查安装环境，将支持的代码目录加入 MATLAB 路径，使用仓库中已处理的第 21 天数据运行最优实时运行策略，并生成：

- `results/result_optimal_bid_ctrl_sep_.mat`
- `results/demo_profit.png`

优化可能需要几分钟。如果只想检查安装环境，请运行：

```matlab
check_installation
```

如果不需要生成图像，可以运行：

```matlab
run_demo("MakePlot", false)
```

如果 MATLAB 找不到 `run_demo`，请先运行：

```matlab
setup
run_demo
```

## 项目内容

本项目研究异构资源虚拟电厂的实时运行策略和最优功率分解。模型聚合了光伏、储能、电动汽车、温控负荷和工业生产负荷，并比较不同的功率分配方法。

论文引用：

> Q. Chen, R. Lyu, H. Guo, and X. Su. “Real-Time Operation Strategy of Virtual Power Plants With Optimal Power Disaggregation Among Heterogeneous Resources.” Applied Energy 361 (2024): 122876.

## 目录和主要脚本

### `data_prepare`

- `data_prepare_main.m`：生成处理后的参数文件。
- `data_prepare_parameters.m`：准备各类资源参数。
- `data_prepare_pv_output.m`：准备光伏输出数据。
- `data_prepare_regd.m`：读取并处理历史 RegD 信号。
- `data_prepare_std.m`：生成标准化资源参数。
- `param_day_21.mat`：快速开始流程使用的已处理参数文件。

### `optimal_bidding_control`

- `main.m`：最优投标和实时功率控制主程序。
- `maxProfit_1.m`：初始/日前投标优化。
- `maxProfit_t.m`：实时投标优化。
- `fastControl_prepare.m`：准备快速功率分解参数。
- `fastControl_implement.m`：执行快速功率分解。

### 对比方法

- `proportional_control/`：比例分配方法。
- `greedy_control/`：贪心分配方法。

这两个目录中的 `main.m` 可用于运行对比实验。由于不同目录包含同名 MATLAB 函数，运行某一方法前请将对应目录设为当前文件夹，或使用 `setup` 后再切换到目标目录。

### `results`

包含论文实验和不同方法的 `.mat` 结果文件。

### `visualise` 和 `visualise_cn`

包含英文和中文可视化脚本，用于绘制投标、收益、状态和计算时间等结果。

## 重新处理原始数据

快速开始不需要重新处理原始数据。如果需要重新生成参数文件：

1. 进入 `data_prepare` 文件夹。
2. 确认原始 Excel 文件和 `.mat` 文件均已存在。
3. 运行 `data_prepare_main.m`。
4. 再运行 `run_demo`。

## 常见问题

- **缺少 YALMIP：** 将 YALMIP 加入 MATLAB 路径，然后运行 `check_installation`。
- **缺少 Gurobi：** 安装 Gurobi MATLAB 接口并配置许可证，然后运行 `check_installation`。
- **优化失败：** 确认 MATLAB 中可以调用 `gurobi`，并确认许可证有效。
- **Excel 读取失败：** 使用仓库中已有的 `param_day_21.mat` 运行 `run_demo`，只有重新处理原始数据时才需要 Excel 读取支持。
- **运行了错误的同名函数：** MATLAB 的路径可能包含其他方法目录。重新运行 `setup`，并从 `optimal_bidding_control` 文件夹启动主程序。

## 说明

本代码主要用于理解模型、比较方法和开展进一步研究，不保证直接复现论文中的全部数值结果。项目也讨论了调频实际性能和爬坡约束等后续改进方向。
