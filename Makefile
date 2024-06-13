
CC = gcc

WFLAGS = -Wall -Werror -fmax-errors=3

#WEXTRA = -Wextra -Wno-unused-parameter

CFLAGS = -O2 -ansi -pedantic $(WFLAGS) $(WEXTRA)

miniscm:	miniscm.c miniscm.h
	$(CC) $(CFLAGS) -o miniscm -static miniscm.c

miniscm.h:	c-hexify.sh miniscm.scm
	echo "/* This file was automatically generated. Do not edit! */" \
		>miniscm.h
	echo "#define init_scm_LAST_ITEM ,0" >>miniscm.h
	NAME=init_scm ./c-hexify.sh <miniscm.scm >>miniscm.h

test:	miniscm
	rm -f __TESTFILE__ && echo '(load "test.scm")' | ./miniscm -q

csums:
	txsum -u <_checksums >_checksums.new && mv -f _checksums.new _checksums

clean:
	rm -f miniscm miniscm.h __TESTFILE__
