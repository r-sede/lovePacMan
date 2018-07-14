PPM = 1
VW = 448
VH = 496
BLOCKSIZE = 16;
MAP = nil;


function love.load()
  require"pacMan"
  love.window.setMode(PPM * VW, PPM * VH)
  love.keyboard.setKeyRepeat(true)
  MAP = require('map')
end

function love.update(dt)
end

function love.draw()
  for j=1,#MAP do
    for i=1,#MAP[j] do
      love.graphics.print(MAP[j][i],(i-1)*16,(j-1)*16)
    end
  end
  pacMan:draw()
end

function love.keypressed(key, scancode, isRepeat)

end

-- maTable={class="sss",closs="ppp"}
-- for k,v in ipairs(maTable) do 
--   print(k,' ; ',v)
-- end