pacMan_states = {}

pacMan_states.game = {}
pacMan_states.title = {}


pacMan_states.game.load = function (arg)
  MAP,OBSTACLE,COLLECTABLE = getMaps('map')
  READYTIMER = 3
  LEVEL = 1
  pacMan.life = 3
  pacMan.score = 0
  pacMan:init()
  g_red:init()
end

pacMan_states.game.exit = function ()

end

pacMan_states.game.update = function (dt)
  if READYTIMER >= 0 then 
    READYTIMER = READYTIMER - dt
    return
  end
  animate(pacMan, dt)
  animate(g_red, dt)
  handleDirection(pacMan)
  handleDirection(g_red)
  pacMan:update(dt)
  g_red:update(dt)

end

pacMan_states.game.catch = function ()
  pacMan.life = pacMan.life - 1
  if pacMan.life < 0 then
    pacMan_states.setState('title')
  end
  pacMan:init()
  g_red:init()
  READYTIMER = 3
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

pacMan_states.title.load = function(arg)
 --start music
end

pacMan_states.title.exit = function()
  --endMusic
end

pacMan_states.title.update = function(dt)
  
end

pacMan_states.title.draw = function(arg)
  love.graphics.draw(TITLESCREEN, 0, 0, 0, 2, 2)
end

pacMan_states.title.keypressed = function(key)
  if key == 'return' then
    pacMan_states.setState('game')
  end
  if key == 'escape' then love.event.quit() end
  
end




pacMan_states.setState = function(state)
  pacMan_states[CURRENTSTATE].exit()
  CURRENTSTATE = state
  pacMan_states[CURRENTSTATE].load()
end