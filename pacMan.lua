pacMan = 
  {
    x = 14.5, y = 24,
    life = 3,
    score = 0,
    isOnPillEffect = false,
    timer = 0,
    speed = 8,
    dirX = 0,
    dirY = 0,
    direction = "left",
    keyframe=1,
    nbrFrame=4,
    fps=10,
    angle=0,
    scaleSignX= 1;
    scaleSignY= 1;
  }
pacMan.animTimer = 1 /pacMan.fps
pacMan.atlas= love.graphics.newImage('assets/img/pacManLana.png');
pacMan.sprites = {
  love.graphics.newQuad(0*36,0,36,36,pacMan.atlas:getDimensions()),
  love.graphics.newQuad(1*36,0,36,36,pacMan.atlas:getDimensions()),
  love.graphics.newQuad(2*36,0,36,36,pacMan.atlas:getDimensions()),
  love.graphics.newQuad(3*36,0,36,36,pacMan.atlas:getDimensions()),
  }



function pacMan.update(val,dt)
  if val.isOnPillEffect == true then
    val.timer = val.timer + dt
    if val.timer >= 8 then
      val.isOnPillEffect = false
    end
  end

  local rndX = math.floor( val.x )
  local rndY = math.floor( val.y )
  local ceilX = math.floor( val.x + 0.5 )
  local ceilY = math.floor( val.y + 0.5 )
  -- print(MAP[rndY][rndX])
  if val.direction == 'left' then
    if MAP[rndY][ceilX-1] < 8 then
      val.dirX = 0
      val.dirY = 0
      val.x = rndX
      return
    end
  elseif val.direction == 'right' then
    if MAP[rndY][rndX+1] < 8 then
      val.dirX = 0
      val.dirY = 0
      val.x = rndX
      return
    end
  elseif val.direction == 'up' then
    if MAP[ceilY-1][rndX] < 8 then
      val.dirX = 0
      val.dirY = 0
      val.y = rndY
      return
    end
  elseif val.direction == 'down' then
    if MAP[rndY+1][rndX] < 8 then
      val.dirX = 0
      val.dirY = 0
      val.y = rndY
      return
    end
  end

  val.x = val.x + dt * val.speed * val.dirX
  val.y = val.y + dt * val.speed * val.dirY

end
function pacMan.draw(val)
  --love.graphics.circle("line", (val.x-1)*BLOCKSIZE*PPM + BLOCKSIZE*PPM*0.5, (val.y-1)*BLOCKSIZE*PPM + BLOCKSIZE*PPM*0.5, BLOCKSIZE*PPM,8)
  love.graphics.draw(val.atlas, val.sprites[val.keyframe],
    (val.x-1)*BLOCKSIZE*PPM + BLOCKSIZE*PPM*0.5,
    (val.y-1)*BLOCKSIZE*PPM + BLOCKSIZE*PPM*0.5,
    val.angle,
    val.scaleSignX * PPM * 0.8,
    val.scaleSignY * PPM * 0.8,
    36*0.5,
    36*0.5
  )
  -- local rndX = math.floor( val.x )
  -- local rndY = math.floor( val.y )
  -- love.graphics.rectangle('line',(rndX - 1)*PPM*BLOCKSIZE, (rndY-1)*PPM*BLOCKSIZE, BLOCKSIZE*PPM, BLOCKSIZE*PPM )
  love.graphics.print('dir: '..val.direction, 10, 20)
end
function pacMan.init(val)
  val.x = 15
  val.y = 24
  val.isOnPillEffect = false
  val.timer = 0
end


function pacMan.collect(val,item)
  if item == "p" then
    val.score = val.score + 10
    --reagarder si on gagne une vie
  elseif item == "0" then
    val.isOnPillEffect = true
    val.timer = 0
  end
end

function pacMan.left(val)
  local rndX = math.floor( val.x )
  local rndY = math.floor( val.y )
  if MAP[rndY][rndX-1] > 7 then
    val.dirX = -1
    val.dirY = 0
    val.y = rndY
    val.direction = 'left'
  end
  --val.dirX = 0
end

function pacMan.right(val)
  local rndX = math.floor( val.x )
  local rndY = math.floor( val.y )
  if MAP[rndY][rndX+1] > 7 then
    val.dirX = 1
    val.dirY = 0
    val.y = rndY
    val.direction = 'right'
  end
  --val.dirX = 0
end
function pacMan.up(val)
  local rndX = math.floor( val.x )
  local rndY = math.floor( val.y )
  if MAP[rndY-1][rndX] > 7 then
    val.dirX = 0
    val.dirY = -1
    val.x = rndX
    val.direction = 'up'
  end
  --val.dirY = 0
end
function pacMan.down(val)
  local rndX = math.floor( val.x )
  local rndY = math.floor( val.y )
  if MAP[rndY+1][rndX] > 7 then
    val.dirX = 0
    val.dirY = 1
    val.x = rndX
    val.direction = 'down'
  end
  --val.dirY = 0
end