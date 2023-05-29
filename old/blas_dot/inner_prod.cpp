#include <cblas.h>
#include <omp.h>
#include <string.h>

#include <iostream>
#include <vector>

void dot() {
    size_t size = 1000000;
    std::vector<float> x(size);
    std::vector<float> y(size);
    openblas_set_num_threads(omp_get_max_threads());

    if (omp_get_max_threads() != openblas_get_num_threads()) {
        printf(
            "# error, OpenBLAS does not support multi-threading? (env=%d, "
            "openblas:%d)",
            omp_get_max_threads(), openblas_get_num_threads());
        exit;
    }

#pragma omp parallel for
    for (size_t i = 0; i < size; i++) {
        x[i] = i;
        y[i] = 123.0;
    }

    float ans = cblas_sdot(x.size(), x.data(), 1, y.data(), 1);

    std::cout << ans << std::endl;
}

int main(int argc, char **argv) {
    dot();
    return 0;
}
