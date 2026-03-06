#!/bin/env bash

# build the PDF
cd /pgu/docs
make epub


# copy the output to the host OS
mkdir -p /output/pgu/
cp build/epub/* /output/pgu/
