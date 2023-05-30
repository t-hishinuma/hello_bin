all: hello

hello: inner_prod.cpp
	g++ -fopenmp -std=c++11 $< -o $@ -lopenblas -lfftw3

nix:
	nix-build

package:
	nix-env -i -f ./default.nix

clean:
	- rm hello
	- rm result

test:
	nix-shell --pure --run "make; ./hello"
