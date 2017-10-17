#!/bin/bash

mkdir build_xcode
cd build_xcode
cmake -DCMAKE_BUILD_TYPE=Debug -G Xcode ..
