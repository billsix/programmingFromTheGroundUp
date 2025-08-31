#!/bin/env bash

# build the PDF
cd /pgu/docs
make latexpdf

# copy the output to the host OS
mkdir -p /output/pgu/
cp -r build/latex/*pdf /output/pgu/
