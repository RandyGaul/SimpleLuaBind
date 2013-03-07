#include "Precompiled.h"
#include <cstdio>

lua_State *L;

// Runs luaL_dofile on a specified lua text file
void LoadFile( lua_State *lua, const char *path )
{
  int errorStatus = luaL_dofile( lua, path );

  if(errorStatus)
    printf( lua_tostring( lua, -1 ) );
}

// Dumps the contents of the Lua stack
void StackDump( lua_State *L )
{
  int top = lua_gettop( L );

  printf( "\nLua Stack Dump:" );
  printf( "  Sizeof stack: %d\n", top );

  for(int i = 1; i <= top; ++i)
  {
    int type = lua_type(L,i);
    switch (type)
    {
    case LUA_TSTRING:   printf( "  %d: %s\n", i , lua_tostring(  L, i    ) ); break;
    case LUA_TBOOLEAN:  printf( "  %d: %d\n", i , lua_toboolean( L, i    ) ); break;
    case LUA_TNUMBER:   printf( "  %d: %g\n", i , lua_tonumber(  L, i    ) ); break;
    default:            printf( "  %d: %s\n", i , lua_typename(  L, type ) ); break;
    }
  }

  printf( "  -->End stack dump.\n" );
}

#define SIZEOF_ARRAY( ARRAY ) \
  sizeof( ARRAY ) / sizeof( *ARRAY )

#define REGISTER_FUNCTIONS( FUNCTIONS )                       \
  for(unsigned i = 0; i < SIZEOF_ARRAY( FUNCTIONS ) - 1; ++i) \
  {                                                           \
    lua_pushcfunction( L, FUNCTIONS[i].func );                \
    lua_setglobal( L, FUNCTIONS[i].name );                    \
  }

// All functions that can be called from Lua must be like this:
// int (*) (lua_State *L)
int HelloWorld( lua_State *L )
{
  printf( "Hello World!\n" );
  return 0; // number of arguments to return
}

int Multiply( lua_State *L )
{
  // Print the contents of the Lua stack
  //StackDump( L );

  // Get a float from the first value on the Lua stack, from Lua
  float a = (float)lua_tonumber( L, 1 );
  
  // Get a float from the second value on the Lua stack, from Lua
  float b = (float)lua_tonumber( L, 2 );

  // Clear the Lua stack
  lua_pop( L, lua_gettop( L ) );

  //StackDump( L );

  // Send a number to lua. A number can be: integer, double, float
  float number = a * b;
  lua_pushnumber( L, number );

  //StackDump( L );

  return 1; // number of arguments to return
}

int GetTwoStrings( lua_State *L )
{
  // Send a string to lua
  lua_pushstring( L, "String number one." );
  lua_pushstring( L, "String number two.\n" );

  return 2;
}

int Pause( lua_State *L )
{
  getchar( );
  return 0;
}

// Collection of C functions to send to Lua
static const luaL_Reg SampleFunctions[] =
{
  { "HelloWorld",     HelloWorld    },
  { "Multiply",       Multiply      },
  { "GetTwoStrings",  GetTwoStrings },
  { "Pause",          Pause         },
  { NULL,             NULL          } // Last one has to be NULL, NULL
};

int main( void )
{
  // Create a lua environment
  L = luaL_newstate( );

  // Open Lua's standard libraries
  luaL_openlibs( L );

  // Bind all the functions in the array SampleFunctions to Lua
  REGISTER_FUNCTIONS( SampleFunctions );

  // Load a lua file and run the lua code inside
  LoadFile( L, "example.lua" );
}
