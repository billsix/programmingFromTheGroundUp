# programmingFromTheGroundUp

A modernized, multi-architecture edition of Jonathan Bartlett's *Programming from
the Ground Up* (the classic x86-32 assembly textbook). It ships as a Sphinx book
plus runnable example programs, and adds C translations that compile to readable
assembly on five Linux ISAs so students can compare them.

## Status

- **Book:** 25 reStructuredText chapters/appendices in `docs/source/` → HTML / PDF
  / EPUB. Ported from the upstream DocBook XML (vendored in `upstreamSource/`); the
  multi-phase fidelity sweep is logged in `tasks/archive/2026/05/24/SESSION_NOTES.md`
  and `docs/PORTING_QA.md`.
- **Assembly:** the book's original hand-written **x86-32 GAS** examples in `src/*.s`.
- **C ports:** `src/c/` — 17 `.c` files over a 5-arch inline-asm syscall layer
  (`os.h`): i386, x86-64, ARM-32, AArch64, MIPS-32. `make check` runs them on the
  host; cross-arch builds emit `-S` assembly listings for side-by-side comparison.

## Layout

- `docs/source/` — Sphinx book (`conf.py`, `index.rst`, the chapter `.rst`s, and
  reference appendices `instructionsap`, `syscallap`, `gdbap`). `docs/Makefile`
  builds it; `docs/PORTING_QA.md` tracks the XML→RST port.
- `src/` — hand-written x86-32 `.s` examples. `src/c/` — the C ports with `os.h`
  (per-arch syscall wrappers), `record-def.h`, a `Makefile` (`make`, `make check`,
  cross-compile via `EXTRA_CFLAGS`), and `README.md`.
- `upstreamSource/` — the original DocBook XML, kept as the porting reference.
- `entrypoint/` — `html.sh`/`pdf.sh`/`epub.sh` (build the book to `/output/pgu/`),
  `format.sh`, `shell.sh`.
- `tasks/` — active work (e.g. `tasks/build-matrix.md`); completed work archived
  under `tasks/archive/<YYYY>/<MM>/<DD>/`.

## Build / container workflow

Fedora-44 + podman family template (`BUILD_DOCS`, `USE_GRAPHICS` build args).

- `make image` — build the image. Installs a **32-bit multilib** toolchain
  (`glibc-devel.i686`, `libgcc.i686`, …) so i386 binaries build and run on x86-64,
  plus (with `BUILD_DOCS=1`) Sphinx + TeX Live.
- `make shell` — dev shell (runs `format` first), lands in `/pgu/src`.
- `make docs` / `html` / `pdf` / `epub` — build the book; output under `/output/pgu/`.
- `make format` — clang-format the C.

The C ports use educational compiler flags
(`-O0 -fomit-frame-pointer -fno-asynchronous-unwind-tables -fno-unwind-tables
-fno-dwarf2-cfi-asm -fno-stack-protector`) so generated `.s` stays legible.

## Tests

`src/c/Makefile`'s `check` target runs the freestanding + libc demos and verifies
exit codes / stdout / file round-trips (no unit framework). Cross-arch sources are
verified to compile to `.s`; non-host binaries aren't executed (would need qemu).

## Conventions

- The book text is faithful to upstream — preserve wording; pre-existing typos are
  a fidelity-vs-polish call noted in `tasks/archive/2026/05/24/SESSION_NOTES.md`.
- Generated assembly is meant to be *read* — keep the educational compiler flags.

## Tasks (in-flight)

Active work goes in `tasks/` (per the global convention); completed work is archived
under `tasks/archive/<YYYY>/<MM>/<DD>/`. The main open item is `tasks/build-matrix.md`:
ship cross-arch `.s` listings (`asm-out/<arch>/<demo>.s`) built at image time. Smaller
open items (GFDL license-text cleanup, an Inkscape-script typo) are recorded in the
archived `tasks/archive/2026/05/24/SESSION_NOTES.md`.

> Note: this repo's `entrypoint/` is the *origin* of the docs-build entrypoint that
> was mistakenly copied into gltron — keep that in mind if syncing scripts between
> projects.
