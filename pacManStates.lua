pacMan_states = {}

pacMan_states.game = {}
pacMan_states.game.load = function (arg)

end

pacMan_states.game.update = function (dt)
  animate(pacMan, dt)
  animate(g_red, dt)
  handleDirection(pacMan)
  handleDirection(g_red)
  pacMan:update(dt)
  g_red:update(dt)
end

pacMan_states.game.draw = function ()
    drawMap()
  pacMan:draw()
  g_red:draw()
end

pacMan_states.game.keypressed = function (key)
    -- print('tile ',MAP[math.floor( pacMan.y )][math.floor(pacMan.x)])
  if key == 'left'  then
    if love.keyboard.isDown('lshift') then
      pacMan.x = pacMan.x - 0.1
    else
      pacMan:left()
    end
  end

  if key == 'right'  then 
    if love.keyboard.isDown('lshift') then
      pacMan.x = pacMan.x + 0.1
    else
      pacMan:right()
    end
  end

  if key == 'up'  then
    if love.keyboard.isDown('lshift') then
      pacMan.y = pacMan.y - 0.1
    else
      pacMan:up()
    end
  end

  if key == 'down'  then
    if love.keyboard.isDown('lshift') then
      pacMan.y = pacMan.y + 0.1
    else
      pacMan:down()
    end
  end

  if key == 'escape' then love.event.quit() end
  if key == 'q' then g_red.direction = "left" end
  if key == 'd' then g_red.direction = "right" end
  if key == 'z' then g_red.direction = "up" end
  if key == 's' then g_red.direction = "down" end
end