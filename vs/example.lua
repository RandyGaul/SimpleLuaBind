print( "example.lua has been loaded." )
print( "" )

-- Call function from C++
HelloWorld( )

-- Write to stdout without a newline
io.write( "Multiplying 1 and 2: " )

-- Write to stdout
print( Multiply( 1, 2 ) )

-- Call another function from C++
print( GetTwoStrings( ) )

local loop = true
local loop_count = 0

while loop do
  io.write( "Lua loop count:" )
  print( loop_count )
  Pause( )
  loop_count = loop_count + 1
end