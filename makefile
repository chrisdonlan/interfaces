.PHONY: dock dock-bash build 

projroot:=$(shell pwd)
projname:=interface
build:=${projroot}/.build

build: init dock

dock:
	-docker build -t dock -f .dockerfile .

dock-bash:
	-docker run -v ${projroot}:/${projname} --interactive --tty dock bash

init:
	git submodule init
	git submodule update
	make -C qmk_firmware git-submodule

setup-keyboards:
	cp -r my_keyboards/* qmk_firmware/.

keyboard: setup-keyboards
	make -C qmk_firmware ${path}:${keyboard}:all
	cp qmk_firmware/.build/*${keyboard}.hex ${build}

board:
	echo "You are now board." > /dev/null
flash-board:
	./flashboard.sh -x ${build}/${keyboard}
ls-boards:
	ls ${build}
