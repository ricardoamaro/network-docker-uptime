#!/bin/bash

CWD=$(pwd)
cd base
./build.sh
cd ${CWD}

cd apache
./build.sh
cd ${CWD}

cd redis
./build.sh
cd ${CWD}

cd nodejs
./build.sh
cd ${CWD}


