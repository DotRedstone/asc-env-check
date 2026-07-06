#!/usr/bin/env bash
set -uo pipefail

if [ "$#" -lt 2 ]; then
    echo "Usage: bash scripts/check_env.sh <student_id> <name>"
    echo "Example: bash scripts/check_env.sh 2024123456 张三"
    exit 1
fi

STUDENT_ID="$1"
NAME="$2"
SAFE_ID="$(printf '%s' "$STUDENT_ID" | tr -c 'A-Za-z0-9._-' '_')"
SAFE_NAME="${NAME// /_}"
SAFE_NAME="${SAFE_NAME//\//_}"
OUT_DIR="outputs"
BASE_NAME="${SAFE_ID}-${SAFE_NAME}-env-check"
REPORT="${OUT_DIR}/${BASE_NAME}.md"
LOG_DIR="${OUT_DIR}/${BASE_NAME}-logs"
ARCHIVE="${OUT_DIR}/${BASE_NAME}-logs.tar.gz"
CMD_INDEX=0

mkdir -p "$OUT_DIR"
rm -rf "$LOG_DIR"
mkdir -p "$LOG_DIR"

sha256_file() {
    local file="$1"
    if [ ! -e "$file" ]; then
        echo "missing"
        return 0
    fi

    if command -v sha256sum >/dev/null 2>&1; then
        sha256sum "$file" | awk '{print $1}'
    elif command -v shasum >/dev/null 2>&1; then
        shasum -a 256 "$file" | awk '{print $1}'
    else
        echo "sha256-unavailable"
    fi
}

safe_slug() {
    printf '%s' "$1" | tr -c 'A-Za-z0-9._-' '_' | cut -c 1-40
}

run_cmd() {
    local title="$1"
    local cmd="$2"
    local slug
    local log_file
    local status

    CMD_INDEX=$((CMD_INDEX + 1))
    slug="$(safe_slug "$title")"
    log_file="${LOG_DIR}/$(printf '%02d' "$CMD_INDEX")-${slug}.log"

    {
        echo
        echo "## ${title}"
        echo
        echo '```bash'
        echo "\$ ${cmd}"
    } >> "$REPORT"

    {
        echo "\$ ${cmd}"
        echo
    } > "$log_file"

    bash -lc "$cmd" >> "$log_file" 2>&1
    status=$?

    cat "$log_file" >> "$REPORT"

    {
        echo
        echo "[exit code: ${status}]"
        echo "[log sha256: $(sha256_file "$log_file")]"
        echo '```'
    } >> "$REPORT"

    return 0
}

tracked_hashes() {
    local files=(
        "README.md"
        "Makefile"
        "scripts/check_env.sh"
        "scripts/run_all.sh"
        "src/hello.c"
        "src/openmp_hello.c"
        "src/mpi_hello.c"
    )

    for file in "${files[@]}"; do
        printf '%s  %s\n' "$(sha256_file "$file")" "$file"
    done
}

cat > "$REPORT" <<EOF_REPORT
# ASC 环境自检报告

- 学号：${STUDENT_ID}
- 姓名：${NAME}
- 生成时间：$(date "+%Y-%m-%d %H:%M:%S %z")
- 报告文件：${REPORT}
- 原始日志目录：${LOG_DIR}

## 提交说明

邮件提交时请同时发送：

- ${REPORT}
- ${ARCHIVE}

## 仓库校验信息

\`\`\`text
git remote:
$(git remote -v 2>&1)

git branch:
$(git branch --show-current 2>&1)

git commit:
$(git rev-parse HEAD 2>&1)

git status:
$(git status --short -- README.md Makefile scripts src docs .github .gitignore .gitattributes 2>&1)
\`\`\`

## 文件 SHA256

\`\`\`text
$(tracked_hashes)
\`\`\`

EOF_REPORT

run_cmd "机器信息" "hostname && whoami && uname -a"
run_cmd "Git" "git --version"
run_cmd "编译器" "gcc --version && g++ --version"
run_cmd "CMake" "cmake --version"
run_cmd "Conda" "conda --version && conda env list"
run_cmd "Python" "which python && python --version"
run_cmd "MPI 工具" "mpicc --version && mpirun --version"
run_cmd "清理旧文件" "make clean"
run_cmd "编译普通 C" "make hello"
run_cmd "运行普通 C" "make run-hello"
run_cmd "编译 OpenMP" "make openmp"
run_cmd "运行 OpenMP" "make run-openmp"
run_cmd "编译 MPI" "make mpi"
run_cmd "运行 MPI" "make run-mpi"

cat >> "$REPORT" <<'EOF_REPORT'

## 遇到的问题

请在这里补充你遇到的问题、完整报错和解决方法。

- 问题 1：
- 解决方法：

EOF_REPORT

if command -v tar >/dev/null 2>&1; then
    tar -czf "$ARCHIVE" -C "$OUT_DIR" "$(basename "$LOG_DIR")"
    echo "Report written to ${REPORT}"
    echo "Logs written to ${ARCHIVE}"
else
    echo "Report written to ${REPORT}"
    echo "tar not found; raw logs are in ${LOG_DIR}"
fi
