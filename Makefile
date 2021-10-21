# Makefile for building the NIF
#
# MIX_APP_PATH		path to the build directory
# ERL_EI_INCLUDE_DIR	include path to erlang header
# ERL_EI_LIBDIR		path to erlang/c libraries (Not necessary for NIFs)
 
PREFIX = $(MIX_APP_PATH)/priv
BUILD = $(MIX_APP_PATH)/obj

NIF = $(PREFIX)/ddstest_nif.so

CC = gcc
RM = rm

CFLAGS ?= -O2 -Wall -Wextra -Wno-unused-parameter -pedantic -fPIC
LDFLAGS += -fPIC -shared

# Set Erlang-specific compiler and linker flags
ERL_CFLAGS ?= -I$(ERL_EI_INCLUDE_DIR)
ERL_LDFLAGS ?= -L$(ERL_EI_LIBDIR)

DDS_LDFLAGS ?= -L/usr/local/lib
DDS_LDFLAGS += -lddsc

SRC = src/ddstest_nif.c src/HelloWorldData.c
HEADERS =$(wildcard src/*.h)
OBJ =$(SRC:src/%.c=$(BUILD)/%.o)

all: install

install: $(PREFIX) $(BUILD) $(NIF)

$(OBJ): $(HEADERS) Makefile

$(BUILD)/%.o: src/%.c
	$(CC) -c $(ERL_CFLAGS) $(CFLAGS) -o $@ $<

$(NIF): $(OBJ)
	$(CC) -o $@ $(ERL_LDFLAGS) $(LDFLAGS) $^ $(DDS_LDFLAGS)

$(PREFIX):
	mkdir -p $@

$(BUILD):
	mkdir -p $@

clean:
	$(RM) $(NIF) $(BUILD)/*.o

.PHONY: all clean install
