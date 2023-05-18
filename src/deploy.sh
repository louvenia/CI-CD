#!/usr/bin/env bash

echo "Send files s21_cat to /usr/local/bin..."
scp ./src/cat/s21_cat louvenia@192.168.100.10:/usr/local/bin
if [ $? -eq 0 ]; then
    echo "Send files s21_cat - OK"
else
    echo "Send files s21_cat - FAIL"
    exit 1
fi
echo "Send files s21_grep to /usr/local/bin..."
scp ./src/grep/s21_grep louvenia@192.168.100.10:/usr/local/bin

if [ $? -eq 0 ]; then
    echo "Send files s21_grep - OK"
else
    echo "Send files s21_grep - FAIL"
    exit 1
fi
echo "Connecting with louvenia@192.168.100.10 and checking files at /usr/local/bin..."
found="$(ssh louvenia@192.168.100.10 ls -lah /usr/local/bin | grep 's21_cat\|s21_grep')"
number_found="$(ssh louvenia@192.168.100.10 ls -lah /usr/local/bin | grep 's21_cat\|s21_grep' | wc -l)"
echo "$found"
if [ $number_found -eq 2 ]; then
    echo "Connecting and checking files - OK"
elif [$number_found -eq 1]; then
    echo "Connecting - OK BUT Found one file out of two"
    exit 1
else
    echo "Connecting and checking files - FAIL"
    exit 1
fi
echo "Artefacts copied at /usr/local/bin."
echo "Finished"
