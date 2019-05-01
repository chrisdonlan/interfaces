.PHONY: dock dock-bash build 

projroot:=$(shell pwd)
projname:=interface

build: init dock
dock:
	-docker build -t dock -f .dockerfile .
dock-bash:
	-docker run -v ${projroot}:/${projname} --interactive --tty dock bash
init:
	git submodule init
	git submodule update
