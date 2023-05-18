#include "s21_grep.h"

int main(int argc, char *argv[]) {
  int error_n = 0;
  char **patterns = calloc(1, sizeof(char *));
  char **f_patterns = calloc(1, sizeof(char *));
  int array_p = 0;
  int array_f = 0;
  FLAGS fg = {};
  if (argc > 2) {
    error_n =
        oppars(&fg, argc, argv, &patterns, &array_p, &f_patterns, &array_f);
    if (error_n == 0) {
      if (fg.f)
        error_n = get_fpatterns(&patterns, &array_p, f_patterns, array_f);
      if (fg.e == 0 && fg.f == 0) get_spattern(argc, argv, &patterns, &array_p);
      if (error_n == 0) error_n = reader(fg, argc, argv, patterns, array_p);
    }
  } else {
    error_n = 1;
    printf("s21_grep: Not enough input arguments\n");
  }
  free_array(patterns, array_p);
  free_array(f_patterns, array_f);
  return error_n;
}

int oppars(FLAGS *fg, int argc, char *argv[], char ***patterns, int *array_p,
           char ***f_patterns, int *array_f) {
  int error_n = 0;
  int opchar = 0;
  char *opany = "e:ivclnhsf:o";
  while ((opchar = getopt_long(argc, argv, opany, NULL, NULL)) != -1) {
    switch (opchar) {
      case 'e':
        fg->e += 1;
        *patterns = get_string(*patterns, array_p, optarg);
        optarg[0] = '-';
        break;
      case 'i':
        fg->i = 1;
        break;
      case 'v':
        fg->v = 1;
        break;
      case 'c':
        fg->c = 1;
        break;
      case 'l':
        fg->l = 1;
        break;
      case 'n':
        fg->n = 1;
        break;
      case 'h':
        fg->h = 1;
        break;
      case 's':
        fg->s = 1;
        break;
      case 'f':
        fg->f = 1;
        *f_patterns = get_string(*f_patterns, array_f, optarg);
        optarg[0] = '-';
        break;
      case 'o':
        fg->o = 1;
        break;
      default:
        error_n = 3;
        break;
    }
  }
  return error_n;
}

char **get_string(char **array, int *size, char *string) {
  if (array != NULL && size != NULL && string != NULL) {
    *size += 1;
    array = realloc(array, *size * (sizeof(char *)));
    array[*size - 1] = malloc(sizeof(char) * (strlen(string) + 1));
    if (array[*size - 1] != NULL) strcpy(array[*size - 1], string);
  }
  return array;
}

int reader(FLAGS fg, int argc, char *argv[], char **patterns, int array_p) {
  unsigned long files_nINPUT = 0;
  int error_n = 0;
  FILE *file = NULL;
  for (int i = 1; i < argc; i++) {
    if (argv[i][0] != '-') {
      file = fopen(argv[i], "r");
      if (file == NULL) {
        error_n = 2;
        if (fg.s == 0)
          printf("s21_grep: %s: No such file or directory\n", argv[i]);
      } else {
        char str[BUFF_S + 1] = "";
        unsigned long line_n = 0;
        unsigned long line_nOUT = 0;
        files_nINPUT += 1;
        char f_name[1000] = "";
        if (file_n(argc, argv) && fg.h == 0) sprintf(f_name, "%s:", argv[i]);
        while (fgets(str, BUFF_S, file) != NULL)
          process_pcre(fg, str, &line_n, patterns, array_p, f_name, &line_nOUT);
        if (fg.c && fg.l == 0) printf("%s%lu\n", f_name, line_nOUT);
        if (fg.c && fg.l) printf("%s%d\n", f_name, line_nOUT > 0 ? 1 : 0);
        if (fg.l && line_nOUT) {
          printf("%s\n", argv[i]);
        }
        fclose(file);
      }
    }
  }
  if (files_nINPUT == 0 && error_n == 0 && array_p == 0) {
    error_n = 4;
    printf("s21_grep: Not enough input arguments\n");
  }
  if (fg.e == 0) error_n = 0;
  return error_n;
}

