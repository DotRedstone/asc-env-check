CC ?= gcc
CXX ?= g++
MPICC ?= mpicc
MPIRUN ?= mpirun
NP ?= 4
OMP_NUM_THREADS ?= 4

CFLAGS ?= -O2 -Wall -Wextra
OPENMP_FLAGS ?= -fopenmp

BUILD_DIR := build
BIN_DIR := $(BUILD_DIR)/bin

.PHONY: all hello openmp mpi run run-hello run-openmp run-mpi check clean

all: hello openmp mpi

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

hello: $(BIN_DIR)/hello

openmp: $(BIN_DIR)/openmp_hello

mpi: $(BIN_DIR)/mpi_hello

$(BIN_DIR)/hello: src/hello.c | $(BIN_DIR)
	$(CC) $(CFLAGS) $< -o $@

$(BIN_DIR)/openmp_hello: src/openmp_hello.c | $(BIN_DIR)
	$(CC) $(CFLAGS) $(OPENMP_FLAGS) $< -o $@

$(BIN_DIR)/mpi_hello: src/mpi_hello.c | $(BIN_DIR)
	$(MPICC) $(CFLAGS) $< -o $@

run: run-hello run-openmp run-mpi

run-hello: hello
	$(BIN_DIR)/hello

run-openmp: openmp
	OMP_NUM_THREADS=$(OMP_NUM_THREADS) $(BIN_DIR)/openmp_hello

run-mpi: mpi
	$(MPIRUN) -np $(NP) $(BIN_DIR)/mpi_hello

check:
	@if [ -z "$(SID)" ] || [ -z "$(NAME)" ]; then \
		echo "Usage: make check SID=<student_id> NAME=<name>"; \
		echo "Example: make check SID=2024123456 NAME=zhangsan"; \
		exit 1; \
	fi
	bash scripts/check_env.sh "$(SID)" "$(NAME)"

clean:
	rm -rf $(BUILD_DIR)
