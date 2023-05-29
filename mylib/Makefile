all: mylib.so

mylib.so: mylib.cpp mylib.hpp
	g++ ./mylib.cpp -o mylib.so -shared -fPIC

install: mylib.so mylib.hpp
	cp mylib.so /usr/lib
	cp mylib.hpp /usr/include

clean:
	rm *.so
