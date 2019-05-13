# base img
FROM fedora:latest as builder

# cache dependencies
RUN dnf upgrade -y
RUN dnf install -y @development-tools
RUN dnf install -y gcc
RUN dnf install -y unzip
RUN dnf install -y wget
RUN dnf install -y zip
RUN dnf install -y avr-gcc
RUN dnf install -y avr-binutils
RUN dnf install -y avr-libc
RUN dnf install -y dfu-programmer
RUN dnf install -y dfu-util
RUN dnf install -y arm-none-eabi-gcc-cs
RUN dnf install -y arm-none-eabi-gcc
RUN dnf install -y arm-none-eabi-gcc-cs-c++
RUN dnf install -y arm-none-eabi-binutils
RUN dnf install -y arm-none-eabi-binutils-cs
RUN dnf install -y arm-none-eabi-newlib
RUN dnf install -y git
RUN dnf install -y parallel
RUN dnf install -y pv
RUN dnf install -y vim
RUN dnf install -y tmux
RUN dnf install -y wget
RUN dnf install -y zpac
RUN dnf install -y docker

# set up homefiles
ADD .bashrc /root/.
ADD .vimrc /root/.
ADD .tmux.conf /root/.
ADD .pip.conf /root/.pip/.pip.conf

# set up proj
ADD . /interface

MAINTAINER Christopher Donlan
LABEL version="0.0"
