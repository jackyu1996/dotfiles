CC      = gcc
CFLAGS  = -std=c11
LDLIBS  =
CFLAGS += -isystem /usr/include/
CFLAGS += -Wall
CFLAGS += -Werror
CFLAGS += -Wextra
CFLAGS += -O3
CFLAGS += -g

all: *.c
	$(CC) $< $(CFLAGS) $(LDLIBS) -o main

%: %.c
	$(CC) $< $(CFLAGS) $(LDLIBS) -o $@
