#####################################################################
# CCNx libraries
#####################################################################
#   AX_CCNX([MINIMUM-API-VERSION], [ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
#
# DESCRIPTION
#
#	If no path to the installed CCNx library is given the macro searches
#	under /usr, /usr/local, /opt and /opt/local
#
#   This macro calls:
#
#     AC_SUBST(CCNX_CFLAGS) / AC_SUBST(CCNX_LDFLAGS) / AC_SUBST(CCNX_LIBS)
#
#   And sets:
#
#    HAVE_CCNX 
#
# LICENSE
#	Copyright (c) 2011 Alexander Afanasyev <alexander.afanasyev@ucla.edu>
#
#	Copying and distribution of this file, with or without modification, are
#	permitted in any medium without royalty provided the copyright notice
#	and this notice are preserved. This file is offered as-is, without any
#	warranty.

AC_DEFUN([AX_CCNX],
[
AC_ARG_WITH([ccnx],
  [AS_HELP_STRING([--with-ccnx@<:@=ARG@:>@],
    [use CCNx library from a standard location (ARG=yes),
     from the specified location (ARG=<path>),
     or disable it (ARG=no)
     @<:@ARG=yes@:>@ ])],
    [
    if test "$withval" = "no"; then
      want_ccnx="no"
    elif test "$withval" = "yes"; then
      want_ccnx="yes"
      ac_ccnx_path=""
    else
      want_ccnx="yes"
      ac_ccnx_path="$withval"
    fi
    ],
    [want_ccnx="yes"])

if test "x$want_ccnx" = "xyes"; then
  ccnx_lib_version_req=ifelse([$1], ,0.4.0,$1)
  ccnx_lib_version_req_major=`expr $ccnx_lib_version_req : '\([[0-9]]*\)'`
  ccnx_lib_version_req_minor=`expr $ccnx_lib_version_req : '[[0-9]]*\.\([[0-9]]*\)'`
  ccnx_lib_version_req_sub_minor=`expr $ccnx_lib_version_req : '[[0-9]]*\.[[0-9]]*\.\([[0-9]]*\)'`
  if test "x$ccnx_lib_version_req_sub_minor" = "x" ; then
    ccnx_lib_version_req_sub_minor="0"
  fi
  WANT_CCNX_VERSION=`expr $ccnx_lib_version_req_major \* 100000 \+  $ccnx_lib_version_req_minor \* 1000 \+ $ccnx_lib_version_req_sub_minor`

  AC_MSG_CHECKING(for CCNx library with API version >= $ccnx_lib_version_req)
  succeeded=no

  basedirs="/usr /usr/local /opt /opt/local"
  libsubdirs="lib64 lib"
  
  for ccnx_base_tmp in $basedirs ; do
    if test -d "$ccnx_base_tmp/include/ccn" && test -r "$ccnx_base_tmp/include/ccn"; then
      for libsubdir in $libsubdirs ; do
        if ls "$ccnx_base_tmp/$libsubdir/libccn"* >/dev/null 2>&1 ; then break; fi
      done
      CCNX_LDFLAGS="-L$ccnx_base_tmp/$libsubdir"
      CCNX_CFLAGS="-I$ccnx_base_tmp/include"
      break;
    fi
  done

  AC_REQUIRE([AC_PROG_CC])
  AC_LANG_PUSH([C])
    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
        @%:@include <ccn/ccn.h>
      ]], [[
        #if CCN_API_VERSION >= $WANT_CCNX_VERSION
        // Everything is okay
        #else
        #  error CCNx API version is too old
        #endif
    ]])],[
      AC_MSG_RESULT(yes)
      CCNX_LIBS="-lccn"
      succeeded=yes
    ],[
    ])
  AC_LANG_POP([C]) 

  if test "$succeeded" != "yes" ; then
    # execute ACTION-IF-NOT-FOUND (if present):
    ifelse([$3], , :, [$3])
  else
    AC_SUBST(CCNX_CFLAGS)
    AC_SUBST(CCNX_LDFLAGS)
    AC_SUBST(CCNX_LIBS)
    AC_DEFINE(HAVE_CCNX,,[define if the CCNx library is available])
    # execute ACTION-IF-FOUND (if present):
    ifelse([$2], , :, [$2])
  fi
fi

])

