#include "s21_cat.h"

int main(int argc, char **argv) {
  FLAGS fg = {0};
  int error_n = 0;
  error_n = opparse(&fg, argc, argv);
  while (optind < argc) {
    error_n = get_f(argv, &fg);
    optind++;
  }
  return error_n;
}

struct option const options_GNU[] = {
    {"number-nonblank", no_argument, NULL, 'b'},
    {"show-ends", no_argument, NULL, 'E'},
    {"number", no_argument, NULL, 'n'},
    {"squeeze-blank", no_argument, NULL, 's'},
    {"show-tabs", no_argument, NULL, 'T'},
    {"show-nonprinting", no_argument, NULL, 'v'},
    {NULL, 0, NULL, 0},
};

int opparse(FLAGS *fg, int argc, char **argv) {
  int error_n = 0;
  char *opany = "benstvET";
  int opchar;
  while ((opchar = getopt_long(argc, argv, opany, options_GNU, NULL)) != -1) {
    switch (opchar) {
      case 'b':
        fg->b = 1;
        break;
      case 'e':
        fg->e = 1;
        fg->v = 1;
        break;
      case 'n':
        fg->n = 1;
        break;
      case 's':
        fg->s = 1;
        break;
      case 't':
        fg->t = 1;
        fg->v = 1;
        break;
      case 'v':
        fg->v = 1;
        break;
      case 'E':
        fg->e = 1;
        break;
      case 'T':
        fg->t = 1;
        break;
      default:
        printf("s21_cat: invalid option '%s'\n", *argv);
        error_n = 1;
        break;
    }
  }
  return error_n;
}

int get_f(char *argv[], FLAGS *fg) {
  FILE *f_name;
  int error_n = 0;
  f_name = fopen(argv[optind], "r");
  if (f_name) {
    process_cat(fg, f_name);
    fclose(f_name);
  } else {
    error_n = 2;
  }
  return error_n;
}

void process_cat(FLAGS *fg, FILE *f_name) {
  double count = 1.0;
  int empty = 0;
  int prev_ch = '\n';
  int get_ch;
  while ((get_ch = fgetc(f_name)) != EOF) {
    if (fg->b && fg->n) fg->n = 0;
    if (fg->s && get_ch == '\n' && prev_ch == '\n') {
      empty++;
      if (empty > 1) continue;
    } else {
      empty = 0;
    }
    if (fg->n && prev_ch == '\n') printf("%6.0lf\t", count++);
    if (fg->b && get_ch != '\n' && prev_ch == '\n') printf("%6.0lf\t", count++);
    if (fg->t && get_ch == '\t') {
      printf("^");
      get_ch = 'I';
    }
    if (fg->e && get_ch == '\n') printf("$");
    if (fg->v) {
      if ((get_ch >= 0 && get_ch < 9) || (get_ch > 10 && get_ch < 32) ||
          get_ch == 127) {
        if (get_ch == 127) {
          printf("^?");
          prev_ch = get_ch;
          continue;
        } else {
          printf("^");
          get_ch += 64;
        }
      }
    }
    printf("%c", get_ch);
    prev_ch = get_ch;
  }
}
