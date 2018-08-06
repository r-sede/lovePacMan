pacMan = 
  {
    x = 14.5, y = 24+3,
    life = 2,
    score = 0,
    isOnPillEffect = false,
    timer = 0,
    speed = 8,
    speedCoef = 0.8,
    dirX = 0,
    dirY = 0,
    direction = "start",
    keyframe=1,
    nbrFrame=4,
    fps=10,
    angle=0,
    scaleSignX= 1,
    scaleSignY= 1,
    succCatch = 0
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
    if val.timer >= levelSpec[LEVEL].frightTime then
      val.isOnPillEffect = false
      val.succCatch = 0
    end
  end

  local rndX = round (val.x)
  local rndY = round (val.y)
  if rndX < 3 and rndY == 18 then val.x = 26 return end
  if rndX > 27 and rndY == 18 then val.x = 4 return end

  local collectableChar = COLLECTABLE[rndY][rndX]
  if collectableChar > 0 then
    COLLECTABLE[rndY][rndX] = 0;
    val:collect(collectableChar)
  end

  local fruitChar = FRUIT[rndY][rndX]
  if fruitChar > 0 then
    FRUIT[rndY][rndX] = 0;
    val:collect('bonus')
  end


  if(val.direction=="left") then
    if OBSTACLE[rndY][rndX-1] >0 then
      val.dirX = 0
      val.x = rndX
    end
  end

  if(val.direction=="right") then
    if OBSTACLE[rndY][rndX+1] >0 then
      val.dirX = 0
      val.x = rndX
    end
  end

  if(val.direction=="up") then
    if OBSTACLE[rndY-1][rndX] >0 then
      val.dirY = 0
      val.y = rndY
    end
  end

  if(val.direction=="down") then
    if OBSTACLE[rndY+1][rndX] >0 then
      val.dirY = 0
      val.y = rndY
    end
  end

  val.x = val.x + dt * val.speed * val.speedCoef * val.dirX
  val.y = val.y + dt * val.speed * val.speedCoef * val.dirY

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
    love.graphics.print('x: '..val.x.. ' ; y: '..val.y, (VW*PPM)+10, 10,0,PPM)
    love.graphics.print('score '..val.score, (VW*PPM)+10, 33,0,PPM)
    love.graphics.print('dir: '..val.direction, (PPM*VW)+10, 20,0,PPM)
  end  

end

function pacMan.init(val)
  val.x = 14.5
  val.y = 24+3
  val.isOnPillEffect = false
  val.timer = 0
  val.speedCoef = levelSpec[LEVEL].pacManSpeed
  val.dirX = 0
  val.dirY = 0
  val.direction = "start"
  val.keyframe = 1
  val.angle = 0
  val.scaleSignX = 1
  val.scaleSignY = 1
  val.succCatch = 0
end


function pacMan.collect(val, item)
  if not S_DOT:isPlaying() then S_DOT:play() end

  if item == 'bonus' then
    val.score = val.score + levelSpec[LEVEL].bonusPoints
    S_EATFRUIT:play()
  elseif item == 8 then
    val.score = val.score + 10
    DOTS = DOTS - 1

    --reagarder si on gagne une vie
  elseif item == 9 then
    val.score = val.score + 50
    val.isOnPillEffect = true
    val.timer = 0
    g_red.timer = 0
    g_pink.timer = 0
    g_blue.timer = 0
    g_red.blinkTime = 0
    g_pink.blinkTime = 0
    g_blue.blinkTime = 0
    g_red.blink = false
    g_pink.blink = false
    g_blue.blink = false
    val.speedCoef = levelSpec[LEVEL].pacManFrightSpeed
    setState(g_red, 'fright')
    setState(g_pink, 'fright')
    setState(g_blue, 'fright')
    DOTS = DOTS - 1

  end
  if DOTS <= 0 then
    LEVEL = LEVEL + 1
    if LEVEL >= 21 then LEVEL = 21 end
    pacMan:init()
    g_red:init()
    g_pink:init()
    g_blue:init()
    g_red.chaseIter = 1
    g_pink.chaseIter = 1
    g_blue.chaseIter = 1
    g_red.scatterIter = 1
    g_pink.scatterIter = 1
    g_blue.scatterIter = 1
    MAP,OBSTACLE,COLLECTABLE,FRUIT = getMaps('map')
    READYTIMER = 4.5
    DOTS = 244

    S_READY:play()
  elseif DOTS == 244 - 70 or DOTS == 244 - 170 then
    pacMan_states.game.addBonus()
  end


end

function pacMan.left(val)
  local rndX = round( val.x )
  local rndY = round( val.y )
  if OBSTACLE[rndY][rndX-1] == 0 then
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
  if OBSTACLE[rndY][rndX+1] == 0 then
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
  if OBSTACLE[rndY-1][rndX] == 0 then
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
  if OBSTACLE[rndY+1][rndX] == 0 then
    val.dirX = 0
    val.dirY = 1
    val.x = rndX
    val.direction = 'down'
  end
  --val.dirY = 0
end
