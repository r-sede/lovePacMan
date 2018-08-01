PPM = 1
VW = 448
VH = 576
BLOCKSIZE = 16;
MAP = nil
MAPSHEET = {}
MAPATLAS= nil
DEBUG = true
DOTS = 244
PAUSE = false
CURRENTSTATE = 'game'

function love.load(arg)
  love.math.setRandomSeed(love.timer.getTime())
  love.graphics.setDefaultFilter('nearest')
  require"pacMan"
  require"ghosts"
  require"pacManStates"
  love.window.setMode((PPM * VW) + 300, PPM * VH)
  love.keyboard.setKeyRepeat(true)
  local getMaps = require('map')
  MAP,OBSTACLE,COLLECTABLE = getMaps('map')
  
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
  if PAUSE then return end
  pacMan_states[CURRENTSTATE].update(dt)

end

function love.draw()
  pacMan_states[CURRENTSTATE].draw()

end

function love.keypressed(key, scancode, isRepeat)
  pacMan_states[CURRENTSTATE].keypressed(key)


end


function drawMap()
  for j=1,#MAP do
    for i=1,#MAP[j] do
      ii = i-1
      jj = j-1
      local curChar = MAP[j][i];
      if curChar >0   then
        love.graphics.draw(MAPATLAS,MAPSHEET[curChar],ii*BLOCKSIZE*PPM,jj*BLOCKSIZE*PPM,0,PPM,PPM )
      end
      local collectChar = COLLECTABLE[j][i]
      if collectChar >0   then
        love.graphics.draw(MAPATLAS,MAPSHEET[collectChar],ii*BLOCKSIZE*PPM,jj*BLOCKSIZE*PPM,0,PPM,PPM )
      end
    end
  end
  
  if(DEBUG) then
    for j=1,#MAP do
      for i=1,#MAP[j] do
        ii = i-1
        jj = j-1
        local curChar = MAP[j][i];
        if curChar>0  then
          love.graphics.print(curChar,ii*BLOCKSIZE*PPM,jj*BLOCKSIZE*PPM)
          love.graphics.rectangle("line",ii*BLOCKSIZE*PPM,jj*BLOCKSIZE*PPM,PPM*BLOCKSIZE,PPM*BLOCKSIZE )
        end
      
      end
    end
  end
end

function animate (this, dt)
  this.animTimer = this.animTimer - dt
  if this.animTimer <= 0 then
    this.animTimer = 1 / this.fps
    this.keyframe = this.keyframe + 1
    if this.keyframe > this.nbrFrame then this.keyframe = 1 end
  end
end

function handleDirection (this)
  if this.direction == 'left' then 
    this.scaleSignX = -1
    this.scaleSignY = 1
    this.angle = 0
  elseif this.direction == 'right' then
    this.scaleSignX = -1
    this.scaleSignY = -1
    this.angle =  math.pi
  elseif this.direction == 'up' and this == pacMan then
    this.scaleSignX = -1
    this.scaleSignY = 1
    this.angle =  math.pi * 0.5
  elseif this.direction == 'down' and this == pacMan then
    this.scaleSignX = -1
    this.scaleSignY = 1
    this.angle =  math.pi * 3 * 0.5
  end
end
-- maTable={class="sss",closs="ppp"}
-- for k,v in ipairs(maTable) do 
--   print(k,' ; ',v)
-- end

function round(val)
  local floor = math.floor(val)
  if(val%1 >=0.5 ) then return floor+1 end
  return floor
end

--[[ function getTile(arr, x , y)
  local res = arr[y][x]
  if res then return res end
  print('index error x: '..x..' ;y: '..y )
end

function getSurTiles(x,y)
  return {
    up = getTile(OBSTACLE,x, y - 1),
    left = getTile(OBSTACLE, x - 1, y),
    down = getTile(OBSTACLE, x, y + 1),
    right = getTile(OBSTACLE, x + 1, y),
  }
end ]]