int file_n(int argc, char **argv) {
  int n_f = -1;
  for (int i = 1; i < argc; i++)
    if (argv[i][0] != '-') n_f++;
  return n_f;
}

void process_pcre(FLAGS fg, char *str, long unsigned *line_n, char **patterns,
                  int array_p, char *f_name, long unsigned *line_nOUT) {
  (*line_n)++;
  char l_number[25] = "";
  int options = 0;
  int patterns_v = 0;
  int string_c = 0;
  int line_p = 0;
  unsigned int length = strlen(str);
  if (fg.n) sprintf(l_number, "%lu:", *line_n);
  if (str[length - 1] == '\n') str[length - 1] = '\0';
  if (fg.i) options = PCRE_CASELESS;
  for (int j = 0; j < array_p; j++) {
    pcre *re;
    const char *error = NULL;
    int erroffset = 0;
    re = pcre_compile(patterns[j], options, &error, &erroffset, NULL);
    if (re == NULL) {
      printf("PCRE compilation failed at offset %d: %s\n", erroffset, error);
    } else {
      int rc;
      int ovector[OVECCOUNT];
      rc = pcre_exec(re, NULL, str, length, 0, 0, ovector, OVECCOUNT);
      if (rc > 0 && fg.v == 0) {
        if (string_c == 0) (*line_nOUT)++;
        if (fg.o) string_c = 1;
        if (fg.c == 0 && fg.l == 0 && fg.o == 0) {
          printf("%s%s%s\n", f_name, l_number, str);
        }
        if (fg.o == 0) {
          pcre_free(re);
          break;
        }
      } else if (rc == -1 && fg.v) {
        patterns_v++;
        if (array_p == patterns_v) {
          (*line_nOUT)++;
          if (fg.c == 0 && fg.l == 0) printf("%s%s%s\n", f_name, l_number, str);
        }
      }
      if (fg.o && fg.v == 0 && fg.c == 0 && fg.l == 0 && rc > 0) {
        unsigned int offset = 0;
        while (offset < length &&
               (rc = pcre_exec(re, 0, str, length, offset, 0, ovector,
                               sizeof(ovector))) >= 0) {
          for (int i = 0; i < rc; ++i) {
            if (line_p == 0) {
              printf("%s%s%.*s\n", f_name, l_number,
                     ovector[2 * i + 1] - ovector[2 * i], str + ovector[2 * i]);
              line_p = 1;
            } else {
              printf("%.*s\n", ovector[2 * i + 1] - ovector[2 * i],
                     str + ovector[2 * i]);
            }
          }
          offset = ovector[1];
        }
      }
    }
    pcre_free(re);
  }
}

void get_spattern(int argc, char *argv[], char ***patterns, int *array_p) {
  for (int i = 1; i < argc; i++) {
    if (argv[i][0] != '-') {
      *patterns = get_string(*patterns, array_p, argv[i]);
      argv[i][0] = '-';
      break;
    }
  }
}

int get_fpatterns(char ***patterns, int *array_p, char **f_patterns,
                  int array_f) {
  int error_n = 0;
  FILE *file = NULL;
  for (int i = 0; i < array_f; i++) {
    file = fopen(f_patterns[i], "r");
    if (file == NULL) {
      error_n = 2;
      printf("s21_grep: %s: No such file or directory\n", f_patterns[i]);
    } else {
      char str[BUFF_S + 1];
      while (fgets(str, BUFF_S, file) != NULL) {
        if (str[strlen(str) - 1] == '\n') str[strlen(str) - 1] = '\0';
        *patterns = get_string(*patterns, array_p, str);
      }
      fclose(file);
    }
  }
  return error_n;
}

void free_array(char **array, int size) {
  for (int i = 0; i < size; i++) free(array[i]);
  free(array);
}
