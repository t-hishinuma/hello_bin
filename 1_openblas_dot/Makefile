all: sample1

sample1: inner_prod.cpp
	g++ -fopenmp -std=c++11 $< -o $@ -lopenblas

nix-build:
	nix-build

shell:
	nix-shell

install:
	nix-env -i -f ./default.nix

clean:
	- rm sample1
	- rm result

test:
	nix-shell --pure --run "make; ./sample1"
