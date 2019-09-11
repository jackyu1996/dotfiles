CC      = gcc
CFLAGS  = -std=c11
CFLAGS += -isystem /usr/include/
CFLAGS += -Wall
CFLAGS += -Werror
CFLAGS += -Wextra
CFLAGS += -O3
CFLAGS += -g
#libs	=
#LDLIBS = $(shell pkg-config --libs $(libs))
#CFLAGS += $(shell pkg-config --cflags $(libs))

all: *.c
	$(CC) $< $(CFLAGS) $(LDLIBS) -o main

%: %.c
	$(CC) $< $(CFLAGS) $(LDLIBS) -o $@
