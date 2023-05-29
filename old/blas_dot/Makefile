all: hello

hello: inner_prod.cpp
	g++ -fopenmp -std=c++11 $< -o $@ -lopenblas

nix:
	nix-build

package:
	nix-env -i -f ./default.nix

clean:
	- rm hello
	- rm result
