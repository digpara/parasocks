#!/bin/bash

mkdir build_codelite
cd build_codelite
cmake -DCMAKE_BUILD_TYPE=Debug -G "CodeLite - Unix Makefiles" ..
