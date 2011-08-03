#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.61])
AC_INIT([ccn-dhcp], [0.1], [chenyi@email.arizona.edu])
AC_CONFIG_SRCDIR([src/ccn_dhcp.h])
AC_CONFIG_HEADERS([src/config.h])

AM_INIT_AUTOMAKE([1.10])

# Checks for programs.
AC_PROG_CC
AM_PROG_CC_C_O

# Checks for libraries.
# CCNx Library
AX_CCNX([0.4.0],[],[AC_MSG_ERROR([Required CCNx library not found])])

# OpenSSL
AX_CHECK_OPENSSL([],[AC_MSG_ERROR([Required OpenSSL libraries not found])])

# Checks for header files.
# AC_CHECK_HEADERS([netdb.h netinet/in.h stdlib.h string.h sys/time.h unistd.h])

# Checks for typedefs, structures, and compiler characteristics.
# AC_TYPE_SIZE_T

# Checks for library functions.
# AC_CHECK_FUNCS([gettimeofday memset strerror])

AC_CONFIG_FILES([Makefile
				 etc/Makefile
                 src/Makefile])
AC_OUTPUT
