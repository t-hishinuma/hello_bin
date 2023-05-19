all: hello

hello: hello.cpp
	g++ -fopenmp -std=c++11 $< -o $@ 

nix:
	nix-build

package:
	nix-env -i -f ./default.nix

clean:
	- rm hello
	- rm result
