#! /bin/sh

set -e

sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test;
sudo apt-get update;
sudo apt-get install gcc-4.9 g++-4.9 lcov;
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 20;
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.9 20;
sudo update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-4.9 20;
sudo update-alternatives --config gcc;
sudo update-alternatives --config g++;
sudo update-alternatives --config gcov;
wget http://downloads.sourceforge.net/ltp/lcov-1.10.tar.gz;
tar xvfz lcov-1.10.tar.gz;
sudo cp -v lcov-1.10/bin/{lcov,genpng,gendesc,genhtml,geninfo} /usr/bin/;
sudo chmod 777 /usr/bin/lcov /usr/bin/genhtml /usr/bin/geninfo /usr/bin/genpng /usg/bin/gendesc;
rm -rf lcov-1.10.tar.gz lcov-1.10;
sudo mv -v `which gcov-4.8` `which gcov`;

LIBZOOKEEPER_VERSION=$1
LIBZOOKEEPER_PREFIX=${HOME}/libzookeeper-${LIBZOOKEEPER_VERSION}

phpize || exit 1

CFLAGS="--coverage -fprofile-arcs -ftest-coverage" \
LDFLAGS="--coverage" \
./configure --with-libzookeeper-dir=${LIBZOOKEEPER_PREFIX} || exit 1
make || exit 1

lcov -v
lcov --directory . --zerocounters &&
lcov --directory . --capture --initial --output-file coverage.info

USE_PHP=${TEST_PHP_EXECUTABLE:-$(which php)}
TEST=${1:-tests/}

TEST_PHP_EXECUTABLE=${USE_PHP} \
REPORT_EXIT_STATUS=1 \
${USE_PHP} \
  -n -d open_basedir= -d output_buffering=0 -d memory_limit=-1 \
  run-tests.php -n -d extension_dir=modules -d extension=zookeeper.so ${TEST}

lcov --no-checksum --directory . --capture --output-file coverage.info
