AC_PREREQ([2.69])
AC_INIT([pgu], [1.0], [billsix@gmail.com])
AC_CONFIG_SRCDIR([Makefile.in])

# Optional: enable Automake (uncomment if needed)
# AM_INIT_AUTOMAKE([foreign])

# --------------------------------------------------------------------
# Feature: --enable-extra-docs
# --------------------------------------------------------------------

AC_ARG_ENABLE([extra-docs],
  [AS_HELP_STRING([--enable-extra-docs], [Enable extra docs install])],
  [enable_extra_docs=$enableval],
  [enable_extra_docs=no]
)

# --------------------------------------------------------------------
# Compute build flags
# --------------------------------------------------------------------

BUILD_DOCS_FLAG=0
DEFAULT_MAKE_GOAL=all

if test "x$enable_extra_docs" = "xyes"; then
  BUILD_DOCS_FLAG=1
  DEFAULT_MAKE_GOAL=docs
fi

# --------------------------------------------------------------------
# Substitute values for Makefile / Dockerfile
# --------------------------------------------------------------------

AC_SUBST(BUILD_DOCS_FLAG)
AC_SUBST(DEFAULT_MAKE_GOAL)

# --------------------------------------------------------------------
# Output files
# --------------------------------------------------------------------

AC_CONFIG_FILES([
  Makefile
  Dockerfile
])
AC_OUTPUT
