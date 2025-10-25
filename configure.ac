AC_PREREQ([2.69])
AC_INIT([pgu], [1.0], [billsix@gmail.com])

AC_ARG_ENABLE([extra-docs],
  [AS_HELP_STRING([--enable-extra-docs], [Enable extra docs install])],
    [enable_extra_docs=yes],
      [enable_extra_docs=no]
      )

# Write substitution variable for Makefile
if test "x$enable_extra_docs" = "xyes"; then
  BUILD_DOCS_FLAG=1
  DEFAULT_MAKE_GOAL=html
else
  BUILD_DOCS_FLAG=0
  DEFAULT_MAKE_GOAL=all
fi
AC_SUBST(BUILD_DOCS_FLAG)
AC_SUBST(DEFAULT_MAKE_GOAL)

AC_CONFIG_FILES([
   Makefile
   Dockerfile
])
AC_OUTPUT
