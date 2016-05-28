#!/bin/sh
bash ucore-clean.sh
gcc -o xc -O3 -m32 -Ilinux -Iucore/lib ucore/tool/c.c
gcc -o xem -O3 -m32 -Ilinux -Iucore/lib ucore/tool/em.c -lm
gcc -o xmkfs -O3 -m32 -Ilinux -Iucore/lib ucore/tool/mkfs.c
cpp-5 -Iucore/lib -Iucore/kern/include -Iucore/kern/libs -Iucore/kern/mm -Iucore/kern/fs -Iucore/kern/driver -Iucore/kern/sync -Iucore/kern/trap -Iucore/kern/process -Iucore/kern/schedule -Iucore/kern/syscall ucore/kern/main.c ucore.c
cpp-5  -Iucore/user/libs -Iucore/lib -Iucore/kern/include ucore/user/sh.c ucore/user/bin/sh.c
./xc -v -o ucore/user/bin/sh ucore/user/bin/sh.c
./xmkfs user.img ucore/user/bin
./xc -v -o ucore.bin ucore.c 
./xem -f user.img ucore.bin
