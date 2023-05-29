#include <cblas.h>
#include <omp.h>
#include <string.h>

#include <iostream>
#include <vector>

int main() {
    size_t size = 1000000;
    std::vector<float> x(size);
    std::vector<float> y(size);

#pragma omp parallel for
    for (size_t i = 0; i < size; i++) {
        x[i] = i;
        y[i] = 123.0;
    }

    // compute inner product
    float ans = cblas_sdot(x.size(), x.data(), 1, y.data(), 1);

    std::cout << ans << std::endl;

    return 0;
}
