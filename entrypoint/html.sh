#!/bin/env bash

# build the HTML
cd /pgu/docs
make html


# copy the output to the host OS
mkdir -p /output/pgu/
cp -r build/html/* /output/pgu/
