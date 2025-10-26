all: \
     conversion-program \
     factorial \
     exit

# add-year: add-year.s
# 	clang -m32 -o add-year add-year.s -nostdlib

conversion-program: conversion-program.s \
		    count-chars.s \
                    integer-to-string.s \
                    write-newline.s \
                    linux.s
	clang -m32 -o conversion-program conversion-program.s count-chars.s integer-to-string.s write-newline.s -nostdlib

factorial: factorial.s
	clang -m32 -o factorial factorial.s -nostdlib


exit: exit.s
	clang -m32 -o exit exit.s -nostdlib

# alloc.s
# conversion-program.s
# count-chars.s
# error-exit.s
# gnome-example.s
# helloworld-lib.s
# helloworld-nolib.s
# integer-to-string.s
# linux.s
# maximum.s
# power.s
# printf-example.s
# read-record.s
# read-records.s
# record-def.s
# toupper-nomm-simplified.s
# write-newline.s
# write-record.s
# write-records.s
