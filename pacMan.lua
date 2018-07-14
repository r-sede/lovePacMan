pacMan = {x = 15, y = 24 , life = 3 , score = 0 , isOnPillEffect = false , timer = 0 , speed = 20 , direction = "left" }
function pacMan.update(val,dt)
  if val.isOnPillEffect == true then
    val.timer = val.timer + dt
    if val.timer >= 8 then
      val.isOnPillEffect = false
    end
  end
end
function pacMan.draw(val)
  love.graphics.circle("line",(val.x-1)*16,(val.y-1)*16,36/16)
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