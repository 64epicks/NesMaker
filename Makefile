CC=gcc
CXX=g++
CC_ARGS=-O3 -Wall -Wextra -g -c -z muldefs -I include/

CC65=cc65
CC65_ARGS=-O -I include/ 
CA65=ca65
CA65_ARGS=-I include/
LD65=ld65

LINKER=ld
LINKER_ARGS=--entry main -z muldefs

all: config build
clean:
	@rm -rf build
	@rm -rf emulator

SRC=build/main.c.o build/create.cpp.o build/build.cpp.o build/run.cpp.o emulator/build/core/libcore.a
nes65src=build/nes65/lib.o

config:
	@echo "Loading submodules..."
	@git submodule add -b master --force https://github.com/64epicks/NESsxt.git emulator/
	@echo "Configuring emulator..."
	@mkdir -p emulator/build
	@cmake -S emulator/ -B emulator/build -DBUILD_GUI=OFF -DBUILD_TESTS=OFF
	@mkdir -p build/nes65

build: $(SRC) nes65
	$(CC) -o build/nesmake $(SRC) 
build/main.c.o: src/main.c
	$(CC) $(CC_ARGS) -o build/main.c.o src/main.c
build/create.cpp.o: src/create.cpp
	$(CXX) $(CC_ARGS) -o build/create.cpp.o src/create.cpp
build/build.cpp.o: src/build.cpp
	$(CXX) $(CC_ARGS) -o build/build.cpp.o src/build.cpp
build/run.cpp.o: src/run.cpp
	$(CXX) $(CC_ARGS) -o build/run.cpp.o src/run.cpp
emulator/build/core/libcore.a:
	@make -C emulator/build
nes65: $(nes65src)
build/nes65/lib.o: src/nes65/lib.S include/nes65.inc
	$(CA65) $(CA65_ARGS) -o build/nes65/lib.o src/nes65/lib.S