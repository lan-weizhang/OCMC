# Matrix Completion with Incomplete Side Information via Orthogonal Complement Projection

MATLAB implementation of the paper **Matrix Completion with Incomplete Side Information via Orthogonal Complement Projection**: matrix completion with incomplete side information using orthogonal complement projection (OCMC).

**Environment**: MATLAB (a recent release is recommended).

## Repository layout

| Path | Purpose |
|------|---------|
| `basic_function/` | Core routines: synthetic data and side information, main matrix-completion pipeline, singular value thresholding, and evaluation utilities used in multi-label experiments. |
| `basic_simulation/` | Numerical simulations on synthetic data: adjust sampling rate, matrix and side-information settings, and run experiments. |
| `mll_related/` | Real-data (multi-label) experiments: load datasets, set observation ratio and number of repeats, and evaluate results. |

## How to run

1. Start MATLAB and add `basic_function` to the MATLAB path (or set the repository root as the current folder so subfolders are on the path).
2. **Simulations**: Open and run the experiment scripts under `basic_simulation`; edit matrix size, sampling rate, iterations, regularization, and result output paths in the scripts as needed (fill in any placeholder paths first).
3. **Real-data experiments**: Open and run the scripts under `mll_related`; set the local path to your `.mat` files and options consistent with the data, then run.

## Citation

> G. Chang, W. Zhang<sup>*</sup>, and L. Zhang. Matrix Completion with Incomplete Side Information via Orthogonal Complement Projection. *International Conference on Machine Learning (ICML)*, 2025.
