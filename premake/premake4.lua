driverSrc = "../src/driver/"
luaSrc = "../src/lua/"

-----------------------------------------------------------------
--                     Solution Settings                       --
-----------------------------------------------------------------
solution ( "../vs/SimpleLuaBind" )
  -- Different types of configurations for the solution
  configurations { "Debug", "Release" }

-----------------------------------------------------------------
--      This entire section belongs to a single project        --
-----------------------------------------------------------------
project ( "driver" )
  language ( "C++" )
  kind ( "ConsoleApp" )
  location ( "../vs" )
  objdir ( "../objs" )
  targetdir ( "../bin" )
  libdirs { "../dependencies/" .. "**" }
  includedirs { "../dependencies/include" }

  -- Types of files to include within this project
  files {
    driverSrc .. "**.h",
    driverSrc .. "**.hpp",
    driverSrc .. "**.cpp",
    driverSrc .. "**.c",
    driverSrc .. "**.txt",
    driverSrc .. "**.fx"
  }

  -- Debug Configuration Settings
  configuration "Debug"
    defines { "_DEBUG" }
    flags {
      "Symbols",
      "NoMinimalRebuild",
      "NoEditAndContinue",
      "FloatStrict",
      "StaticRuntime",
      "WinMain",
      "NoRTTI"
      }
      
    links {
      "Lua"
    }
    
    pchheader ( "Precompiled.h" )
    pchsource ( driverSrc .. "Precompiled.cpp" )

    -- disable specific warnings:
    buildoptions { "/wd4100", "/wd4996", "/wd4201", "/wd4238", "/wd4800", "/wd4239", "/wd4505" }

  -- Release Configuration Settings
  configuration "Release"
    defines { "NDEBUG" }
    flags {
      "Symbols",
      "NoMinimalRebuild",
      "NoEditAndContinue",
      "FloatFast",
      "StaticRuntime",
      "WinMain",
      "OptimizeSpeed",
      "NoRTTI"
      }
      
    links {
      "Lua"
    }
    
    pchheader ( "Precompiled.h" )
    pchsource ( driverSrc .. "Precompiled.cpp" )

    -- disable specific warnings:
    buildoptions { "/wd4100", "/wd4996", "/wd4201", "/wd4238", "/wd4800", "/wd4239", "/wd4505" }

-----------------------------------------------------------------
--      This entire section belongs to a single project        --
-----------------------------------------------------------------
project ( "Lua" )
  language ( "C" )
  kind ( "StaticLib" )
  location ( "../vs" )
  objdir ( "../objs" )
  targetdir ( "../bin" )
  includedirs { "../dependencies/include" }
  

  files {
    luaSrc .. "**.h",
    luaSrc .. "**.c"
  }

  -- Debug Configuration Settings
  configuration "Debug"
    defines { "_DEBUG" }
    flags {
      "Symbols",
      "NoMinimalRebuild",
      "NoEditAndContinue",
      "FloatStrict",
      "StaticRuntime",
      "WinMain",
      "NoRTTI"
      }

    -- disable specific warnings:
    buildoptions { "/wd4100", "/wd4996", "/wd4201", "/wd4238", "/wd4800", "/wd4239", "/wd4505" }

  -- Release Configuration Settings
  configuration "Release"
    defines { "NDEBUG" }
    flags {
      "Symbols",
      "NoMinimalRebuild",
      "NoEditAndContinue",
      "FloatFast",
      "StaticRuntime",
      "WinMain",
      "OptimizeSpeed",
      "NoRTTI"
      }

    -- disable specific warnings:
    buildoptions { "/wd4100", "/wd4996", "/wd4201", "/wd4238", "/wd4800", "/wd4239", "/wd4505" }
