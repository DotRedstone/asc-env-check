# ASC 环境自检报告模板

- 学号：
- 姓名：
- 日期：
- 使用环境：WSL2 / 本地 Linux / 远程服务器 / 其他

## 机器信息

```bash
hostname
whoami
uname -a
```

## 基础工具

```bash
git --version
gcc --version
g++ --version
cmake --version
```

## Conda / Python

```bash
conda --version
conda env list
which python
python --version
```

## OpenMP 测试

命令：

```bash
make openmp
make run-openmp
```

输出：

```text
在这里粘贴输出
```

## MPI 测试

命令：

```bash
make mpi
make run-mpi
```

输出：

```text
在这里粘贴输出
```

## 遇到的问题

- 问题：
- 报错：
- 解决方法：
