FLAGS = -std=c11 -Wall -Werror -Wextra
NAME = s21_cat

all: clean s21_cat

s21_cat:
	gcc $(NAME).c $(FLAGS) -o $(NAME)

test: s21_cat
	bash cat.sh

lint:
	python3 ../../materials/linters/cpplint.py --extensions=c *.h *.c

cppcheck:
	cppcheck --enable=all --suppress=missingIncludeSystem *.c

leaks:
	leaks -atExit -- ./s21_cat

clean:
	rm -rf *.o *.so *.a $(NAME) log

rebuild: all
