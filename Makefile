all: hello

hello:
	g++ -std=c++11 ./hello.cpp -o hello

clean:
	rm hello
