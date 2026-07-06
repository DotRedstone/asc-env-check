# ASC 环境自检作业

这是 ASC 队第一周环境自检作业。

本作业不考算法，只检查你是否已经能完成基础开发流程：

- 克隆 GitHub 仓库
- 编译运行普通 C 程序
- 编译运行 OpenMP 程序
- 编译运行 MPI 程序
- 生成环境自检报告
- 通过邮件提交报告

## 1. 作业提交方式

正式提交方式：发送邮件。

收件邮箱：

```text
dotredstone0123@gmail.com
```

邮件标题格式：

```text
ASC环境自检-学号-姓名
```

邮件附件：

```text
outputs/学号-姓名-env-check.md
outputs/学号-姓名-env-check-logs.tar.gz
```

## 2. 需要提前准备

请在 Linux / WSL2 / 远程服务器环境中完成。

需要能使用这些工具：

```bash
git --version
gcc --version
g++ --version
cmake --version
conda --version
mpicc --version
mpirun --version
```

如果 `conda`、`mpicc` 或 `mpirun` 找不到，说明环境还没有配好。

## 3. 克隆仓库

直接克隆本仓库：

```bash
git clone https://github.com/DotRedstone/asc-env-check.git
cd asc-env-check
```

如果 GitHub 访问失败，先检查网络和代理。

## 4. 编译和运行

先编译全部程序：

```bash
make all
```

分别运行：

```bash
make run-hello
make run-openmp
make run-mpi
```

也可以一次性运行：

```bash
make run
```

如果 MPI 默认不能用 4 个进程，可以改进程数：

```bash
make run-mpi NP=2
```

## 5. 生成环境自检报告

运行脚本时必须填写学号和姓名：

```bash
bash scripts/check_env.sh <学号> <姓名>
```

例如：

```bash
bash scripts/check_env.sh 2024123456 张三
```

脚本会生成：

```text
outputs/2024123456-张三-env-check.md
outputs/2024123456-张三-env-check-logs.tar.gz
```

报告里会记录：

- 学号和姓名
- 机器信息
- 仓库 commit
- git status
- 测试脚本、源码和 Makefile 的 SHA256
- Git / GCC / G++ / CMake 版本
- Conda / Python 信息
- MPI 工具信息
- 普通 C 程序运行结果
- OpenMP 程序运行结果
- MPI 程序运行结果

请打开报告检查一遍，不要直接提交空报告。

不要修改 `scripts/`、`src/`、`Makefile` 里的测试内容。报告会记录这些文件的校验信息。

## 6. 邮件提交

把生成的报告作为附件发送到：

```text
dotredstone0123@gmail.com
```

邮件标题示例：

```text
ASC环境自检-2024123456-张三
```

附件示例：

```text
outputs/2024123456-张三-env-check.md
outputs/2024123456-张三-env-check-logs.tar.gz
```

## 7. 可选：Pull Request 提交

正式提交仍然以邮件为准。

选做内容：

- Fork
- branch
- commit
- push
- Pull Request
- PR 描述怎么写

选做要求：

- 把自检报告提交到自己的分支
- 向本仓库发起 Pull Request
- PR 标题包含学号和姓名
- PR 描述里说明普通 C、OpenMP、MPI 是否全部通过

## 8. 常见问题

### `gcc: command not found`

说明没有安装 GCC，或当前环境没有加载编译器。

### `omp.h: No such file or directory`

说明当前编译器不支持 OpenMP，或 OpenMP 开发环境没有配好。

### `mpicc: command not found`

说明 MPI 环境没有安装或没有加载。

如果服务器使用 module，可以先查看：

```bash
module avail
module load openmpi
```

### `mpirun` 运行失败

先尝试减少进程数：

```bash
make run-mpi NP=2
```

如果仍然失败，把完整报错写进自检报告。

### `conda: command not found`

说明 Conda 没有安装，或 shell 没有加载 Conda 初始化脚本。

可以先检查：

```bash
which conda
echo $SHELL
```

## 9. 作业通过标准

你的报告中应该能看到：

- 学号和姓名
- 仓库 commit 和 git status
- 文件 SHA256 校验信息
- `hello` 程序正常运行
- OpenMP 程序输出线程信息
- MPI 程序输出 rank 信息
- 环境版本信息完整
- 如果有失败项，写清楚失败命令和完整报错

重点不是所有人的机器完全一样，而是你能说明自己的环境状态。
