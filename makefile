.PHONY: dock dock-bash build 

user:=$(shell whoami)
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
ifeq ($(and $(path),$(keyboard)),)
	@echo "usage: $@ path=<path-to-keyboard> keyboard=<keyboard-type>"
else
	make -C qmk_firmware ${path}:${keyboard}:all
	cp qmk_firmware/.build/*${keyboard}.hex ${build}
endif

board:
	echo "You are now board." > /dev/null

flash-board:
	./flashboard.sh -x ${build}/${keyboard}

ls-boards:
	ls ${build}

install-docker-debian:
	sudo apt-get remove docker docker-engine docker.io containerd runc
	sudo apt-get update
	sudo apt-get install \
		apt-transport-https \
		ca-certificates \
		curl \
		gnupg2 \
		software-properties-common
	curl -fsSl https://download.docker.com/linux/debian/gpg | sudo apt-key add -
	# sudo apt-key fingerprint 0EBFCD88 should be: 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable main"
	sudo apt-get update
	sudo apt-get install docker-ce docker-ce-cli containerd.io

install-docker-fedora:
	sudo dnf remove docker \
									docker-client \
									docker-client-latest \
									docker-common \
									docker-latest \
									docker-latest-logrotate \
									docker-logrotate \
									docker-selinux \
									docker-engine-selinux \
									docker-engine
	sudo dnf -y install dnf-plugins-core
	sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
	sudo dnf install -y docker-ce docker-ce-cli containerd.io
	sudo systemctl start docker

docker-add-user:
	sudo groupadd docker
	sudo usermod -aG docker ${user}


flash-massdrop-alt_cdonlan:
	$(eval path=massdrop/alt)
	$(eval keyboard=cdonlan)
	$(MAKE) keyboard path=$(path) keyboard=$(keyboard)
	./flashboard.sh -x .buld/$(subst /,_,$(path))_$(keyboard).hex

flash-massdrop-ctrl_cdonlan:
	$(eval path=massdrop/ctrl)
	$(eval keyboard=cdonlan)
	$(MAKE) keyboard path=$(path) keyboard=$(keyboard)
	./flashboard.sh -x .build/$(subst /,_,$(path))_$(keyboard).hex
