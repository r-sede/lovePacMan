pacMan_states = {}

pacMan_states.game = {}
pacMan_states.title = {}


pacMan_states.game.load = function (arg)
  MAP,OBSTACLE,COLLECTABLE,FRUIT = getMaps('map')
  READYTIMER = 5
  LEVEL = 1
  pacMan.life = 2
  pacMan.score = 0
  pacMan:init()
  g_red:init()
  DOTS = 244
  S_INTRO:stop()
  S_READY:play()
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

  S_DEATH:play()
  pacMan.life = pacMan.life - 1
  if pacMan.life < 0 then
    if pacMan.score > HIGHSCORE[1] then
      writeScore()
      HIGHSCORE[1] = pacMan.score
    end
    pacMan_states.setState('title')
  end
  pacMan:init()
  g_red:init()
  READYTIMER = 3
end

pacMan_states.game.addBonus = function ()
  local rx,ry = g_red.x, g_red.y
  if not(rx > 11 and rx < 17 and ry > 16 and ry < 20) then
    FRUIT[round(ry)][round(rx)] = 1
  end
end

pacMan_states.game.draw = function ()
  drawMap()
  pacMan:draw()
  g_red:draw()
  --score etc
  love.graphics.print('HIGH SCORE', PPM * VW * 0.33, 0,0,2*PPM,2*PPM)
  love.graphics.print(math.max(HIGHSCORE[1],pacMan.score) , PPM * VW * 0.40, 23*PPM,0,2*PPM,2*PPM)
  love.graphics.print('1UP', PPM * VW * 0.025, 0,0,2*PPM,2*PPM)
  love.graphics.print(pacMan.score, PPM * VW * 0.05, 23*PPM,0,2*PPM,2*PPM)
  for i=1,pacMan.life do 
    love.graphics.draw(pacMan.atlas, pacMan.sprites[1],PPM * VW * 0.05+(PPM*32*i), VH*PPM-32*PPM,0,0.8*PPM,0.8*PPM)
  end
  if READYTIMER >= 0 then
    love.graphics.setColor(240,240,0,1)
    love.graphics.print('READY!', (14.5 -3)*PPM*BLOCKSIZE,  20*PPM*BLOCKSIZE,0,2*PPM,1.5*PPM)
    love.graphics.setColor(1,1,1,1)
  end
  if PAUSE then
    love.graphics.setColor(240,240,0,1)
    love.graphics.print('PAUSE!', (14.5 -4.5)*PPM*BLOCKSIZE,  17*PPM*BLOCKSIZE,0,3*PPM,3*PPM)
    love.graphics.setColor(1,1,1,1)
  end
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

  if key == 'escape' then pacMan_states.setState('title') end
  if key == 'd' then
    if not DEBUG then DEBUG = true else DEBUG = false end

  end

  
  if key == 'space' then
    if not PAUSE then PAUSE = true else PAUSE = false end
  end
end
-----------------------------------------
---------------TITLE---------------------
-----------------------------------------
MENU = {'scores','play','credit' }
MENUCURSOR = 1
MENUPOS = 
{
  {(VW*PPM*0.35) - (20*PPM) , VH*0.5*PPM},
  {(VW*PPM*0.35) - (20*PPM) , (VH*0.5*PPM) +(32*PPM)},
  {(VW*PPM*0.35) - (20*PPM) , (VH*0.5*PPM) +(64*PPM)}
}

pacMan_states.title.load = function(arg)
 --start music
 MENUCURSOR = 1
end

pacMan_states.title.exit = function()
  --endMusic
end

pacMan_states.title.update = function(dt)
  
end

pacMan_states.title.draw = function(arg)
  love.graphics.draw(TITLESCREEN, 0, 0, 0, 2*PPM, 2*PPM)
  love.graphics.print(HIGHSCORE[1], PPM * VW * 0.40, 23*PPM,0,2*PPM,2*PPM)
  love.graphics.print(MENU[1], VW*PPM*0.35, VH*0.5*PPM, 0, 2*PPM, 2*PPM)
  love.graphics.print(MENU[2], VW*PPM*0.35,  (VH*0.5*PPM) +(32*PPM), 0, 2*PPM, 2*PPM)
  love.graphics.print(MENU[3], VW*PPM*0.35,  (VH*0.5*PPM) +(64*PPM), 0, 2*PPM, 2*PPM)
  love.graphics.print('>', MENUPOS[MENUCURSOR][1],MENUPOS[MENUCURSOR][2],0,2*PPM,2*PPM)
end

pacMan_states.title.keypressed = function(key)
  if key == 'return' then
    --if MENUCURSOR == 1 then pacMan_states.setState('scores') end
    if MENUCURSOR == 2 then pacMan_states.setState('game') end
    if MENUCURSOR == 3 then return end
  end
  if key == 'escape' then love.event.quit() end
  if key == 'up' then
    MENUCURSOR = MENUCURSOR - 1
    if MENUCURSOR < 1 then MENUCURSOR = #MENU end
  end
  if key == 'down' then
    MENUCURSOR = MENUCURSOR + 1
    if MENUCURSOR > #MENU then MENUCURSOR = 1 end
  end
end

pacMan_states.setState = function(state)
  pacMan_states[CURRENTSTATE].exit()
  CURRENTSTATE = state
  pacMan_states[CURRENTSTATE].load()
end