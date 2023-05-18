#!/usr/bin/env bash

echo "Checking style in part cat..."
cd src/cat && clang-format -n -Werror *.c *.h
if [ $? -eq 0 ]; then
    echo "Style checking part cat - OK"
else
    echo "Style checking part cat - FAIL"
    exit 1
fi
echo "Checking style in part grep..."
cd ../grep && clang-format -n -Werror *.c *.h
if [ $? -eq 0 ]; then
    echo "Style checking part grep - OK"
else
    echo "Style checking part grep - FAIL"
    exit 1
fi
echo "Finished"
