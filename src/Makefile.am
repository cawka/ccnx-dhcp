AM_CFLAGS=$(CCNX_CFLAGS) $(OPENSSL_INCLUDES)

bin_PROGRAMS = ccndhcpserver ccndhcpclient

ccndhcpserver_SOURCES = \
ccn_dhcp.h	\
ccndhcp.c	\
ccndhcpserver.c

ccndhcpserver_CFLAGS=$(AM_CFLAGS) -DSYSCONFDIR=\"$(sysconfdir)\"
ccndhcpserver_LDFLAGS=$(CCNX_LDFLAGS) $(OPENSSL_LDFLAGS)
ccndhcpserver_LDADD=$(CCNX_LIBS) $(OPENSSL_LIBS)

ccndhcpclient_SOURCES = \
ccn_dhcp.h	\
ccndhcp.c	\
ccndhcpclient.c

ccndhcpclient_LDFLAGS=$(CCNX_LDFLAGS) $(OPENSSL_LDFLAGS)
ccndhcpclient_LDADD=$(CCNX_LIBS) $(OPENSSL_LIBS)

