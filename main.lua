PPM = 1
VW = 448
VH = 496
MAP = nil;



function love.load()
  love.window.setMode(PPM * VW, PPM * VH)
  love.keyboard.setKeyRepeat(true)
  MAP = require('map')
end

function love.update(dt)
end

function love.draw()
  for j=1,#MAP do
    for i=1,#MAP[j] do
      love.graphics.print(MAP[j][i],(i-1)*14,(j-1)*14)
    end
  end
end

function love.keypressed(key, scancode, isRepeat)

end

-- maTable={class="sss",closs="ppp"}
-- for k,v in ipairs(maTable) do 
--   print(k,' ; ',v)
-- end