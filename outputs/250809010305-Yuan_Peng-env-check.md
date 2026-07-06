# ASC 环境自检报告

- 学号：250809010305
- 姓名：Yuan_Peng
- 生成时间：2026-07-06 20:25:55 +0800
- 报告文件：outputs/250809010305-Yuan_Peng-env-check.md
- 原始日志目录：outputs/250809010305-Yuan_Peng-env-check-logs

## 提交说明

邮件提交时请同时发送：

- outputs/250809010305-Yuan_Peng-env-check.md
- outputs/250809010305-Yuan_Peng-env-check-logs.tar.gz

## 仓库校验信息

```text
git remote:
origin	https://github.com/DotRedstone/asc-env-check.git (fetch)
origin	https://github.com/DotRedstone/asc-env-check.git (push)

git branch:
main

git commit:
d3721714305d65c35ecd6d3a043f6106ee8599e9

git status:

```

## 文件 SHA256

```text
73551b623a32a9f493657a241251ab8a2137c97a281a53614b1060fa8e1c3e66  README.md
3055e3a4162a186854199975cb93b89cfcc782b85bcdce5c6c495cf98acfda48  Makefile
f75a49393a9797a36e8a7b9669d88bbea51f24972c54ddf44077fad111c19487  scripts/check_env.sh
726715ea5ab8c92fc60b601165194cf8fc58bbee3880e2b368d879219d62f7e9  scripts/run_all.sh
f062f36d44f523ef987448978c1774eec309bd40b37571a33ddd87b91dd46642  src/hello.c
d38659e09f40e6a4b2d9b5d68ca803ea54ca2a55dee5e3f63f0ec1ca7ffcd251  src/openmp_hello.c
035f463d29cf7a2752f35a995496312705c55e64bb0e3740d0b46c57023fbceb  src/mpi_hello.c
```


## 机器信息

```bash
$ hostname && whoami && uname -a
$ hostname && whoami && uname -a

Yuan-Peng
ypres
Linux Yuan-Peng 6.18.33.2-microsoft-standard-WSL2 #1 SMP PREEMPT_DYNAMIC Thu Jun 18 21:54:43 UTC 2026 x86_64 GNU/Linux

[exit code: 0]
[log sha256: ba18358499c3fb5b0587e4cc0c1d81c2cd76e62aeb586e4fca302be2e91255d5]
```

## Git

```bash
$ git --version
$ git --version

git version 2.53.0

[exit code: 0]
[log sha256: e7f1f479c53c5e8c338736d1f5223622458f99ec955ccce906348900afa955c2]
```

## 编译器

```bash
$ gcc --version && g++ --version
$ gcc --version && g++ --version

gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0
Copyright (C) 2025 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

g++ (Ubuntu 15.2.0-16ubuntu1) 15.2.0
Copyright (C) 2025 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


[exit code: 0]
[log sha256: 3be91c61e44ce6d4f2919120a2dad0a7d0b71c82bee1d9a83fbc4b1eea65b368]
```

## CMake

```bash
$ cmake --version
$ cmake --version

cmake version 4.2.3

CMake suite maintained and supported by Kitware (kitware.com/cmake).

[exit code: 0]
[log sha256: 151ffe47db84e05de11f3d3ccd3296f81b7c5b60624f888dd9adb449f07dd32b]
```

## Conda

```bash
$ conda --version && conda env list
$ conda --version && conda env list

conda 26.3.2

# conda environments:
#
# * -> active
# + -> frozen
base                 *   /home/ypres/miniconda3
asc                      /home/ypres/miniconda3/envs/asc


[exit code: 0]
[log sha256: 10c89b8e976c6f1eb63dfcdf95442a1e2c0ccd9f02c5345bf23f94482a38de6c]
```

## Python

```bash
$ which python && python --version
$ which python && python --version

/home/ypres/miniconda3/bin/python
Python 3.13.13

[exit code: 0]
[log sha256: 807d4c47da2ba94a9545fee7c2efb7811011ff334d651a3c7c623257ce60d1c0]
```

