#include <stdio.h>
#include <omp.h>

int main(void) {
    int total_threads = 0;

#pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int nthreads = omp_get_num_threads();

#pragma omp single
        {
            total_threads = nthreads;
            printf("OpenMP region started with %d threads\n", nthreads);
        }

        printf("hello from OpenMP thread %d\n", tid);
    }

    printf("OpenMP check finished, total threads = %d\n", total_threads);
    return 0;
}
