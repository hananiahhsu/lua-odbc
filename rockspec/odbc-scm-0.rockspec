package = "odbc"
version = "scm-0"
source = {
  url = "https://github.com/moteus/lua-odbc/archive/master.zip",
  dir = "lua-odbc-master",
}

description = {
  summary = "ODBC library for Lua",
  detailed = [[
  ]],
  homepage = "https://github.com/moteus/lua-odbc",
  license  = "MIT/X11",
}

dependencies = {
  "lua >= 5.1",
}

local win_dep = { ODBC = {} };

external_dependencies = {
  platforms = { 
    unix = {
      ODBC = {
        header  = 'sql.h',
        -- library = 'odbc', -- does not work !?
      }
    };
    mingw32 = win_dep;
    windows = win_dep;
  }
}

local win_plat = { modules = {
  [ "odbc.core" ] = {
    libraries = {'odbc32', 'odbccp32'};
  }
}}

build = {
  type = "builtin",
  copy_directories = {"test"},

  platforms = {
    mingw32 = win_plat,
    windows = win_plat,
    unix = { modules = {
      [ "odbc.core"    ] = {
        libraries = {'odbc'};
      }
    }},
  },

  modules = {
    [ "odbc.core"    ] = {
      sources = {
        'src/l52util.c', 'src/lcnn.c',
        'src/lenv.c',    'src/lerr.c',
        'src/libopt.c',  'src/lodbc.c',
        'src/lstmt.c',   'src/lval.c',
        'src/parlist.c', 'src/utils.c',
        -- 'src/driverinfo.c',
      };
      defines = {
        'UNIXODBC';
        'LUAODBC_EXPORTS';
        'LODBC_ERROR_AS_OBJECT';
        'LODBC_MIN_PAR_BUFSIZE=64';
        -- 'LODBC_FREE_PAR_AT_CLEAR';
        -- 'LODBC_USE_LUA_REGISTRY';
        -- 'LODBC_USE_UDPTR_AS_KEY';
        -- 'LODBC_USE_NULL_AS_NIL';
      };
      incdirs = {"./include","$(ODBC_INCDIR)"},
      libdirs = {"$(ODBC_LIBDIR)"},
    };
    [ "odbc"           ] = "lua/odbc.lua";
    [ "odbc.luasql"    ] = "lua/odbc/luasql.lua";
    [ "odbc.dba"       ] = "lua/odbc/dba.lua";
    [ "odbc.dba.utils" ] = "lua/odbc/dba/utils.lua";
    [ "odbc.proxy"     ] = "lua/odbc/proxy.lua";
  }
}
