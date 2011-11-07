# $PostgreSQL: pgsql/contrib/pgbench/Makefile,v 1.14 2005/09/27 17:13:08 tgl Exp $

PROGRAM = xlogdump
OBJS    = xlogdump.o xlogdump_rmgr.o xlogdump_statement.o xlogdump_oid2name.o $(top_builddir)/src/port/sprompt.o $(top_builddir)/src/backend/utils/hash/pg_crc.o

PG_CPPFLAGS = -I$(libpq_srcdir) -DDATADIR=\"$(datadir)\"
PG_LIBS = $(libpq_pgport)

DATA = oid2name.txt

DOCS = README.xlogdump

ifdef USE_PGXS
PGXS := $(shell pg_config --pgxs)
include $(PGXS)
else
subdir = contrib/xlogdump
top_builddir = ../..
include $(top_builddir)/src/Makefile.global
include $(top_srcdir)/contrib/contrib-global.mk
endif
