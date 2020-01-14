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
# @see https://packages.ubuntu.com/bionic/build-essential
# @see https://packages.ubuntu.com/bionic/software-properties-common
#
# @see https://curl.haxx.se/
# @see https://www.openssl.org/
# @see https://docs.python.org/3/installing/index.html
# @see https://packages.ubuntu.com/bionic/libssl-dev
# @see https://packages.ubuntu.com/bionic/zip
# @see https://packages.ubuntu.com/bionic/unzip
# ------------------------------------------------------------------------------

startNewTask "Installing useful system utilities"

sudo apt-get -y -qq install build-essential &> /dev/null
sudo apt-get -y -qq install software-properties-common &> /dev/null

sudo apt-get -y -qq install curl &> /dev/null
sudo apt-get -y -qq install openssl libssl-dev &> /dev/null
sudo apt-get -y -qq install python3-pip &> /dev/null
sudo apt-get -y -qq install zip unzip &> /dev/null
