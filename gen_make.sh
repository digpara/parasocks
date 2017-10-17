#!/bin/bash
mkdir build_make
cd build_make
cmake -DCMAKE_BUILD_TYPE=Debug -G "Unix Makefiles" ..

echo ">>>>>> start make project >>>>>"
make
cd ..

