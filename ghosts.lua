local function getNextTileObs(val)
  if val.direction == "left" then
    return getTile(OBSTACLE, round(val.x) -1, round(val.y))
  elseif val.direction == 'right' then
    return getTile(OBSTACLE, round(val.x) +1, round(val.y))
  elseif val.direction == 'up' then 
    return getTile(OBSTACLE, round(val.x), round(val.y)-1)
  elseif val.direction == 'down' then 
    return getTile(OBSTACLE, round(val.x), round(val.y)+1)
  end
end

local function getNextTile(val)
  if val.direction == "left" then
  elseif val.direction == 'right' then
    return round(val.x) +1, round(val.y)
  elseif val.direction == 'up' then 
    return round(val.x), round(val.y)-1
  elseif val.direction == 'down' then 
    return round(val.x), round(val.y)+1
  end
end

local frightAtlas = love.graphics.newImage('assets/img/fantomesPacman5.png')


local function update(val, dt)
  if love.keyboard.isDown('x') then val.state = "fright" else val.state = "chase" end

  if val.state == "fright" then
    val.curAtlas = "frightAtlas"
    val.animDir = "fright"
  else
    val.curAtlas = "atlas"
    val.animDir = val.direction
  end

  local nextTileX, nextTileY = getNextTile(val);

  val.x = val.x + dt * val.speed * val.speedCoef * val.dirX
  val.y = val.y + dt * val.speed * val.speedCoef * val.dirY
end

local function draw(val)
  love.graphics.draw(val[val.curAtlas], val.sprites[val.animDir][val.keyframe],
  (val.x-1)*BLOCKSIZE*PPM + BLOCKSIZE*PPM*0.5,
  (val.y-1)*BLOCKSIZE*PPM + BLOCKSIZE*PPM*0.5,
  val.angle,
  val.scaleSignX * PPM * 1.6,
  val.scaleSignY * PPM * 1.6,
  16*0.5,
  16*0.5)
end

local function setTarget(val, x,y)
  val.targetX = x
  val.targetY = y
end

local function distance ( x1, y1, x2, y2 )
  local dx = x1 - x2
  local dy = y1 - y2
  return math.sqrt ( dx * dx + dy * dy )
end

---------------------------------------------------------------------------
---------------------------------RED---------------------------------------

g_red = {
    startX=14.5, startY=12,
    x=14.5, y=12,
    timer = 0,
    speed = 8,
    speedCoef = 0.8,
    dirX = 0,
    dirY = 0,
    direction = "up",
    animDir = "up",
    curAtlas = "atlas",
    keyframe=1,
    nbrFrame=2,
    fps=10,
    angle=0,
    scaleSignX= 1,
    scaleSignY= 1,
    state = "chase",
    targetX = 2,
    targetY = 2,
    speedCoef = 0.5,
    nextDecision = "up",
  }
  g_red.animTimer = 1 /g_red.fps
  g_red.atlas= love.graphics.newImage('assets/img/fantomesPacman4.png')
  g_red.frightAtlas = frightAtlas
  g_red.sprites = {}
  g_red.sprites.right = {
    love.graphics.newQuad(4*16,0,16,16,g_red.atlas:getDimensions()),
    love.graphics.newQuad(1*16,0,16,16,g_red.atlas:getDimensions()),
  }
  g_red.sprites.down = {
    love.graphics.newQuad(2*16,0,16,16,g_red.atlas:getDimensions()),
    love.graphics.newQuad(1*16,0,16,16,g_red.atlas:getDimensions()),
  }
  g_red.sprites.left = {
    love.graphics.newQuad(4*16,0,16,16,g_red.atlas:getDimensions()),
    love.graphics.newQuad(1*16,0,16,16,g_red.atlas:getDimensions()),
  }
  g_red.sprites.up = {
    love.graphics.newQuad(6*16,0,16,16,g_red.atlas:getDimensions()),
    love.graphics.newQuad(1*16,0,16,16,g_red.atlas:getDimensions()),
  }
  g_red.sprites.fright = {
    love.graphics.newQuad(0*16,0,16,16,frightAtlas:getDimensions()),
    love.graphics.newQuad(1*16,0,16,16,frightAtlas:getDimensions()),
  }


g_red.draw = function(val)
  draw(val)
end

g_red.update = function(val, dt)
  update(val, dt)
end

g_red.setTarget = function(val, x,y)
  setTarget(val, x, y)
end

g_red.getNextTile = function(val)
  getNextTile(val)
end