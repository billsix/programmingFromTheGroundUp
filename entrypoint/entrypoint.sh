#!/bin/env bash

echo FOO

cd /programminggroundup/pgu/docs
make html
make latexpdf

mkdir -p /output/pgu/
cp -r build/html/* /output/pgu/
cp -r build/latex/*pdf /output/pgu/
