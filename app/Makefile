PROGRAM_NAME := db-cli

BIN_PATH := bin
OBJ_PATH := obj
SRC_PATH := src

CC = g++
CFLAGS = -Wall -Wextra -pedantic
LDLIBS = -lpqxx -lpq

################################################

SOURCES := $(wildcard $(SRC_PATH)/*.cpp)
HEADERS := $(wildcard $(SRC_PATH)/*.hpp)
OBJECTS := $(addprefix $(OBJ_PATH)/, $(notdir $(SOURCES:.cpp=.o)))
PROGRAM := $(BIN_PATH)/$(PROGRAM_NAME)

.SUFFIXES:
.PHONY: all clean mkdir build run

all: mkdir $(PROGRAM)

$(OBJ_PATH)/%.o: $(SRC_PATH)/%.cpp $(HEADERS)
	$(CC) -c $(CFLAGS) $< -o $@

$(PROGRAM): $(OBJECTS) $(LDLIBS)
	$(CC) $(CFLAGS) $^ -o $@

mkdir:
	@mkdir -p $(BIN_PATH) $(OBJ_PATH)

clean:
	$(RM) $(OBJECTS) $(PROGRAM)

build: all

run:
	$(PROGRAM)
