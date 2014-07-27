VERSION_STR="0.6devel"

PROGRAM = xlogdump
OBJS    = strlcpy.o xlogdump.o xlogdump_rmgr.o

PG_CPPFLAGS = -DVERSION_STR=\"$(VERSION_STR)\" -I. -I$(libpq_srcdir) -DDATADIR=\"$(datadir)\"
PG_LIBS = $(libpq_pgport)

DATA = oid2name.txt
EXTRA_CLEAN = oid2name.txt

DOCS = README.xlogdump

ifdef USE_PGXS
PGXS := $(shell pg_config --pgxs)
include $(PGXS)
else
subdir = contrib/xlogdump
top_builddir = postgres
include $(top_builddir)/src/Makefile.global
include $(top_srcdir)/contrib/contrib-global.mk
endif

majorversion=`echo $(VERSION) | sed -e 's/^\([0-9]*\)\.\([0-9]*\).*/\1\2/g'`

xlogdump_oid2name.o: oid2name.txt

oid2name.txt:
	cp oid2name-$(majorversion).txt oid2name.txt

xlogdump.so: $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) $(PG_LIBS) $(LDFLAGS) $(LDFLAGS_EX) $(LIBS) -o $@$(X)