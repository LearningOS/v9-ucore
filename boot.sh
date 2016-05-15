#!/bin/sh
bash cleanup.sh
gcc -o xc -O3 -m32 -Ilinux -Iroot/lib root/bin/c.c
gcc -o xem -O3 -m32 -Ilinux -Iroot/lib root/bin/em.c -lm
gcc -o xmkfs -O3 -m32 -Ilinux -Iroot/lib root/bin/mkfs.c
cpp-5 -I root/lib root/kern/main.c root/kern/os.c
./xc -o root/bin/c -Iroot/lib root/bin/c.c
./xc -o os.bin root/kern/os.c
./xmkfs fs.img root
./xem -f fs.img os.bin
