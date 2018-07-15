pacMan = 
  {
    x = 14.5, y = 24,
    life = 3,
    score = 0,
    isOnPillEffect = false,
    timer = 0,
    speed = 6,
    dirX = 0,
    dirY = 0,
    direction = "start",
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

  local rndX = round (val.x)
  local rndY = round (val.y)

  if(val.direction=="left") then
    if MAP[rndY][rndX-1] < 7 then
      val.dirX = 0
      val.x = rndX
    end
  end

  if(val.direction=="right") then
    if MAP[rndY][rndX+1] < 7 then
      val.dirX = 0
      val.x = rndX
    end
  end

  if(val.direction=="up") then
    if MAP[rndY-1][rndX] < 7 then
      val.dirY = 0
      val.y = rndY
    end
  end

  if(val.direction=="down") then
    if MAP[rndY+1][rndX] < 7 then
      val.dirY = 0
      val.y = rndY
    end
  end

  val.x = val.x + dt * val.speed * val.dirX
  val.y = val.y + dt * val.speed * val.dirY

end



function pacMan.draw(val)
  love.graphics.draw(val.atlas, val.sprites[val.keyframe],
  (val.x-1)*BLOCKSIZE*PPM + BLOCKSIZE*PPM*0.5,
  (val.y-1)*BLOCKSIZE*PPM + BLOCKSIZE*PPM*0.5,
  val.angle,
  val.scaleSignX * PPM * 0.8,
  val.scaleSignY * PPM * 0.8,
  36*0.5,
  36*0.5)

  if(DEBUG) then
    love.graphics.circle('line', (val.x-1)*BLOCKSIZE*PPM + BLOCKSIZE*PPM*0.5, (val.y-1)*BLOCKSIZE*PPM + BLOCKSIZE*PPM*0.5, BLOCKSIZE*PPM*0.8,8)
    love.graphics.rectangle('fill', round(val.x-1)*BLOCKSIZE*PPM,round( val.y-1 )*BLOCKSIZE*PPM, BLOCKSIZE*PPM, BLOCKSIZE * PPM )
    love.graphics.print('dir: '..val.direction, (PPM*VW)+10, 20)
    love.graphics.print('x: '..pacMan.x.. ' ; y: '..pacMan.y, (VW*PPM)+10, 10)
  end  

end

function pacMan.init(val)
  val.x = 14.5
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
  local rndX = round( val.x )
  local rndY = round( val.y )
  if MAP[rndY][rndX-1] > 7 then
    val.dirX = -1
    val.dirY = 0
    val.y = rndY
    val.direction = 'left'
  end
  --val.dirX = 0
end

function pacMan.right(val)
  local rndX = round( val.x )
  local rndY = round( val.y )
  if MAP[rndY][rndX+1] > 7 then
    val.dirX = 1
    val.dirY = 0
    val.y = rndY
    val.direction = 'right'
  end
  --val.dirX = 0
end
function pacMan.up(val)
  local rndX = round( val.x )
  local rndY = round( val.y )
  if MAP[rndY-1][rndX] > 7 then
    val.dirX = 0
    val.dirY = -1
    val.x = rndX
    val.direction = 'up'
  end
  --val.dirY = 0
end
function pacMan.down(val)
  local rndX = round( val.x )
  local rndY = round( val.y )
  if MAP[rndY+1][rndX] > 7 then
    val.dirX = 0
    val.dirY = 1
    val.x = rndX
    val.direction = 'down'
  end
  --val.dirY = 0
end
