all: hello

hello:
	g++ -fopenmp -std=c++11 ./hello.cpp -o $@ -lopenblas

inner_prod:

clean:
	rm hello
