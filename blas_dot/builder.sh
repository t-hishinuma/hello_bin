# export PATH="$coreutils/bin:$gcc/bin"
# mkdir $out
# gcc -o $out/simple $src
make
install -m555 -Dt $out/bin myhello
