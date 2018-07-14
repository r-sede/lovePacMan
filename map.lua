
local map = {}
--readFile
contents = love.filesystem.read( 'assets/level.map')
iterator = love.filesystem.lines( 'assets/level.map' )

local rowN = 1
for line in iterator do
  map[rowN] = {}
  for i=1,#line do
    table.insert(map[rowN], tonumber(line:sub(i,i)))
  end
  rowN = rowN+1
end

return map