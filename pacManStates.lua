pacMan_states = {}

pacMan_states.game = {}
pacMan_states.game.load = function (arg)

end

pacMan_states.game.exit = function ()

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
    pacMan:left()
  end

  if key == 'right'  then 
    pacMan:right()
  end

  if key == 'up'  then
      pacMan:up()
  end

  if key == 'down'  then
    pacMan:down()
  end

  if key == 'escape' then love.event.quit() end
  if key == 'd' then
    if not DEBUG then DEBUG = true else DEBUG = false end

  end

  if key == 'm' then --[[ mute ]] end
  if key == 'space' then
    if not PAUSE then PAUSE = true else PAUSE = false end
  end
end

pacMan_states.setState = function(state)
  pacMan_states[CURRENTSTATE].exit()
  CURRENTSTATE = state
  pacMan_states[CURRENTSTATE].load()

end