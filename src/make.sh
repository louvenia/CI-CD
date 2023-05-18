#!/usr/bin/env bash


echo "Build s21_cat..."
cd src/cat
make s21_cat
if [ -f s21_cat ]; then
    echo "s21_cat built successfully."
fi
echo "Build s21_grep..."
cd ../grep
make s21_grep
if [ -f s21_grep ]; then
    echo "s21_grep built successfully."
fi
echo "Done."