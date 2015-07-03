#!/bin/sh

# The build environment on acdocker1 requires us to use proxies and
# MPI mirrors. In order to make the build cacheabble, and also
# work locally where mirrors are not needed, we create a setup
# file that is run within the build process, but that is also
# not changed if the environment is the same.
if [ "$BUILD_ENV" = "production" ]; then
  echo "[aircloak] Production environment"
  echo 'echo "deb http://acmirror.mpi-sws.org/debian jessie main" > /etc/apt/sources.list' > docker/setup-env-tmp.sh
  echo 'echo "deb http://acmirror.mpi-sws.org/debian jessie-updates main" >> /etc/apt/sources.list' >> docker/setup-env-tmp.sh
  echo 'echo "deb http://acmirror.mpi-sws.org/debian-security jessie/updates main" >> /etc/apt/sources.list' >> docker/setup-env-tmp.sh
  echo 'export https_proxy=http://acmirror.mpi-sws.org:3128' >> docker/setup-env-tmp.sh
  echo 'export http_proxy=http://acmirror.mpi-sws.org:3128' >> docker/setup-env-tmp.sh
else
  echo "[aircloak] Development environment"
  echo "" > docker/setup-env-tmp.sh
fi

diff docker/setup-env-tmp.sh docker/setup-env.sh > /dev/null
if [ $? -ne 0 ]; then
  echo "[aircloak] Changed mirror and proxy values. Slow build"
  rm docker/setup-env.sh
  mv docker/setup-env-tmp.sh docker/setup-env.sh
else
  echo "[aircloak] Cached mirror and proxy values. Fast build"
  rm docker/setup-env-tmp.sh
fi
chmod +x docker/setup-env.sh

echo "[aircloak] Building static website container"
docker build -t aircloak/static_website:latest .
