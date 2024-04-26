NAME=matt-daemon

SRC_DIR=src
INC_DIRS=inc
BUILD_DIR=build

SRC=$(shell find $(SRC_DIR) -type f -name '*.cxx')
OBJ=$(SRC:$(SRC_DIR)/%.cxx=$(BUILD_DIR)/%.o)
DEP=$(OBJ:.o=.d)

RM=rm -rf
CXX=clang++
CXXFLAGS=-Wall -Werror -Wextra -pedantic $(foreach DIR, $(INC_DIRS), -I$(DIR)) -MMD -std=c++20

all: $(BUILD_DIR) $(NAME)

-include $(DEP)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(NAME): $(OBJ)
	$(CXX) $(CXXFLAGS) $^ -o $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cxx
	$(CXX) $(CXXFLAGS) -c $^ -o $@

clean:
	$(RM) $(BUILD_DIR)

fclean: clean
	$(RM) $(NAME)

re: fclean all

.PHONY: all clean fclean re
