#!/bin/sh

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euxo pipefail

# Convention differ
rule=
if test -f CMakeLists.txt
then
  cmake -S . -B . -DCMAKE_BUILD_TYPE=Release
fi
for file in ./autogen.sh ./bootstrap
do
  if test -x $file
  then
    $file
# In my project I always have a debug rule that add different sanitizers.
    rule=debug
    break
  fi
done

# If we haven't detected earlier a start script then we try to generate one
if ! test -x ./configure && test -f configure.ac
then
  autoreconf --verbose --force --install
fi

# We launch the configuration of the project
./configure

make $rule
