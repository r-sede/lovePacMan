pacMan = {x = 14.5, y = 24 , life = 3 , score = 0 , isOnPillEffect = false , timer = 0 , speed = 20 , direction = "left", keyframe=0 }
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
end
function pacMan.draw(val)
  --love.graphics.circle("line", (val.x-1)*BLOCKSIZE*PPM + BLOCKSIZE*PPM*0.5, (val.y-1)*BLOCKSIZE*PPM + BLOCKSIZE*PPM*0.5, BLOCKSIZE*PPM,8)
  love.graphics.draw(val.atlas,val.sprites[1],
    (val.x-1)*BLOCKSIZE*PPM + BLOCKSIZE*PPM*0.5,
    (val.y-1)*BLOCKSIZE*PPM + BLOCKSIZE*PPM*0.5,
    0,
    -PPM,
    PPM,
    36*0.5,
    36*0.5
  )
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