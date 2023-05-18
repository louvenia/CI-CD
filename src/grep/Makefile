FLAGS = -std=c11 -Wall -Werror -Wextra -D_GNU_SOURCE -lpcre
FLAGSVALGRIND = -std=c11 -Wall -Werror -D_GNU_SOURCE -lpcre -Wextra -ggdb3
NAME = s21_grep

all: clean s21_grep

s21_grep:
	gcc $(NAME).c $(FLAGS) -o $(NAME)

test: s21_grep
	bash test_grep.sh

install_pcre:
	brew install pcre

lint:
	python3 ../../materials/linters/cpplint.py --extensions=c *.h *.c

cppcheck:
	cppcheck --enable=all --suppress=missingIncludeSystem *.c

leaks:
	leaks -atExit -- ./s21_grep -c -l dolor test/text1.txt

clean:
	rm -rf *.o *.so *.a $(NAME) log

rebuild: all
