PPM = 1.5
VW = 448
VH = 496
BLOCKSIZE = 16;
MAP = nil;
MAPSHEET = {}
MAPATLAS= nil;

function love.load()
  love.graphics.setDefaultFilter('nearest')
  require"pacMan"
  love.window.setMode(PPM * VW, PPM * VH)
  love.keyboard.setKeyRepeat(true)
  MAP = require('map')
  MAPATLAS = love.graphics.newImage('assets/img/pacmanSpriteSheet.png');
  MAPSHEET[1] = love.graphics.newQuad(0*16, 0, 16, 16, MAPATLAS:getDimensions())
  MAPSHEET[2] = love.graphics.newQuad(1*16, 0, 16, 16, MAPATLAS:getDimensions())
  MAPSHEET[3] = love.graphics.newQuad(2*16, 0, 16, 16, MAPATLAS:getDimensions())
  MAPSHEET[4] = love.graphics.newQuad(3*16, 0, 16, 16, MAPATLAS:getDimensions())
  MAPSHEET[5] = love.graphics.newQuad(4*16, 0, 16, 16, MAPATLAS:getDimensions())
  MAPSHEET[6] = love.graphics.newQuad(5*16, 0, 16, 16, MAPATLAS:getDimensions())
  MAPSHEET[9] = love.graphics.newQuad(6*16, 0, 16, 16, MAPATLAS:getDimensions())
  MAPSHEET[8] = love.graphics.newQuad(7*16, 0, 16, 16, MAPATLAS:getDimensions())

  
end

function love.update(dt)
end

function love.draw()
  drawMap()

  pacMan:draw()
end

function love.keypressed(key, scancode, isRepeat)

end


function drawMap()
  for j=1,#MAP do
    for i=1,#MAP[j] do
      ii = i-1
      jj = j-1
      local curChar = MAP[j][i];
      if curChar ~= 7  then
        love.graphics.draw(MAPATLAS,MAPSHEET[curChar],ii*BLOCKSIZE*PPM,jj*BLOCKSIZE*PPM,0,PPM,PPM )
      end
    end
  end
end

-- maTable={class="sss",closs="ppp"}
-- for k,v in ipairs(maTable) do 
--   print(k,' ; ',v)
-- end