#!/bin/bash

# ------------------------------------------------------------------------------
# Install useful system utilities.
#
# `build-essential` is a single reference for all the packages needed to make
# a Debian package. It includes the gcc/g++ compilers plus other utilities.
#
# `software-properties-common` is a reference to the repositories and tools
# via which we install common software.
#
# Other handy system utilities include Pip (Python's package manager), Curl,
# OpenSSL, and `zip`/`unzip`.
#
# @see //packages.ubuntu.com/bionic/build-essential
# @see //packages.ubuntu.com/bionic/software-properties-common
#
# @see //curl.haxx.se/
# @see //www.openssl.org/
# @see //docs.python.org/3/installing/index.html
# @see //packages.ubuntu.com/bionic/libssl-dev
# @see //packages.ubuntu.com/bionic/zip
# @see //packages.ubuntu.com/bionic/unzip
# ------------------------------------------------------------------------------

startNewTask "Installing some useful system utilities"

sudo apt-get -y install build-essential
sudo apt-get -y install software-properties-common

sudo apt-get -y install curl
sudo apt-get -y install openssl libssl-dev
sudo apt-get -y install python3-pip
sudo apt-get -y install zip unzip
