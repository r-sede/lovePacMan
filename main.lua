PPM = 1
VW = 448
VH = 576
BLOCKSIZE = 16
MAP = nil
MAPSHEET = {}
FRUITSHEET = {}
MAPATLAS= nil
FRUITATLAS = nil
DEBUG = false
DOTS = 244
PAUSE = false
TITLESCREEN  = nil
CURRENTSTATE = 'title'
LEVEL=1
READYTIMER = 4.5
FONT = nil
HIGHSCORE = {}
CATCHPOINT = {200,400,800,1600,12000}

DEBUG_PLACEHOLDER = 0
SOUNDVOL = 1
S_INTRO, S_DOT, S_DEATH, S_EATGHOST, S_READY =  nil


function love.load(arg)
  love.math.setRandomSeed(love.timer.getTime())
  love.graphics.setDefaultFilter('nearest')
  love.keyboard.setKeyRepeat(true)

  require"pacMan"
  require"ghosts"
  require"pacManStates"
  require"levelSpec"
  getMaps = require('map')
  
  if arg[#arg] == "-debug" then
    DEBUG_PLACEHOLDER = 300
    DEBUG = true
    print('\n')
  end
  
  love.window.setMode((PPM * VW)   + DEBUG_PLACEHOLDER  , PPM * VH)
  love.window.setTitle('LovePacMan')

  FONT = love.graphics.newFont('assets/fonts/emulogic.ttf', 8)
  love.graphics.setFont(FONT)
  
  TITLESCREEN = love.graphics.newImage('assets/img/title.png')
  
  FRUITATLAS= love.graphics.newImage('assets/img/fruits.png')
  FRUITSHEET['cherries']= love.graphics.newQuad(0*16, 0, 16, 16, FRUITATLAS:getDimensions())
  FRUITSHEET['strawberry']= love.graphics.newQuad(1*16, 0, 16, 16, FRUITATLAS:getDimensions())
  FRUITSHEET['peach']= love.graphics.newQuad(2*16, 0, 16, 16, FRUITATLAS:getDimensions())
  FRUITSHEET['apple']= love.graphics.newQuad(3*16, 0, 16, 16, FRUITATLAS:getDimensions())
  FRUITSHEET['grapes']= love.graphics.newQuad(4*16, 0, 16, 16, FRUITATLAS:getDimensions())
  FRUITSHEET['bell']= love.graphics.newQuad(5*16, 0, 16, 16, FRUITATLAS:getDimensions())
  FRUITSHEET['galaxian']= love.graphics.newQuad(6*16, 0, 16, 16, FRUITATLAS:getDimensions())
  FRUITSHEET['key']= love.graphics.newQuad(6*16, 0, 16, 16, FRUITATLAS:getDimensions())
  
  MAPATLAS = love.graphics.newImage('assets/img/pacmanSpriteSheet.png')
  MAPSHEET[1] = love.graphics.newQuad(0*16, 0, 16, 16, MAPATLAS:getDimensions())
  MAPSHEET[2] = love.graphics.newQuad(1*16, 0, 16, 16, MAPATLAS:getDimensions())
  MAPSHEET[3] = love.graphics.newQuad(2*16, 0, 16, 16, MAPATLAS:getDimensions())
  MAPSHEET[4] = love.graphics.newQuad(3*16, 0, 16, 16, MAPATLAS:getDimensions())
  MAPSHEET[5] = love.graphics.newQuad(4*16, 0, 16, 16, MAPATLAS:getDimensions())
  MAPSHEET[6] = love.graphics.newQuad(5*16, 0, 16, 16, MAPATLAS:getDimensions())
  MAPSHEET[9] = love.graphics.newQuad(6*16, 0, 16, 16, MAPATLAS:getDimensions())
  MAPSHEET[8] = love.graphics.newQuad(7*16, 0, 16, 16, MAPATLAS:getDimensions())
  
  S_INTRO = love.audio.newSource('assets/sfx/pacman_beginning.wav', 'static')
  S_DOT = love.audio.newSource('assets/sfx/pacman_chomp.wav', 'static')
  S_DEATH = love.audio.newSource('assets/sfx/pacman_death.wav', 'static')
  S_EATGHOST= love.audio.newSource('assets/sfx/pacman_eatghost.wav', 'static')
  S_EATFRUIT= love.audio.newSource('assets/sfx/pacman_eatfruit.wav', 'static')
  S_READY = love.audio.newSource('assets/sfx/pacman_intermission.wav', 'static')
  S_EXTRA = love.audio.newSource('assets/sfx/pacman_extrapac.wav', 'static')
  -- S_DEATH_DUR = S_DEATH:getDuration('seconds')
  
  getHighScore()

  S_INTRO:play()

end

function love.update(dt)
  if PAUSE then return end
  pacMan_states[CURRENTSTATE].update(dt)
end

function love.draw()
  pacMan_states[CURRENTSTATE].draw()
end

function love.keypressed(key, scancode, isRepeat)
  if key == 'm' then
    if SOUNDVOL == 1 then SOUNDVOL = 0 else SOUNDVOL = 1 end
    love.audio.setVolume (SOUNDVOL)
  end
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
      local fruitChar = FRUIT[j][i]
      if fruitChar >0   then
        love.graphics.draw(
          FRUITATLAS,FRUITSHEET[levelSpec[LEVEL].bonus],
          ii*BLOCKSIZE*PPM + BLOCKSIZE*PPM*0.5,
          jj*BLOCKSIZE*PPM + BLOCKSIZE*PPM*0.5,
          0, PPM*1.6, PPM*1.6,
          16*0.5, 16*0.5
        )
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

function clamp (val, min, max)
  if val < min then return min
  elseif val > max then return max
  else  return val 
  end
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
  local f = io.open('highscore.score', 'w+')
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

function getHighScore()
  if fileExists( 'highscore.score' ) then
    HIGHSCORE = linesFrom('highscore.score')
  else
    local f = io.open('highscore.score', 'w')
    f:write('0')
    f:close()
    HIGHSCORE = {0}
  end
end
