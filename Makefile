BIN=bin
INC=include
OBJ=objects
SRC=src

CC=gcc
CFLAGS=-O0 -I$(INC)
LDFLAGS=-lsqlite3

all:
	make $(BIN)/blag.cgi
	make $(BIN)/createdb
	make $(BIN)/post

$(BIN)/blag.cgi: $(SRC)/webapp.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

$(BIN)/createdb: $(SRC)/createdb.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

$(BIN)/post: $(OBJ)/sha1.o $(SRC)/post.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

$(OBJ)/sha1.o: $(SRC)/sha1.c
	$(CC) $(CFLAGS) -c -o $@ $^

install: $(BIN)/blag.cgi
	cp -f $(BIN)/blag.cgi /usr/lib/cgi-bin

clean:
	rm -f $(OBJ)/*
	rm -f $(BIN)/*
