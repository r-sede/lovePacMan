PPM = 1
VW = 448
VH = 576
BLOCKSIZE = 16
MAP = nil
MAPSHEET = {}
MAPATLAS= nil
DEBUG = true
DOTS = 244
PAUSE = false
TITLESCREEN  = nil
CURRENTSTATE = 'title'
LEVEL=1
READYTIMER = 3
FONT = nil
HIGHSCORE = {}
CATCHPOINT = {200,400,800,1600,12000}
SAVEDIR = nil


function love.load(arg)
  love.math.setRandomSeed(love.timer.getTime())
  love.graphics.setDefaultFilter('nearest')
  require"pacMan"
  require"ghosts"
  require"pacManStates"
  require"levelSpec"
  getMaps = require('map')
  love.window.setMode((PPM * VW)   + 300  , PPM * VH)
  love.keyboard.setKeyRepeat(true)
  SAVEDIR =  love.filesystem.getSaveDirectory( )
  print(fileExists( SAVEDIR..'/highscore.score' ))
  if fileExists( SAVEDIR..'/highscore.score' ) then
    HIGHSCORE = linesFrom(SAVEDIR..'/highscore.score')
  else
    local f = io.open(SAVEDIR..'/highscore.score', 'w')
    f:write('0\n')
    f:close()
    HIGHSCORE = {0}
  end
  FONT = love.graphics.newFont('assets/fonts/emulogic.ttf', 8)
  love.graphics.setFont(FONT)
  MAPATLAS = love.graphics.newImage('assets/img/pacmanSpriteSheet.png')
  TITLESCREEN = love.graphics.newImage('assets/img/title.png')
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
      local curChar = MAP[j][i]
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
        local curChar = MAP[j][i]
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

function round(val)
  local floor = math.floor(val)
  if(val%1 >=0.5 ) then return floor+1 end
  return floor
end

function writeScore()
  local tmp = {}
  tmp[1] = pacMan.score
  for i=1,#HIGHSCORE do
    table.insert(tmp, HIGHSCORE[i])
  end
  local res = ''
  for i=1,#tmp do
    res = res..tmp[i]..'\n'
  end
  local f = io.open(SAVEDIR..'/highscore.score', 'w+')
  f:write(res)
  f:close()
end

function fileExists(name)
  local f=io.open(name,"r")
  if f~=nil then io.close(f) return true else return false end
end

function linesFrom(file)
  if not fileExists(file) then return {0} end
  lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = tonumber(line)
  end
  return lines
end