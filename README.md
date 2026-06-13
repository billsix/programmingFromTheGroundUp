# Programming From The Ground Up

A modernized, multi-architecture edition of Jonathan Bartlett's *Programming from
the Ground Up* — the classic introduction to how computers work, via x86 assembly.
This edition ships the book as a Sphinx site (HTML/PDF/EPUB), keeps the original
hand-written x86-32 examples, and adds C translations that compile to readable
assembly on five Linux architectures (i386, x86-64, ARM, AArch64, MIPS) so you can
see the same program across instruction sets.

## Build the book

Requires `podman` and `make`.

```sh
make BUILD_DOCS=1 USE_GRAPHICS=0 docs
```

HTML, PDF, and EPUB land under `./output/pgu/`.

## Development environment

```sh
make BUILD_DOCS=0 USE_GRAPHICS=1 shell
```

Drops you into a Fedora container in `/pgu/src` with a 32-bit + 64-bit toolchain
(clang/gcc, gdb/lldb). The assembly examples are in `src/*.s`; the C ports and
their build are in `src/c/` (`make`, `make check`, and cross-compile via
`EXTRA_CFLAGS` — see `src/c/README.md`).

## Layout

| Path | What |
| --- | --- |
| `docs/` | The Sphinx book (25 chapters/appendices) |
| `src/` | Hand-written x86-32 assembly examples |
| `src/c/` | C ports + a 5-arch syscall layer (`os.h`) |
| `upstreamSource/` | Original DocBook XML (porting reference) |

## License

The book is a port of Jonathan Bartlett's original work, under the GNU Free
Documentation License (see `docs/source/fdlap.rst`).
