#!/usr/bin/env bash

echo "Checking test in part cat..."
cd src/cat && make test
if [ -f log ]; then
    echo "Test checking part cat - FAIL"
    exit 1
else
    echo "Test checking part cat - OK"
fi
echo "Checking test in part grep..."
cd ../grep && make test
if [ -f log ]; then
    echo "Test checking part grep - FAIL"
    exit 1
else
    echo "Test checking part grep - OK"
fi
echo "Finished"