## MPI 工具

```bash
$ mpicc --version && mpirun --version
$ mpicc --version && mpirun --version

gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0
Copyright (C) 2025 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

mpirun (Open MPI) 5.0.10

Report bugs to https://www.open-mpi.org/community/help/


[exit code: 0]
[log sha256: 3ea6920d4a9d3f09887f1d7836898d837684290861eeb9d53d245a1ceda506b0]
```

## 清理旧文件

```bash
$ make clean
$ make clean

rm -rf build

[exit code: 0]
[log sha256: 7dc33e4ba1ba3ce840ef3277fac4a27f839c214ca7dc5bcbce12779ac158a080]
```

## 编译普通 C

```bash
$ make hello
$ make hello

mkdir -p build/bin
cc -O2 -Wall -Wextra src/hello.c -o build/bin/hello

[exit code: 0]
[log sha256: 48e4688cdc3a81cb180627aad00bfa7fd93af589196b96664f49305f0f904c24]
```

## 运行普通 C

```bash
$ make run-hello
$ make run-hello

build/bin/hello
hello ASC env check
plain C program is running

[exit code: 0]
[log sha256: c08265540e7e34bbd784347ad03429d6706b903530640dc80b77c93cfbe54757]
```

## 编译 OpenMP

```bash
$ make openmp
$ make openmp

cc -O2 -Wall -Wextra -fopenmp src/openmp_hello.c -o build/bin/openmp_hello

[exit code: 0]
[log sha256: df0b822814a1655ed27979dd8e51cc21cb008afcf943cc549c5297494daf6a3e]
```

## 运行 OpenMP

```bash
$ make run-openmp
$ make run-openmp

OMP_NUM_THREADS=4 build/bin/openmp_hello
OpenMP region started with 4 threads
hello from OpenMP thread 1
hello from OpenMP thread 0
hello from OpenMP thread 3
hello from OpenMP thread 2
OpenMP check finished, total threads = 4

[exit code: 0]
[log sha256: 7311654cdf125a3cd5551aeab744ed6923ae6fdab3cebb1a598d50b1ed3aeb2e]
```

## 编译 MPI

```bash
$ make mpi
$ make mpi

mpicc -O2 -Wall -Wextra src/mpi_hello.c -o build/bin/mpi_hello

[exit code: 0]
[log sha256: b995bafabd7e936214d29ef6f84b341d686dce5b2aa9919491e4af613618cede]
```

## 运行 MPI

```bash
$ make run-mpi
$ make run-mpi

mpirun -np 4 build/bin/mpi_hello
hello from MPI rank 2 of 4
hello from MPI rank 0 of 4
hello from MPI rank 1 of 4
hello from MPI rank 3 of 4

[exit code: 0]
[log sha256: bb54ccf63302c08fa30d9950c087aac0045c914ab4bd1a3c6890debfa5d398ea]
```

## 遇到的问题

请在这里补充你遇到的问题、完整报错和解决方法。

- 问题 1：运行mpi --version时，出现如下报错：

--------------------------------------------------------------------------
Sorry!  You were supposed to get help about:
    version
But I couldn't open the help file:
    /usr/lib/x86_64-linux-gnu/pmix2/share/pmix/help-schizo-ompi.txt: No such file or directory
    /usr/lib/x86_64-linux-gnu/prrte3/share/prte/help-schizo-ompi.txt: No such file or directory.
Sorry!
--------------------------------------------------------------------------

- 解决方法：首先询问AI，在他的指引下查看版本，相关包，再用find /usr -name "help-schizo-ompi.txt" 2>/dev/null 找出文件夹中是否有能显示版本的帮助文档，发现实际上是有帮助文档的，但是在另一个位置，是打包的错误
之后再创建符号链接，sudo ln -s /usr/share/doc/libprrte-dev/help-schizo-ompi.txt \
    /usr/lib/x86_64-linux-gnu/prrte3/share/prte/help-schizo-ompi.txt。
最后测试--version，正确了，完成。

