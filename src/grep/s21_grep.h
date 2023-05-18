#ifndef SRC_GREP_S21_GREP_H_
#define SRC_GREP_S21_GREP_H_

#include <getopt.h>
#include <pcre.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define OVECCOUNT 30000
#define BUFF_S 10000

typedef struct {
  int e;
  int i;
  int v;
  int c;
  int l;
  int n;
  int h;
  int s;
  int f;
  int o;
} FLAGS;

int oppars(FLAGS *fg, int argc, char *argv[], char ***patterns, int *array_p,
           char ***f_patterns, int *array_f);
char **get_string(char **array, int *size, char *string);
int reader(FLAGS fg, int argc, char *argv[], char **patterns, int array_p);
int file_n(int argc, char **argv);
void process_pcre(FLAGS fg, char *str, long unsigned *line_n, char **patterns,
                  int array_p, char *f_name, long unsigned *line_nOUT);
void get_spattern(int argc, char *argv[], char ***patterns, int *array_p);
int get_fpatterns(char ***patterns, int *array_p, char **f_patterns,
                  int array_f);
void free_array(char **array, int size);

#endif  // SRC_GREP_S21_GREP_H_
