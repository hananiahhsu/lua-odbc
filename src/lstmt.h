#ifndef _LSTMT_H_667A2063_E838_4674_BB89_519BB67FCF41_
#define _LSTMT_H_667A2063_E838_4674_BB89_519BB67FCF41_

#include "lodbc.h"

typedef struct par_data_tag par_data;
typedef struct lodbc_cnn lodbc_cnn;

typedef struct lodbc_stmt{
  uchar     flags;
  SQLHSTMT  handle;
  int       coltypes, colnames;
  int       numcols, numpars;
  int       resultsetno;
  uchar     autoclose;
  par_data  *par;
  lodbc_cnn *cnn;
  int       cnn_ref;
} lodbc_stmt;

lodbc_stmt *lodbc_getstmt_at (lua_State *L, int i);
#define lodbc_getstmt(L) lodbc_getstmt_at((L),1)

void lodbc_stmt_initlib (lua_State *L, int nup);

int lodbc_statement_create (lua_State *L, SQLHSTMT hstmt, lodbc_cnn *cnn, int cnn_idx, uchar own, int ncols, uchar opened);

#endif 