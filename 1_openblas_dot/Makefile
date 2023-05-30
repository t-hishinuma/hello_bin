all: sample1

sample1: inner_prod.cpp
	g++ -fopenmp -std=c++11 $< -o $@ -lopenblas

build:
	nix-build ./default.nix

shell:
	nix-shell ./default.nix

install:
	nix-env -i -f ./default.nix

clean:
	- rm sample1
	- rm result

test:
	nix-shell --pure --run "make; ./sample1"
