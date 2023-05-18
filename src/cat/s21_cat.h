#ifndef SRC_CAT_S21_CAT_H_
#define SRC_CAT_S21_CAT_H_

#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct {
  int b;
  int e;
  int n;
  int s;
  int t;
  int v;
} FLAGS;

int opparse(FLAGS *fg, int argc, char **argv);
int get_f(char *argv[], FLAGS *fg);
void process_cat(FLAGS *fg, FILE *f_name);

#endif  // SRC_CAT_S21_CAT_H_
